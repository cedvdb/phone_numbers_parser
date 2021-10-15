# Phone Numbers Parser

Dart library for parsing phone numbers. Inspired by Google's libphonenumber and PhoneNumberKit for ios.

The advantage of this lib instead of libphonenumber is that it instantly supports all platforms (no need for channeling).


## Features

 - Find phone numbers in a text
 - Validate a phone number
 - Find the country of a phone number (Geocoding available as separate package)
 - A light parser for size aware applications
 - Formatter
 - Phone ranges
 - Supports easthern arabic digits
 - Uses best-in-class metadata from Google's libPhoneNumber project. 


## Usage

Use the class `PhoneNumber` as a starting point

```dart
  // creation
  final frPhone = PhoneNumber.fromNational('fr', '655 5705 76');
  final frPhone1 = PhoneNumber.fromRaw('+33 655 5705 76');
  final frPhone2 = PhoneNumber.fromIsoCode('fr', '655 5705 76');
  final frPhone3 = PhoneNumber.fromCountryCode('33', '655 5705 76');
  final frPhone4 = PhoneNumber.fromIsoCode('fr', '0655 5705 76');
  final allSame = frPhone == frPhone1 &&
      frPhone == frPhone2 &&
      frPhone == frPhone3 &&
      frPhone == frPhone4;
  print('allSame: $allSame'); // true

  // validation
  final valid = frPhone1.validate();
  final validMobile = frPhone1.validate(type: PhoneNumberType.mobile);
  final validFixed = frPhone1.validate(type: PhoneNumberType.fixedLine);
  print('valid: $valid'); // true
  print('valid mobile: $validMobile'); // true
  print('valid fixed line: $validFixed'); // false

  // changing the country

  final esPhone =
      frPhone1.rebuildWith(isoCode: 'ES'); // will reparse the nsn for new iso
  print('new country code: ' + esPhone.countryCode); // 34 // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = PhoneNumber.findPotentialPhoneNumbers(text);
  print('found: ' + (found.first.group(0) ?? ''));
```

### Formatting

Formatting is region specific, so the formats will vary by iso code to accomodate
for local formats.

```dart
  final phoneNumber = PhoneNumber.fromIsoCode('US', '2025550119');
  final formattedNsn = phoneNumber.getFormattedNsn();
  print('formatted: $formattedNsn'); // 202-555-0119
```

### Range 

```dart
final first = PhoneNumber.fromRaw('+33 655 5705 00');
  final last = PhoneNumber.fromRaw('+33 655 5705 03');
  final range = PhoneNumber.getRange(first, last);

  print('Count: ${range.count}');
  print('Expand: ${range.expandRange().join(',')}');

  if (first > last) {
    print("this shouldn't be.");
  }

  final one = PhoneNumber.fromRaw('+33 655 5705 01');
  final two = PhoneNumber.fromRaw('+33 655 5705 02');

  if (one.isAdjacentTo(two)) {
    print('We are together');
  }
  if (one.isSequentialTo(two)) {
    print('$two comes after $one');
  }

  /// treat the phone no. like an int
  final three = two + 1;
  print('Its still a phone No. $three');
  two - 1 == one;
  final another = one + 2;
  print('$another == $three');

```


## Demo

The phone number input packages has a demo that uses this parser: https://cedvdb.github.io/phone_form_field/
