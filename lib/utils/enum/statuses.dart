enum Status {
  success("success"),
  error('error'),
  loading('loading'),
  codeSent('codeSent'),
  emailAlreadyInUse('emailAlreadyInUse'),
  phoneAlreadyInUse('phoneAlreadyInUse');

  const Status(this.key);
  final String key;
}
