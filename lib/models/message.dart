import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message({
    this.id,
    this.from,
    this.body,
    this.timestamp,
    this.type,
  });

  String id;
  String from;
  String body;
  Timestamp timestamp;
  String type;

  factory Message.fromJson({String id = "", Map<String, dynamic> data}) =>
      Message(
        id: id,
        from: data["from"],
        body: data["body"],
        timestamp: data["timestamp"],
        type: data["type"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "body": body,
        "timestamp": timestamp,
        "type": type,
      };
}
