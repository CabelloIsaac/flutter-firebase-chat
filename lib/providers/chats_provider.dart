import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];
  Chat _chat;
  List<Message> _messages = [];
  bool _isListeningAllChats = false;
  bool _isListeningSingleChat = false;
  bool _isListeningMessages = false;
  StreamSubscription<QuerySnapshot> _chatsSubscription;
  StreamSubscription<QuerySnapshot> _messagesSubscription;
  StreamSubscription<DocumentSnapshot> _chatSubscription;

  List<Chat> get chats => _chats;
  Chat get chat => _chat;
  List<Message> get messages => _messages;

  set chats(List<Chat> value) {
    _chats = value;
    notifyListeners();
  }

  set chat(Chat value) {
    if (chat == null || chat.id != value.id) {
      if (_chatSubscription != null) _chatSubscription.cancel();
      _isListeningSingleChat = false;
    }
    _chat = value;
    loadChat();
    loadChatMessages();
    notifyListeners();
  }

  set messages(List<Message> value) {
    _messages = value;
    notifyListeners();
  }

  void loadChats() {
    print("loadChats");
    if (!_isListeningAllChats) {
      print("_isListeningAllChats = false");
      String userId = AuthProvider.getCurrentUserUid();
      _chatsSubscription = FirebaseFirestore.instance
          .collection("chats")
          .where("participants", arrayContains: userId)
          .snapshots()
          .listen((documents) {
        chats = documents.docs
            .map((e) => Chat.fromJson(id: e.id, data: e.data()))
            .toList();
      });
      _isListeningAllChats = true;
    }
  }

  void loadChat() {
    print("loadChat");
    if (!_isListeningSingleChat) {
      print("_isListeningSingleChat = false");
      _chatSubscription = FirebaseFirestore.instance
          .collection("chats")
          .doc(chat.id)
          .snapshots()
          .listen((document) {
        chat = Chat.fromJson(id: document.id, data: document.data());
      });
      _isListeningSingleChat = true;
    }
  }

  void loadChatMessages() {
    print("loadChatMessages");
    if (!_isListeningMessages) {
      print("_isListeningMessages = false");
      _chatsSubscription = FirebaseFirestore.instance
          .collection("chats")
          .doc(chat.id)
          .collection("messages")
          .orderBy("timestamp", descending: true)
          .snapshots()
          .listen((documents) {
        messages = documents.docs
            .map((e) => Message.fromJson(id: e.id, data: e.data()))
            .toList();
      });
      _isListeningMessages = true;
    }
  }

  void createTestChat() {
    String userId = AuthProvider.getCurrentUserUid();
    FirebaseFirestore.instance.collection("chats").add({
      "type": "chat",
      "participants": [userId, "id2"],
      "participantsData": [
        {"id": userId, "name": "Isaac", "lastName": "Cabello", "avatar": "url"},
        {
          "id": "id2",
          "name": "Dua",
          "lastName": "Lipa",
          "avatar":
              "https://e00-elmundo.uecdn.es/assets/multimedia/imagenes/2021/03/15/16157897316294.jpg"
        }
      ],
      "lastMessage": {
        "from": userId,
        "body": "Este es el ultimo mensaje",
        "timestamp": FieldValue.serverTimestamp(),
        "type": "text",
      }
    });
  }

  void sendTextMessage(Message message) {
    print("Sending message");
    Map<String, dynamic> messageMap = message.toJson();
    messageMap["timestamp"] = FieldValue.serverTimestamp();
    _addMessageToChat(messageMap);
  }

  void sendImageMessage(Message message, File image) async {
    print("Sending message");
    Map<String, dynamic> messageMap = message.toJson();
    messageMap["timestamp"] = FieldValue.serverTimestamp();

    String url = await uploadFile(image, "images", "jpg");
    messageMap["body"] = url;

    _addMessageToChat(messageMap);
  }

  void sendAudioMessage(Message message, File audio) async {
    print("Sending message");
    Map<String, dynamic> messageMap = message.toJson();
    messageMap["timestamp"] = FieldValue.serverTimestamp();

    String url = await uploadFile(audio, "audio", "aac");
    messageMap["body"] = url;

    _addMessageToChat(messageMap);
  }

  Future<String> uploadFile(File file, String type, String ext) async {
    String userId = AuthProvider.getCurrentUserUid();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String storagePath = 'chats/${chat.id}/$type/$userId-$timestamp.$ext';
    Reference storageReference =
        FirebaseStorage.instance.ref().child(storagePath);
    UploadTask uploadTask = storageReference.putFile(file);
    TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    String url = await downloadUrl.ref.getDownloadURL();
    return url;
  }

  void _addMessageToChat(Map<String, dynamic> messageMap) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(chat.id)
        .collection("messages")
        .add(messageMap);
    _updateLastMessageOnChat(messageMap);
  }

  void _updateLastMessageOnChat(messageMap) {
    FirebaseFirestore.instance.collection("chats").doc(chat.id).update({
      "lastMessage": messageMap,
    });
  }
}
