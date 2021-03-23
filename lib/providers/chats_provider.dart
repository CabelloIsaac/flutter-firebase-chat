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
  bool _chatExists = false;
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
      print("Chat has changed to ${value.id}");
      if (_chatSubscription != null) _chatSubscription.cancel();
      if (_messagesSubscription != null) _messagesSubscription.cancel();
      _isListeningSingleChat = false;
      _isListeningMessages = false;
      messages = [];
    }
    _chat = value;

    if (chat.id != null) {
      print("We can get chat data");
      loadChat();
      loadChatMessages();
    } else {
      print("We can not get chat data");
    }

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
        _chatExists = document.exists;
        if (_chatExists)
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

    String url = await uploadFile(image, "image", "jpg");
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
    if (_chatExists) {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(chat.id)
          .collection("messages")
          .add(messageMap);
      _updateLastMessageOnChat(messageMap);
    } else {
      _createNewChat(messageMap);
    }
  }

  void _createNewChat(Map<String, dynamic> messageMap) {
    print(chat.participants);
    _addLastMessageToNewChat(messageMap);
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chat.id)
        .set(chat.toJson())
        .whenComplete(() {
      chat = chat;
      print("Chat created");
      _addMessageToChat(messageMap);
    });
  }

  void _addLastMessageToNewChat(Map<String, dynamic> messageMap) {
    chat.lastMessage = LastMessage(
      body: messageMap["body"],
      from: messageMap["from"],
      timestamp: Timestamp.now(),
      type: messageMap["type"],
    );
  }

  void _updateLastMessageOnChat(messageMap) {
    FirebaseFirestore.instance.collection("chats").doc(chat.id).update({
      "lastMessage": messageMap,
    });
  }

  void deleteChat() {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chat.id)
        .collection("messages")
        .get()
        .then((messages) {
      messages.docs.forEach(
        (message) {
          message.reference.delete();
        },
      );
      FirebaseFirestore.instance.collection("chats").doc(chat.id).delete();
    });
    _clearStorageForChat("image");
    _clearStorageForChat("audio");
  }

  void _clearStorageForChat(String type) {
    String storagePathImages = 'chats/${chat.id}/$type/';
    Reference storageReferenceImages =
        FirebaseStorage.instance.ref().child(storagePathImages);
    storageReferenceImages.listAll().then((value) {
      value.items.forEach((element) {
        element.delete();
      });
    });
  }

  void clearChat() {
    FirebaseFirestore.instance
        .collection("chats")
        .doc(chat.id)
        .collection("messages")
        .get()
        .then((messages) {
      messages.docs.forEach(
        (message) {
          message.reference.delete();
        },
      );
    });
    _clearStorageForChat("image");
    _clearStorageForChat("audio");
  }
}
