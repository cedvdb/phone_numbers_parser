import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:test/test.dart';

void main() {
  group('Phone number formatter', () {
    test('should format nsn US', () {
      final parser = PhoneParser();
      final formatter = PhoneNumberFormatter();
      final format = (String phoneNumber) =>
          formatter.formatNsn(parser.parseWithIsoCode('US', phoneNumber));
      var testNumber = '2';
      expect(format(testNumber), equals('2'));
      testNumber = '20';
      expect(format(testNumber), equals('20'));
      testNumber = '202';
      expect(format(testNumber), equals('202'));
      testNumber = '2025';
      expect(format(testNumber), equals('202-5'));
      testNumber = '20255';
      expect(format(testNumber), equals('202-55'));
      testNumber = '202555';
      expect(format(testNumber), equals('202-555'));
      testNumber = '2025550';
      expect(format(testNumber), equals('202-555-0'));
      testNumber = '20255501';
      expect(format(testNumber), equals('202-555-01'));
      testNumber = '202555011';
      expect(format(testNumber), equals('202-555-011'));
      testNumber = '2025550119';
      expect(format(testNumber), equals('202-555-0119'));
    });

    test('should format nsn FR', () {
      final parser = PhoneParser();
      final formatter = PhoneNumberFormatter();
      final format = (String phoneNumber) =>
          formatter.formatNsn(parser.parseWithIsoCode('FR', phoneNumber));

      var testNumber = '6';
      expect(format(testNumber), equals('6'));
      testNumber = '68';
      expect(format(testNumber), equals('6 8'));
      testNumber = '689';
      expect(format(testNumber), equals('6 89'));
      testNumber = '6895';
      expect(format(testNumber), equals('6 89 5'));
      testNumber = '68955';
      expect(format(testNumber), equals('6 89 55'));
      testNumber = '689555';
      expect(format(testNumber), equals('6 89 55 5'));
      testNumber = '6895555';
      expect(format(testNumber), equals('6 89 55 55'));
      testNumber = '68955555';
      expect(format(testNumber), equals('6 89 55 55 5'));
      testNumber = '689555555';
      expect(format(testNumber), equals('6 89 55 55 55'));
    });
  });
}
