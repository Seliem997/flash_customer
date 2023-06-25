enum CacheKey {
  darkMode('darkMode'),
  loggedIn('loggedIn'),
  showOnBoarding('showOnBoarding'),
  language('language'),
  hasVehicle('hasVehicle'),
  userName('userName'),
  userImage('userImage'),
  userId('userId'),
  email('email'),
  token('token'),
  phoneNumber('phoneNumber'),
  countryCode('countryCode'),
  balance('balance');

  const CacheKey(this.key);
  final String key;
}
