enum DFormat {
  dmy('d-M-y'),
  mdy('M/d/y'),
  ymd('y-MM-dd');

  const DFormat(this.key);
  final String key;
}
