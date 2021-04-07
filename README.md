# Phone Number Parser

Dart library for parsing phone numbers. Inspired by Google's libphonenumber and PhoneNumberKit for ios.

## Features

 - Find phone numbers in a text
 - Validate a phone number
 - Find the region of a phone number
 - Phone number parsing
 - Country list for display
 - Simple syntax
 - Uses best-in-class metadata from Google's libPhoneNumber project. 

## Usage

```dart
// creation
PhoneNumber.fromRaw('+33 93 987 6218');
PhoneNumber.fromIsoCode('fr','93 987 6218');
PhoneNumber.fromDialCode('33', '93 987 6218')
// extract info
final phoneNumber = PhoneNumber.fromRaw('+33 93 987 6218');
print(phoneNumber.valid); // true
print(phoneNumber.dialCode); // 33
print(phoneNumber.isoCode); // FR
print(phoneNumber.international); // +33939876218

final text = 'hey my phone number is: +33 939 876 218';
final found = PhoneNumberUtil.findPotentialPhoneNumbers(text);
 
```
