import 'package:intl/intl.dart';

String ordinal(int number) {
  if(!(number >= 1 && number <= 1000)) {//here you change the range
    throw Exception('Invalid number');
  }

  if(number >= 11 && number <= 13) {
    return Intl.getCurrentLocale() == 'ar' ? '' : 'th';
  }

  switch(number % 10) {
    case 1: return Intl.getCurrentLocale() == 'ar' ? '' : 'st';
    case 2: return Intl.getCurrentLocale() == 'ar' ? '' : 'nd';
    case 3: return Intl.getCurrentLocale() == 'ar' ? '' : 'rd';
    default: return Intl.getCurrentLocale() == 'ar' ? '' : 'th';
  }
}
