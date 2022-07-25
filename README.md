# Phone Numbers Parser

Dart library for parsing phone numbers. Inspired by Google's libphonenumber and PhoneNumberKit for ios.

The advantage of this lib instead of libphonenumber is that it instantly supports all platforms (no need for channeling).


## Features

 - Find phone numbers in a text
 - Validate a phone number
 - A light parser for size aware applications
 - Formatter
 - Phone ranges
 - Supports eastern arabic digits
 - Uses best-in-class metadata from Google's libPhoneNumber project. 


## Usage

Use the class `PhoneNumber` as a starting point

```dart
  // creation
  final frPhone1 = PhoneNumber.fromNational(IsoCode.FR, '655 5705 76');
  final frPhone2 =
      PhoneNumber.fromNational(IsoCode.values.byName('FR'), '0655 5705 76');
  final frPhone3 = PhoneNumber.fromRaw('+33 655 5705 76');
  final frPhone4 = PhoneNumber.fromIsoCode(IsoCode.FR, '0655 5705 76');
  final frPhone5 = PhoneNumber.fromCountryCode('33', '655 5705 76');
  final frPhone6 = PhoneNumber.fromLocale(IsoCode.BY, '810 33 655 5705 76');
  final allSame = frPhone1 == frPhone2 &&
      frPhone1 == frPhone3 &&
      frPhone1 == frPhone4 &&
      frPhone1 == frPhone5 &&
      frPhone1 == frPhone6;
  print('allSame: $allSame'); // true

  // changing the country

  final esPhone = frPhone1.rebuildWith(
      isoCode: IsoCode.ES); // will reparse the nsn for new iso
  print('new country code: ${esPhone.countryCode}'); // 34 // '+34655570576'

  // utils
  final text = 'hey my phone number is: +33 939 876 218';
  final found = PhoneNumber.findPotentialPhoneNumbers(text);
  print('found: ' + (found.first.group(0) ?? ''));
```

# validation

```dart
  final valid = frPhone1.validate();
  final validMobile = frPhone1.validate(type: PhoneNumberType.mobile);
  final validFixed = frPhone1.validate(type: PhoneNumberType.fixedLine);
  print('valid: $valid'); // true
  print('valid mobile: $validMobile'); // true
  print('valid fixed line: $validFixed'); // false
```

### Formatting

Formatting is region specific, so the formats will vary by iso code to accommodate
for local formats.

```dart
  final phoneNumber = PhoneNumber.fromIsoCode(IsoCode.US, '2025550119');
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


