enum Status {
  success("success"),
  error('error'),
  loading('loading'),
  codeSent('codeSent'),
  emailAlreadyInUse('emailAlreadyInUse'),
  invalidEmailOrPass('invalidEmailOrPass'),
  emailNotRegistered('emailNotRegistered'),
  codeNotCorrect('codeNotCorrect'),
  phoneAlreadyInUse('phoneAlreadyInUse');

  const Status(this.key);
  final String key;
}
