import 'package:intl/intl.dart';

String formattedDate() {
  DateTime now = DateTime.now().toLocal();
  String formattedDate = DateFormat('EEEE, dd MMMM').format(now);
  return formattedDate; // Example output: Monday, 05 February
}
