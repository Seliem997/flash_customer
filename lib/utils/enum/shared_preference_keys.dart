enum CacheKey {
  loggedIn('loggedIn'),
  showOnBoarding('showOnBoarding'),
  language('language'),
  hasVehicle('hasVehicle'),
  userName('userName'),
  userImage('userImage'),
  userId('userId'),
  email('email'),
  phoneNumber('phoneNumber'),
  address('address'),
  hasAddress('hasAddress'),
  rentalBalance('rentalBalance');

  const CacheKey(this.key);
  final String key;
}
