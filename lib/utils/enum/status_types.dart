enum StatusType {
  pending("Pending"),
  pending2("pending"),
  onTheWay2('on_the_way'),
  onTheWay('On the way'),
  arrived('Arrived'),
  arrived2('arrived'),
  completed('Complete'),
  completed2('completed'),
  initial('Initial'),
  canceled('Canceled'),
  canceled2('canceled');

  const StatusType(this.key);
  final String key;
}
