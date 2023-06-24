enum DFormat {
  dmy('d-M-y'),
  mdy('M/d/y'),
  ymd('y-MM-dd'),
  hm('hh:mm');

  const DFormat(this.key);
  final String key;
}
