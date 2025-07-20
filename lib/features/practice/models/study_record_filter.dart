enum StudyRecordFilter {
  all('すべて'),
  thisWeek('今週'),
  thisMonth('今月');

  const StudyRecordFilter(this.displayName);
  final String displayName;
}