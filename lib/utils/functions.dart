import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final day = dateTime.day;
  final suffix = getDaySuffix(day);
  final formatter = DateFormat("MMMM, yyyy 'at' hh:mm a");
  final formattedDate = formatter.format(dateTime);

  return '$day$suffix $formattedDate';
}

String getDaySuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
