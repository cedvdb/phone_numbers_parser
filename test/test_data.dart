import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class TestData {
  final String internationalNonNormalized;
  final String international;
  final String nationalLocal;
  final String nsn;
  final Country country;
  final String description;
  final PhoneNumberType type;

  TestData(
    this.country,
    this.description,
    this.internationalNonNormalized,
    this.international,
    this.nationalLocal,
    this.nsn, [
    this.type = PhoneNumberType.fixedLine,
  ]);
}

final testData = [
  TestData(
    // simple fixed line
    Country.fromIsoCode('fr'),
    'France fix',
    '+33 1 40 71 87 28',
    '+33140718728',
    '0140718728',
    '140718728',
    PhoneNumberType.fixedLine,
  ),
  // simple mobile
  TestData(
    Country.fromIsoCode('fr'),
    'France Mobile',
    '+33 655 5705 76',
    '+33655570576',
    '0655570576',
    '655570576',
    PhoneNumberType.mobile,
  ),
  // simple mobile with 00 international prefix
  TestData(
    Country.fromIsoCode('fr'),
    'France Mobile with international prefix',
    '00 33 655 5705 76',
    '+33655570576',
    '0655570576',
    '655570576',
  ),
  // TestData(
  //   Country.fromIsoCode('ca'),
  //   'Canada, not main country for dial code',
  //   '+1-613-555-0161',
  //   '+16135550161',
  //   '16135550161',
  //   '6135550161',
  // ),
  // // requires transformation in argentina 0343 15 555 1212 (local) is exactly the
  // // same number as +54 9 343 555 1212
  // TestData(
  //   Country.fromIsoCode('ar'),
  //   'Argentina, requires local national number transformation',
  //   '+54 9 343 555 1212',
  //   '+5493435551212',
  //   '0343155551212',
  //   '93435551212',
  // ),
  // TestData(
  //   Country.fromIsoCode('as'),
  //   'American Samoa, leading digits, same dial code as US',
  //   '+1 684 622 1234',
  //   '+16846221234',
  //   '6221234',
  //   '6846221234',
  // ),
  // invalid
  // TestData(
  //   Country.fromIsoCode('fr'),
  //   'Invalid phone: country code starting with 0',
  //   '+03 655 5705 76',
  //   '+03655570576',
  //   '0655570576',
  //   '655570576',
  // ),
];

// fixed line simple with national prefix
// final franceFixInternational = '+33 1 40 71 87 28';
// final franceFixInternationalWithPrefix = '00 33 1 40 71 87 28';
// final franceFixInternationalExpected =
//     franceFixInternational.replaceAll(' ', '');
// final franceFixNational = '0140718728';
// final franceFixNsnExpected = '140718728';

// mobile
// final franceMobileInternational = '+33 655 5705 76';
// final franceMobileInternationalWithPrefix = '00 33 655 5705 76';
// final franceMobileInternationalExpected =
//     franceFixInternational.replaceAll(' ', '');
// final franceMobileNational = '0655570576';
// final franceMobileNsnExpected = '655 5705 76';

// simple international prefix
// not main country
// final canadaInternational = '+1-613-555-0161';
// final canadaInternationalExpected = canadaInternational.replaceAll('-', '');
// final canadaNational = '613-555-0161';
// final canadaNsnExpected = canadaNational.replaceAll('-', '');

// requires transformation in argentina 0343 15 555 1212 (local) is exactly the
// same number as +54 9 343 555 1212
// final argentinaInternational = '+54 9 343 555 1212';
// final argentinaInternationalExpected =
//     argentinaInternational.replaceAll(' ', '');
// final argentinaNational = '9 343 555 1212';
// final argentinaNationalLocal = '0343 15 555 1212';
// final argentinaNsnExpected = argentinaNational.replaceAll(' ', '');

// with leading digits american samoa
// final amerSamoaInternational = '+1 684 622 1234';
// final amerSamoaInternationalExpected =
//     amerSamoaInternational.replaceAll(' ', '');
// final amerSamoaNational = '684 622 1234';
// final amerSamoaNationalWithoutLeadingDigits = '6221234';
// final amerSamoaNsnExpected = amerSamoaNational.replaceAll(' ', '');
