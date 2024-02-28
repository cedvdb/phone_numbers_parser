class Constants {
  /// The minimum and maximum length of the country calling code.
  static const int minLengthCountryCallingCode = 1;
  static const int maxLengthCountryCallingCode = 3;

  /// The minimum and maximum length of the national significant number.
  /// lib phone number uses 2 but ITU says it's 3
  static const int minLengthNsn = 3;

  /// The ITU says the maximum length should be 15, but we have found longer numbers in Germany.
  static const int maxLengthNsn = 17;

  /// New Zealand can have 5 digits
  static const int minLengthCountryPlusNsn = 5;

  /// accepted punctuation within a phone number
  static const String _punctuation = r' ()\[\]\-\.\/\\';
  static const String _plus = r'+＋';

  /// Westhen and easthern arabic numerals
  static const String _digits = r'0-9０-９٠-٩۰-۹';

  /// Regex to find possible phone number candidates in a string.
  ///
  /// This regex tries to match all phone numbers. It doesn't match special
  /// numbers like the 100.
  ///
  /// The regex must start by either a + or a digit, then be followed by at least 6 digits.
  /// The digits are formed of westhern and easthern numerals.
  /// There can also be punctuation between the digts.
  static final String possiblePhoneNumber =
      '[$_plus$_digits](?:[$_punctuation]{0,3}[$_digits]){6,}';

  /// Matches strings that look like dates using "/" as a separator. Examples: 3/10/2011, 31/10/96 or
  /// 08/31/95.
  static final Pattern slashSeparatedDates =
      r'(?:(?:[0-3]?\\d/[01]?\\d)|(?:[01]?\\d/[0-3]?\\d))/(?:[12]\\d)?\\d{2}';
  // Replace Easthern to Westhern arabic numbers https://en.wikipedia.org/wiki/Eastern_Arabic_numerals
  static Map<String, String> allNormalizationMappings = {
    '+': '+',
    '＋': '+',
    '0': '0',
    '1': '1',
    '2': '2',
    '3': '3',
    '4': '4',
    '5': '5',
    '6': '6',
    '7': '7',
    '8': '8',
    '9': '9',
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
    '۰': '0',
    '۱': '1',
    '۲': '2',
    '۳': '3',
    '۴': '4',
    '۵': '5',
    '۶': '6',
    '۷': '7',
    '۸': '8',
    '۹': '9',
  };
}
