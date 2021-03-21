import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  Chat({
    this.id,
    this.type,
    this.participants,
    this.participantsData,
    this.lastMessage,
  });

  String id;
  String type;
  List<String> participants;
  List<ParticipantsData> participantsData;
  LastMessage lastMessage;

  factory Chat.fromJson({String id = "", Map<String, dynamic> data}) => Chat(
        id: id,
        type: data["type"],
        participants: List<String>.from(data["participants"].map((x) => x)),
        participantsData: List<ParticipantsData>.from(
            data["participantsData"].map((x) => ParticipantsData.fromJson(x))),
        lastMessage: LastMessage.fromJson(data["lastMessage"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "participants": List<dynamic>.from(participants.map((x) => x)),
        "participantsData":
            List<dynamic>.from(participantsData.map((x) => x.toJson())),
        "lastMessage": lastMessage.toJson(),
      };
}

class LastMessage {
  LastMessage({
    this.from,
    this.body,
    this.timestamp,
  });

  String from;
  String body;
  Timestamp timestamp;

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        from: json["from"],
        body: json["body"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "body": body,
        "timestamp": timestamp,
      };
}

class ParticipantsData {
  ParticipantsData({
    this.id,
    this.name,
    this.lastName,
    this.avatar,
  });

  String id;
  String name;
  String lastName;
  String avatar;

  factory ParticipantsData.fromJson(Map<String, dynamic> json) =>
      ParticipantsData(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastName": lastName,
        "avatar": avatar,
      };
}
