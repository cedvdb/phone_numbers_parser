import 'phone_number.dart';

/// parses a string into a PhoneNumber
///
/// Note that the naming convention for parameters is:
///
/// - raw : denotes a phone number that may or may not have a prefix
/// - phoneNumber: denotes a phone number without any prefix
abstract class PhoneNumberParser {



  /// removes everything before a + sign 
  String _removeCharsBeforePlus(String str);

  /// returns a possible phone number from a string representing a phone number
  String extractPossibleNumber(String str) {
      isPossibleNumber();
      final extracted = _removeCharsBeforePlus(str);
      final validDigits = _toWesternDigits(extracted);
      return extracted;
   }

   /// check it contains only digits (e-w) and valid phone number punctuation
   isPossibleNumber() {
     checkLength;
     return match();
   }

   /// normalize phone number to keep only the leading + and digits
  String normalize(String string) {
      isPossibleNumber();
      
      final extracted = _removeCharsBeforePlus(string);
      final hasLeadingPlus = extracted.startsWith(plus);
      final validDigits = _toWesternDigits(extracted);
      final digitsOnly = _toDigitsOnly(validDigits);
      return hasLeadingPlus ? '+' + digitsOnly : digitsOnly;
   }

   
  PhoneNumber parse (String str, { normalize = true }) {
     final normalized = normalize(str)
     final hasLeadingPlus;   
   }

   findDialCode(String phoneNumber, { guess}) {
     str = _convertCommonInternationalPrefix()
     if (startsWith(+))

      
   }
 
   // if the number doesn't start with a + we can convert the most common international prefix (00 and 011) to a +
   _convertCommonInternationalPrefix()


   _findDialCodeHasLeadingPlus() {}

}
