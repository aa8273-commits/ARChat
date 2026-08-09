import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatMessageTime(Timestamp timestamp) {
  DateTime date = timestamp.toDate().toLocal();
  // DateTime now = timestamp.toDate().add(const Duration(hours: 1));
  DateTime now = DateTime.now();

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return DateFormat('hh:mm a').format(date);
  }

  if (date.year == now.year) {
    return DateFormat('dd MMM').format(date);
  }

  return DateFormat('dd/MM/yyyy').format(date);
}
