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


## Parsers
There are two parsers: LightPhoneParser and Phone Parser

LightPhoneParser:
  - smaller size footprint (more will be tree shaken)
  - uses mainly length information for validation
  - fast

PhoneParser:
  - more accurate
  - more utilities
  - bigger size footprint
  - more computationally intensive
  - uses pattern matching

### Usage PhoneParser

```dart
  final parser = PhoneParser();
  // creation
  final frPhone = parser.parseRaw('+33 655 5705 76');
  final frPhone1 = parser.parseWithIsoCode('fr', '655 5705 76');
  final frPhone2 = parser.parseWithDialCode('33', '655 5705 76');
  final frPhone3 = parser.parseWithIsoCode('fr', '0655 5705 76');
  final allSame =
      frPhone == frPhone1 && frPhone == frPhone2 && frPhone == frPhone3;
  print(allSame); // true

  // validation
  print(parser.validate(frPhone1)); // true
  print(parser.validate(frPhone1, PhoneNumberType.mobile)); // true
  print(parser.validate(frPhone1, PhoneNumberType.fixedLine)); // false

  // changing the country
  final esPhone = parser.copyWithIsoCode(frPhone, 'ES');
  print(esPhone.dialCode); // 34
  print(esPhone.isoCode); // ES
  print(esPhone.international); // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = parser.findPotentialPhoneNumbers(text);
  print(text.substring(found.first.start, found.first.end)); 
```


### Usage LightPhoneParser

```dart
  final parser = LightPhoneParser();
  // creation
  final frPhone = parser.parseWithIsoCode('fr', '+33 655 5705 76');
  final frPhone1 = parser.parseWithIsoCode('fr', '655 5705 76');
  final frPhone2 = parser.parseWithIsoCode('fr', '655 5705 76');
  final frPhone3 = parser.parseWithIsoCode('fr', '0655 5705 76');
  final allSame =
      frPhone == frPhone1 && frPhone == frPhone2 && frPhone == frPhone3;
  print(allSame); // true

  // validation
  print(parser.validate(frPhone1)); // true
  print(parser.validate(frPhone1, PhoneNumberType.mobile)); // true
  print(parser.validate(frPhone1, PhoneNumberType.fixedLine)); // false

  // changing the country
  final esPhone = parser.copyWithIsoCode(frPhone, 'ES');
  print(esPhone.dialCode); // 34
  print(esPhone.isoCode); // ES
  print(esPhone.international); // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = parser.findPotentialPhoneNumbers(text);
  print(text.substring(found.first.start, found.first.end));

 
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
