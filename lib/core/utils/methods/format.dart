import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  // UTCからJSTに変換（+9時間）
  final jstDate = date.toLocal();
  return DateFormat('yyyy/MM/dd', 'ja_JP').format(jstDate);
}
