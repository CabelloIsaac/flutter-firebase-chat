import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_chat/models/message.dart';
import 'package:intl/intl.dart';

class Functions {
  static String getMessageTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat('hh:mm a');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String getMessageDate(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    final DateFormat formatter = DateFormat("dd 'de' MMM");
    final String formatted = formatter.format(dateTime);
    return formatted;
  }

  static bool messagesAreDifferentDays(Message first, Message second) {
    DateTime firstDateTime = first.timestamp.toDate();
    DateTime secondDateTime = second.timestamp.toDate();

    int firstDay = firstDateTime.day;
    int firstMonth = firstDateTime.month;
    int firstYear = firstDateTime.year;

    int secondDay = secondDateTime.day;
    int secondMonth = secondDateTime.month;
    int secondYear = secondDateTime.year;

    if (firstYear != secondYear) return true;
    if (firstYear == secondYear && firstMonth != secondMonth) return true;
    if (firstYear == secondYear &&
        firstMonth == secondMonth &&
        firstDay != secondDay) return true;
    return false;
  }

  static String generateChatIdFromParticipants(List<String> participants) {
    String result = participants[0] + participants[1];
    participants.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    result = participants[0] + "-" + participants[1];
    return result;
  }
}
