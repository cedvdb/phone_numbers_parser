# Phone Number Parser

Dart library for parsing phone numbers. Inspired by Google's libphonenumber and PhoneNumberKit for ios.

The advantage of this lib instead of libphonenumber is that it instantly supports all platforms (no need for channeling).


## Features

 - Find phone numbers in a text
 - Validate a phone number
 - Find the region of a phone number
 - Phone number parsing
 - Country list for display
 - Simple syntax
 - Supports easthern arabic digits
 - Uses best-in-class metadata from Google's libPhoneNumber project. 


## Usage

```dart
// creation
PhoneNumber.fromRaw('+33 93 987 6218');
PhoneNumber.fromIsoCode('fr','93 987 6218');
PhoneNumber.fromDialCode('33', '93 987 6218')
// extract info
final frPhone = PhoneNumber.fromRaw('+33 93 987 6218');
print(frPhone.dialCode); // 33
print(frPhone.isoCode); // FR
print(frPhone.international); // +33939876218
print(frPhone.valid); // true
print(frPhone.validate(PhoneNumberType.mobile)); // true
print(frPhone.validate(PhoneNumberType.fixedLine)); // false

final esPhone = frPhone.copyWithIsoCode('ES');
print(esPhone.valid); // true
print(esPhone.dialCode); // 34
print(esPhone.isoCode); // ES
print(esPhone.international); // +34939876218

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
print(frPhone.valid); // true
print(frPhone.dialCode); // 33
print(frPhone.isoCode); // fr
print(frPhone.validate(PhoneNumberType.fixedLine)); // false
print(frPhone.validate(PhoneNumberType.mobile)); // true

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

## Demo

The phone number input packages has a demo that uses this parser: https://cedvdb.github.io/phone_form_field/
