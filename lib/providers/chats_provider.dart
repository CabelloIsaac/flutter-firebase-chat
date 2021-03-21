import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_chat/models/chat.dart';
import 'package:flutter_firebase_chat/providers/auth_provider.dart';

class ChatsProvider with ChangeNotifier {
  List<Chat> _chats = [];
  Chat _chat;
  bool _chatsListeningIsOn = false;

  List<Chat> get chats => _chats;
  Chat get chat => _chat;

  set chats(List<Chat> value) {
    _chats = value;
    notifyListeners();
  }

  set chat(Chat value) {
    _chat = value;
    notifyListeners();
  }

  void loadChats() {
    if (!_chatsListeningIsOn) {
      String userId = AuthProvider.getCurrentUserUid();
      FirebaseFirestore.instance
          .collection("chats")
          .where("participants", arrayContains: userId)
          .snapshots()
          .listen((documents) {
        chats = documents.docs.map((e) => Chat.fromJson(e.data())).toList();
      });
      _chatsListeningIsOn = true;
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
      }
    });
  }
}
