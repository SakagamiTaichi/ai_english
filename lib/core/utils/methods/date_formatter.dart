class DateFormatter {
  /// DateTime型を相対的な日付表示に変換します
  /// 
  /// 例: "今日 19:45", "昨日 16:10", "15日前 18:40"
  static String formatRelativeDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final difference = today.difference(targetDate).inDays;
    
    final timeString = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    
    if (difference == 0) {
      return '今日 $timeString';
    } else if (difference == 1) {
      return '昨日 $timeString';
    } else {
      return '${difference}日前 $timeString';
    }
  }
}