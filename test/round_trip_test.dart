import 'package:phone_numbers_parser/phone_numbers_parser.dart';
import 'package:phone_numbers_parser/src/metadata/generated/country_code_to_iso_code.dart';
import 'package:phone_numbers_parser/src/metadata/generated/metadata_examples_by_iso_code.dart';
import 'package:phone_numbers_parser/src/metadata/metadata_finder.dart';
import 'package:phone_numbers_parser/src/metadata/models/phone_metadata_examples.dart';
import 'package:phone_numbers_parser/src/regex/constants.dart';
import 'package:test/test.dart';

/// the (type, national number) pairs contained in [examples]
Iterable<(String, String)> _examplesOf(PhoneMetadataExamples examples) sync* {
  yield ('fixedLine', examples.fixedLine);
  yield ('mobile', examples.mobile);
  yield ('voip', examples.voip);
  yield ('tollFree', examples.tollFree);
  yield ('premiumRate', examples.premiumRate);
  yield ('sharedCost', examples.sharedCost);
  yield ('personalNumber', examples.personalNumber);
  yield ('uan', examples.uan);
  yield ('pager', examples.pager);
  yield ('voiceMail', examples.voiceMail);
}

/// (isoCode, type, national number, international number)
typedef _Case = (IsoCode, String, String, String);

void main() {
  final cases = <_Case>[];
  for (final entry in metadataExamplesByIsoCode.entries) {
    final isoCode = entry.key;
    final countryCode =
        MetadataFinder.findMetadataForIsoCode(isoCode).countryCode;
    for (final (type, nsn) in _examplesOf(entry.value)) {
      if (nsn.isEmpty) continue;
      cases.add((isoCode, type, nsn, '+$countryCode$nsn'));
    }
  }

  group('round trip of every metadata example', () {
    test('should have example numbers to test', () {
      expect(cases, isNotEmpty);
    });

    test('should parse the national number given its destination country', () {
      for (final (isoCode, type, nsn, international) in cases) {
        expect(
          PhoneNumber.parse(nsn, destinationCountry: isoCode).international,
          equals(international),
          reason: '$isoCode $type "$nsn"',
        );
      }
    });

    test('should parse the national number given its caller country', () {
      for (final (isoCode, type, nsn, international) in cases) {
        expect(
          PhoneNumber.parse(nsn, callerCountry: isoCode).international,
          equals(international),
          reason: '$isoCode $type "$nsn"',
        );
      }
    });

    test('should parse the international number', () {
      // when several countries share a country code (e.g. +1) the parser
      // resolves the country using patterns, so the resolved iso code can
      // legitimately differ from the one the example was taken from.
      final sharedCountryCodes = {
        for (final entry in countryCodeToIsoCode.entries)
          if (entry.value.length > 1) entry.key,
      };
      for (final (isoCode, type, nsn, international) in cases) {
        final parsed = PhoneNumber.parse(international);
        expect(
          parsed.international,
          equals(international),
          reason: '$isoCode $type "$nsn"',
        );
        if (!sharedCountryCodes.contains(parsed.countryCode)) {
          expect(parsed.isoCode, equals(isoCode), reason: '$isoCode $type');
        }
      }
    });

    test('should consider every example number valid', () {
      for (final (isoCode, type, nsn, _) in cases) {
        // KZ has a faulty example in the upstream metadata
        if (isoCode == IsoCode.KZ) continue;
        expect(
          PhoneNumber.parse(nsn, destinationCountry: isoCode).isValid(),
          isTrue,
          reason: '$isoCode $type "$nsn"',
        );
      }
    });

    test(
        'should parse a prefixed local number when the nsn starts with the '
        'national prefix', () {
      // regression test for https://github.com/cedvdb/phone_numbers_parser/issues/123
      // the national prefix used to be removed twice, which rejected numbers
      // such as RU 8 800 ... where the nsn itself starts with 8.
      var checked = 0;
      for (final (isoCode, type, nsn, international) in cases) {
        final nationalPrefix =
            MetadataFinder.findMetadataForIsoCode(isoCode).nationalPrefix;
        if (nationalPrefix == null || !nsn.startsWith(nationalPrefix)) {
          continue;
        }
        checked++;
        expect(
          PhoneNumber.parse('$nationalPrefix$nsn', callerCountry: isoCode)
              .international,
          equals(international),
          reason: '$isoCode $type "$nsn"',
        );
      }
      expect(checked, greaterThan(0));
    });

    test('should parse a prefixed local number when the metadata transforms it',
        () {
      // countries with a nationalPrefixTransformRule (e.g. AR turns
      // 0343 15 555 1212 into 9 343 555 1212) need the transform to receive
      // the number including its national prefix.
      var checked = 0;
      for (final (isoCode, type, nsn, international) in cases) {
        final metadata = MetadataFinder.findMetadataForIsoCode(isoCode);
        final patterns = MetadataFinder.findMetadataPatternsForIsoCode(isoCode);
        final nationalPrefix = metadata.nationalPrefix;
        if (nationalPrefix == null ||
            patterns.nationalPrefixTransformRule == null) {
          continue;
        }
        checked++;
        expect(
          PhoneNumber.parse('$nationalPrefix$nsn', callerCountry: isoCode)
              .international,
          equals(international),
          reason: '$isoCode $type "$nsn"',
        );
      }
      expect(checked, greaterThan(0));
    });

    test('should parse the national format of every example number', () {
      // a form field displays the national format and parses it back, so that
      // round trip has to be lossless.
      for (final (isoCode, type, nsn, _) in cases) {
        final parsed = PhoneNumber.parse(nsn, destinationCountry: isoCode);
        final national = parsed.format(format: PhoneNumberFormat.national);
        expect(
          PhoneNumber.parse(national, destinationCountry: isoCode).nsn,
          equals(parsed.nsn),
          reason: '$isoCode $type "$nsn" formatted as "$national"',
        );
      }
    });
  });

  group('country calling codes', () {
    test('should not have a country code that is a prefix of another one', () {
      // this assumption is relied upon when extracting a country code from a
      // phone number prefix. If it were broken, a shorter code could shadow a
      // longer one.
      final codes = countryCodeToIsoCode.keys.toList();
      for (final short in codes) {
        for (final long in codes) {
          if (short == long) continue;
          expect(
            long.startsWith(short),
            isFalse,
            reason: '"$short" is a prefix of "$long"',
          );
        }
      }
    });

    test('should map every country code to at least one iso code', () {
      for (final entry in countryCodeToIsoCode.entries) {
        expect(entry.value, isNotEmpty, reason: 'country code ${entry.key}');
      }
    });

    test('should only map a country code to iso codes owning that code', () {
      // PhoneParser relies on this to know that once a country code was found
      // in a phone number, its metadata is guaranteed to exist.
      for (final entry in countryCodeToIsoCode.entries) {
        for (final isoCode in entry.value) {
          expect(
            MetadataFinder.findMetadataForIsoCode(isoCode).countryCode,
            equals(entry.key),
            reason: '$isoCode should have country code ${entry.key}',
          );
        }
      }
    });

    test('should have a length within the documented bounds', () {
      for (final code in countryCodeToIsoCode.keys) {
        expect(
          code.length,
          inInclusiveRange(
            Constants.minLengthCountryCallingCode,
            Constants.maxLengthCountryCallingCode,
          ),
          reason: 'country code "$code"',
        );
      }
    });

    test('should have examples at least as long as minLengthCountryPlusNsn',
        () {
      // the shortest numbers the metadata can produce, this guards against
      // metadata regressions that would make the parser reject valid numbers.
      for (final (isoCode, type, nsn, international) in cases) {
        expect(
          international.length - 1, // minus the '+' prefix
          greaterThanOrEqualTo(Constants.minLengthCountryPlusNsn),
          reason: '$isoCode $type "$nsn"',
        );
      }
    });
  });
}
