class Constants {
  /// The minimum and maximum length of the country calling code.
  static final int MIN_LENGTH_COUNTRY_DIAL_CODE = 1;
  static final int MAX_LENGTH_COUNTRY_DIAL_CODE = 3;

  /// The minimum and maximum length of the national significant number.
  /// lib phone number uses 2 but ITU says it's 3
  static final int MIN_LENGTH_FOR_NSN = 3;

  /// The ITU says the maximum length should be 15, but we have found longer numbers in Germany.
  static final int MAX_LENGTH_FOR_NSN = 17;

  /// New Zealand can have 5 digits
  static final int MIN_LENGTH_COUNTRY_PLUS_NSN = 5;

  /// accepted punctuation within a phone number
  static final String _PUNCTUATION = ' ()[\]\-\./\\';
  static final String _PLUS = '+＋';

  /// Westhen and easthern arabic numerals
  static final String _DIGITS = '0-9０-９٠-٩۰-۹';

  /// Regex to find possible phone number candidates in a string.
  ///
  /// This regex tries to match all *mobile* phone numbers. It doesn't match special
  /// numbers like the 100.
  ///
  /// The regex must start by either a + or a digit, then be followed by at least 6 digits.
  /// The digits are formed of westhern and easthern numerals.
  /// There can also be punctuation between the digts.
  static final String POSSIBLE_PHONE_NUMBER =
      '[$_PLUS$_DIGITS](?:[$_PUNCTUATION]{0,5}$_DIGITS){6,}';
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
