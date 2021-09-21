
## 3.0.0
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
