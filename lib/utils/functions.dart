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
    if (timestamp == null) return "";

    final DateFormat formatter = DateFormat(null, "es_MX");

    DateTime messageDateTime = timestamp.toDate();
    DateTime todayDateTime = DateTime.now();

    int messageDay = messageDateTime.day;
    int messageMonth = messageDateTime.month;
    int messageYear = messageDateTime.year;

    int todayDay = todayDateTime.day;
    int todayMonth = todayDateTime.month;
    int todayYear = todayDateTime.year;

    if (todayYear != messageYear) {
      formatter.addPattern("dd 'de' MMM 'de' yyyy");
    }

    if (messageYear == todayYear && messageMonth != todayMonth) {
      formatter.addPattern("dd 'de' MMM");
    }

    if (messageYear == todayYear &&
        messageMonth == todayMonth &&
        messageDay != todayDay) {
      formatter.addPattern("E dd");
    }

    if (messageYear == todayYear &&
        messageMonth == todayMonth &&
        messageDay == todayDay) {
      return "Hoy";
    }

    final String formatted = formatter.format(messageDateTime);
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

  static String getMessageTimestamp(Timestamp timestamp) {
    if (timestamp == null) return "";

    final DateFormat formatter = DateFormat(null, "es_MX");

    DateTime messageDateTime = timestamp.toDate();
    DateTime todayDateTime = DateTime.now();

    int messageDay = messageDateTime.day;
    int messageMonth = messageDateTime.month;
    int messageYear = messageDateTime.year;

    int todayDay = todayDateTime.day;
    int todayMonth = todayDateTime.month;
    int todayYear = todayDateTime.year;

    if (todayYear != messageYear) {
      formatter.addPattern("dd 'de' MMM 'de' yyyy");
    }

    if (messageYear == todayYear && messageMonth != todayMonth) {
      formatter.add_d();
      formatter.add_MMM();
    }

    if (messageYear == todayYear &&
        messageMonth == todayMonth &&
        messageDay != todayDay) {
      formatter.add_E();
      formatter.add_d();
    }

    if (messageYear == todayYear &&
        messageMonth == todayMonth &&
        messageDay == todayDay) {
      // formatter.add_Hm();
      formatter.addPattern("hh:mm");
      formatter.addPattern("a");
    }

    final String formatted = formatter.format(messageDateTime);
    return formatted;
  }
}
