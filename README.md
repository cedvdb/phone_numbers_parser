# Phone Numbers Parser

Dart library for parsing phone numbers. Inspired by Google's libphonenumber and PhoneNumberKit for ios.

The advantage of this lib instead of libphonenumber is that it instantly supports all platforms (no need for channeling).


## Features

 - Find phone numbers in a text
 - Validate a phone number
 - Find the region of a phone number
 - Phone number parsing
 - A light parser for size aware applications
 - Supports easthern arabic digits
 - Uses best-in-class metadata from Google's libPhoneNumber project. 


## Usage LightPhoneParser

## Usage PhoneParser

```dart
// creation
final frPhone = PhoneNumber.fromRaw('+33 655 5705 76');
final frPhone1 = PhoneNumber.fromIsoCode('fr', '655 5705 76');
final frPhone2 = PhoneNumber.fromDialCode('33', '655 5705 76');
final frPhone3 = PhoneNumber.fromIsoCode('fr', '0655 5705 76');
final international = '+33655570576';
final allInternationalEqual = international == frPhone.international &&
    international == frPhone1.international &&
    international == frPhone2.international &&
    international == frPhone3.international;
print(allInternationalEqual); // true

// extracting info
print(frPhone.dialCode); // 33
print(frPhone.isoCode); // fr
print(frPhone.validate(PhoneNumberType.fixedLine)); // false
print(frPhone.validate(PhoneNumberType.mobile)); // true
print(frPhone.validate(null)); // true

// changing the country
final esPhone = frPhone.copyWithIsoCode('ES');
print(esPhone.dialCode); // 34
print(esPhone.isoCode); // ES
print(esPhone.international); // '+34655570576'

// utils
final text = 'hey my phone number is: +33 939 876 218';
final found = PhoneNumberUtil.findPotentialPhoneNumbers(text);

// country list for display
final allCountries = countries; // contains name, isoCode, dialCode, leading digits, etc
 
```

## Migration to 1.0.0

1.0.0 introduces two parsers:

  - PhoneParser: Heavy, more accurate and more computationally intensive (relies on pattern matching)
  - LightPhoneParser: Light, somewhat accurate and less computationally intensive (relies on length)
  If a light validation based on length suffice, LightPhoneParser can be used, assuming you don't import
  the other parser, that will decrease the library size footprint.

With this change a few breaking changes had to be made

  before:
  ```dart
  final frPhone = PhoneNumber.fromRaw('+33 655 5705 76');
  final frPhone1 = PhoneNumber.fromIsoCode('FR', '655 5705 76');
  final valid = frPhone.validate();
  ```

  after:
  ```dart
  final frPhone = PhoneParser.fromRaw('+33 655 5705 76')
  final frPhone1 = LightPhoneParser.fromIsoCode('FR', '655 5705 76');
  final valid = PhoneParser.validate(frPhone);
  ```

## Demo

The phone number input packages has a demo that uses this parser: https://cedvdb.github.io/phone_form_field/
