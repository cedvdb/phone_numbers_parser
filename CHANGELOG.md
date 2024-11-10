## 9.0.2
- Fix format for argentinian phone number 

## 9.0.1
- Fix wrong format for some countries 

## 9.0.0
- Added a format parameter to choose between international and national format
- Format now uses the national format by default

## 8.3.0
- added support for remaining phoneNumberTypes (thanks @cottonman132 )

## 8.2.2
- update metadata

## 8.2.1
- add demo link in readme

## 8.2.0
- added VOIP support
- udpated metadata
- Removed `MinMaxUtils` that was unused internally. While exported publically it was undocumented. 

## 8.1.3
- deprectate `getFormattedNsn` in favor of `formatNsn`

## 8.1.2
- lower meta dependency version for flutter compat

## 8.1.1
- updated metadata

## 8.1.0
- updated metadata
- fix for local phone numbers not parsing accurately (issue 46)
- phone numbers starting with the country code of the destination country will now return the phone number
  without the country code if the phone number is valid without it.
- refactor some internal


## 8.0.0

- made it easier to contribute
- remove dependency on dart_countries and phone_number_metadata and instead work as a monorepo for easier contribution.
- upgrade metadata


## 7.0.2

- Changed behavior to not remove the country code from an incomplete phone number that did not start with an exit code.


## 7.0.1

- Fix issue where international phone numbers would be transformed as if those were local ones.

## 7.0.0
This major introduces a more accurate parsing logic taking into account caller and destination country.


- add `parse` method which takes as parameters `callerCountry` and `destinationCountry`
- [Breaking]: removed most factory methods on `PhoneNumber` in favor of `parse`, see readme
- [Breaking]: renamed `validate` and `validateWithLength` to `isValid` and `isValidateLength`
- updated metadata
- PhoneNumber.findPotentialPhoneNumbers now returns a list of phone number when scanning text.


## 6.0.1
- please use 6.0.0 or upgrade to 7.0.0, this is a faulty version.
- deprecated factories

## 6.0.0
- [Breaking]: removed fromMap, toMap which have been replaced by fromJson(Map), toJson respectively.

## 5.0.5
- improved readme

## 5.0.4
- improved readme
- upgraded deps

## 5.0.3
- updated metadata

## 5.0.0
- [Breaking] all iso code api now use IsoCode enum
- fix for parseRaw when only country code is present.

## 4.2.1
  - make phone number json serializable

## 4.2.0
  - Fix incorrect parsing in some cases
  - fix validate length as it was incorrectly validating with pattern

## 4.1.0
  - only modify national number to its international version when it is valid
  - resolve issue where phone number were incorrectly parsed if national number started with country code (it happens)

## 4.0.1

  - reexport deprecated public api for backward comp

## 4.0.0 Consolidating Public API

This release removes the LightPhoneParser because it was not working perfectly and the cost of maintaining
two parsers is too high.

Removing that parser allowed to revert to a more succint public API, where methods should be accessed
solely via the PhoneNumber class.

PhoneParser,  PhoneNumberFormatter and the likes are still exported for backward compatibility but it is advised 
to switch to PhoneNumber's methods instead

- [Breaking]: LightPhoneParser has been removed as it was imperfect and added complexity in maintaining two parsers.
- [Deprecated]: PhoneParser methods have been deprecated in favor of the methods on PhoneNumber class

## 3.0.2
- fix formatter error when empty input

## 3.0.1
- added [parseNational]

## 3.0.0
- added localized formatter to format a phone number in an human readable way
- added PhoneNumberRanges and utility operators on PhoneNumber (thanks @bsutton)
- renamed [dialCode] to [countryCode] as dialCode was semantically incorrect

## 2.0.1
- rename base class for parsers to BasePhoneParser, as parser was too broad.
- export BasePhoneParser

## 2.0.0
- Resolve issue #1 where it was possible to significantly increase memory foothprint by importing both parsers. Thanks @xvrh 
- Deplaced validate method from PhoneNumber to PhoneParser and LightPhoneParser to 
  make it more obvious that one is 
- Light parser can now parseWithDialCode and parseRaw, although less accurate than the full parser

## 1.0.5
- Minor doc change

## 1.0.4
- Added metadata property runtime type to toString to make it more obvious when two instances are not equals

## 1.0.3
- Made toString more readable

## 1.0.2
- Add toString to PhoneNumber

## 1.0.1
- validate method on PhoneNumber

## 1.0.0
- There are now two parsers:
   - PhoneParser: Heavy, more accurate and more computationally intensive (relies on pattern matching)
   - LightPhoneParser: Light, somewhat accurate and less computationally intensive (relies on length)
   If a light validation based on length suffice, LightPhoneParser can be used, assuming you don't import
   the other parser, that will decrease the library size footprint.

  With this change a few breaking changes had to be made
- [Breaking]: PhoneNumber creation is now made with parsers:

  before:
  ```dart
  final frPhone = PhoneNumber.fromRaw('+33 655 5705 76');
  final frPhone1 = PhoneNumber.fromIsoCode('FR', '655 5705 76');
  ```

  after:
  ```dart
  final frPhone = PhoneParser.fromRaw('+33 655 5705 76')
  final frPhone1 = LightPhoneParser.fromIsoCode('FR', '655 5705 76');
  ```

- [Breaking]: removed country class and country list, which are now in a separate library

## 0.2.0
* extracted country data files to another library dart_countries as it can be used in other scenarios
* [Breaking]: Country.getDisplayDialCode is now a getter Country.displayIsoCode.

## 0.1.4
* upgrade dependencies

## 0.1.3
* deprecate valid property on phone number
* make phone number type in validate method nullable to validate against general type

## 0.1.2
* rename example so it shows in pub.dev

## 0.1.1
* Add example

## 0.1.0

- fix substantial bug where validity would be true for longer numbers
- added validity check on phone number to further check validity for a given phone number type (mobile, fixedLine)
- added more tests

## 0.0.5

- Breaking: remove getters for leading digits as it sometimes contains patterns
- Put space in American Samoa's name

## 0.0.4 

- changed displayDialCode getter into method to allow for different syntax

## 0.0.3

- added toString to PhoneNumber
- added leading digits getter to country
- added displayDialCode on country which is a mix of country code and leading digits
- added copyWithIsoCode as instance method on phone number to make it
  easy to switch between countries in a phone number input
- added toString to exception

## 0.0.2

- added some doc, by Cedvdb

## 0.0.1

- Initial version, created by Cedvdb
