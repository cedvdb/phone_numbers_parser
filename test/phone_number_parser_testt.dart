import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/parsers/phone_number_parser.dart';
import 'package:test/test.dart';

void main() {
  // fixed line simple with national prefix
  final franceFixInternational = '+33 1 40 71 87 28'.replaceAll(' ', '');
  final franceFixInternationalWithPrefix =
      '00 33 1 40 71 87 28'.replaceAll(' ', '');
  final franceFixNational = '01 40 71 87 28'.replaceAll(' ', '');
  final franceFixNsnExpected = '1 40 71 87 28'.replaceAll(' ', '');

  // mobile
  final franceMobileInternational = '+33 655 5705 76'.replaceAll(' ', '');
  final franceMobileInternationalWithPrefix =
      '00 33 655 5705 76'.replaceAll(' ', '');
  final franceMobileNational = '0 655 5705 76'.replaceAll(' ', '');
  final franceMobileNsnExpected = '655 5705 76'.replaceAll(' ', '');

  // simple international prefix
  // not main country
  final canadaInternational = '+1 613 555 0161'.replaceAll(' ', '');
  final canadaNational = '613 555 0161'.replaceAll(' ', '');
  final canadaNsnExpected = canadaNational;

  // requires transformation in argentina 0343 15 555 1212 (local) is exactly the
  // same number as +54 9 343 555 1212
  final argentinaInternational = '+54 9 343 555 1212'.replaceAll(' ', '');
  final argentinaNational = '9 343 555 1212'.replaceAll(' ', '');
  final argentinaNationalLocal = '0343 15 555 1212'.replaceAll(' ', '');
  final argentinaNsnExpected = argentinaNational;

  // with leading digits american samoa
  final amerSamoaInternational = '+1 684 622 1234'.replaceAll(' ', '');
  final amerSamoaNational = '684 622 1234'.replaceAll(' ', '');
  final amerSamoaNationalWithoutLeadingDigits = '6221234'.replaceAll(' ', '');
  final amerSamoaNsnExpected = amerSamoaNational;

  group('PhoneNumberParser', () {
    group('fromIsoCode', () {
      final fromIsoCode = PhoneNumberParser.parseWithIsoCode;
      test('should create with national prefix', () {
        final franceFix = fromIsoCode('fr', franceFixNational);
        final franceMobilePhone = fromIsoCode('fr', franceMobileNational);
        expect(franceFix.country.isoCode, equals('FR'));
        expect(franceFix.nsn, equals(franceFixNsnExpected));
        expect(franceMobilePhone.country.isoCode, equals('FR'));
        expect(franceMobilePhone.nsn, equals(franceMobileNsnExpected));
      });

      test('should create when not main country for iso code', () {
        final canadaPhone = fromIsoCode('CA', canadaNational);
        expect(canadaPhone.country.isoCode, equals('CA'));
        expect(canadaPhone.nsn, equals(canadaNsnExpected));
      });

      test('should create when the phone number changes locally and globally',
          () {
        final arPhone = fromIsoCode('Ar', argentinaNational);
        final arPhone2 = fromIsoCode('Ar', argentinaNationalLocal);
        expect(arPhone.country.isoCode, equals('AR'));
        expect(arPhone.nsn, equals(argentinaNsnExpected));
        expect(arPhone2.country.isoCode, equals('AR'));
        expect(arPhone2.nsn, equals(argentinaNsnExpected));
      });

      test('should create when there are leading digits', () {
        final amSamoaPhone = fromIsoCode('AS', amerSamoaNational);
        final amSamoaPhone2 =
            fromIsoCode('As', amerSamoaNationalWithoutLeadingDigits);

        expect(amSamoaPhone.country.isoCode, equals('AS'));
        expect(amSamoaPhone.nsn, equals(amerSamoaNsnExpected));

        expect(amSamoaPhone2.country.isoCode, equals('AS'));
        expect(amSamoaPhone2.nsn, equals(amerSamoaNsnExpected));
      });

      test('should not throw error for empty input when country is valid', () {
        expect(fromIsoCode('fr', ''), TypeMatcher<ParsingResult>());
      });

      test('should throw error when country is invalid', () {
        expect(
          () => fromIsoCode('not found', ''),
          throwsA(TypeMatcher<PhoneNumberException>()),
        );
      });
    });

    group('fromDialCode', () {
      final fromDialCode = PhoneNumberParser.parseWithDialCode;
      test('should create with national prefix', () {
        final francePhone = fromDialCode('33', franceFixNational);
        final franceMobile = fromDialCode('33', franceMobileNational);
        expect(francePhone.country.isoCode, equals('FR'));
        expect(francePhone.nsn, equals(franceFixNsnExpected));
        expect(franceMobile.country.isoCode, equals('FR'));
        expect(franceMobile.nsn, equals(franceMobileNsnExpected));
      });

      test('should create when not main country for iso code', () {
        final canadaPhone = fromDialCode('1', canadaNational);
        expect(canadaPhone.country.isoCode, equals('CA'));
        expect(canadaPhone.nsn, equals(canadaNsnExpected));
      });

      test('should create when the phone number changes locally and globally',
          () {
        final arPhone = fromDialCode('54', argentinaNationalLocal);
        final arPhone2 = fromDialCode('54', argentinaNational);
        expect(arPhone.country.isoCode, equals('AR'));
        expect(arPhone.nsn, equals(argentinaNsnExpected));

        expect(arPhone2.country.isoCode, equals('AR'));
        expect(arPhone2.nsn, equals(argentinaNsnExpected));
      });

      test('should create when there are leading digits', () {
        final amSamoaPhone = fromDialCode('1', amerSamoaNational);
        final amSamoaPhone2 =
            fromDialCode('1', amerSamoaNationalWithoutLeadingDigits);

        expect(amSamoaPhone.country.isoCode, equals('AS'));
        expect(amSamoaPhone.nsn, equals(amerSamoaNsnExpected));

        expect(amSamoaPhone2.country.isoCode, equals('AS'));
        expect(amSamoaPhone2.nsn, equals(amerSamoaNsnExpected));
      });

      test('should not throw error for empty input when country is valid', () {
        expect(fromDialCode('1', ''), TypeMatcher<ParsingResult>());
      });

      test('should throw error when country is invalid', () {
        expect(
          () => fromDialCode('0', ''),
          throwsA(TypeMatcher<PhoneNumberException>()),
        );
      });
    });

    group('fromRaw', () {
      final parse = PhoneNumberParser.parse;
      test('should create with international prefix', () {
        final franceFix = parse(franceFixInternational);
        // final franceFix2 = parse(franceFixInternationalWithPrefix);
        final franceMobile = parse(franceMobileInternational);
        // final franceMobile2 = parse(franceMobileInternationalWithPrefix);

        expect(franceFix.country.isoCode, equals('FR'));
        // expect(franceFix2.country.isoCode, equals('FR'));
        expect(franceMobile.country.isoCode, equals('FR'));
        // expect(franceMobile2.country.isoCode, equals('FR'));
        // expect(franceFix.nsn, equals(franceFixNsnExpected));
        // expect(franceFix2.nsn, equals(franceFixNsnExpected));
        // expect(franceMobile.nsn, equals(franceMobileNsnExpected));
        // expect(franceMobile2.nsn, equals(franceMobileNsnExpected));
      });

      test('should create when not main country for iso code', () {
        final canadaPhone = parse(canadaInternational);
        expect(canadaPhone.country.isoCode, equals('CA'));
        expect(canadaPhone.nsn, equals(canadaNsnExpected));
      });

      test('should create when the phone number changes locally and globally',
          () {
        final arPhone = parse(argentinaInternational);
        expect(arPhone.country.isoCode, equals('AR'));
        expect(arPhone.nsn, equals(argentinaNsnExpected));
      });
      test('should create when there are leading digits', () {
        final amSamoaPhone = parse(amerSamoaInternational);
        expect(amSamoaPhone.country.isoCode, equals('AS'));
        expect(amSamoaPhone.nsn, equals(amerSamoaNsnExpected));
      });

      test('should throw error for empty input', () {
        expect(() => parse(''), throwsA(TypeMatcher<PhoneNumberException>()));
      });
    });
  });
}
