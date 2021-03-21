import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];
  Chat _chat;
  bool _isListeningAllChats = false;
  bool _isListeningSingleChat = false;
  StreamSubscription<QuerySnapshot> _chatsSnapshots;
  StreamSubscription<DocumentSnapshot> _chatSnapshots;

  List<Chat> get chats => _chats;
  Chat get chat => _chat;

  set chats(List<Chat> value) {
    _chats = value;
    notifyListeners();
  }

  set chat(Chat value) {
    if (chat == null || chat.id != value.id) {
      if (_chatSnapshots != null) _chatSnapshots.cancel();
      _isListeningSingleChat = false;
    }
    _chat = value;
    loadChat();
    notifyListeners();
  }

  void loadChats() {
    print("loadChats");
    if (!_isListeningAllChats) {
      print("_isListeningAllChats = false");
      String userId = AuthProvider.getCurrentUserUid();
      _chatsSnapshots = FirebaseFirestore.instance
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
      _chatSnapshots = FirebaseFirestore.instance
          .collection("chats")
          .doc(chat.id)
          .snapshots()
          .listen((document) {
        chat = Chat.fromJson(id: document.id, data: document.data());
      });
      _isListeningSingleChat = true;
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
}
