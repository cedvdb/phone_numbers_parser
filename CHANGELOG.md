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
- added displayDialCode on country which is a mix of dial code and leading digits
- added copyWithIsoCode as instance method on phone number to make it
  easy to switch between countries in a phone number input
- added toString to exception

## 0.0.2

- added some doc, by Cedvdb

## 0.0.1

- Initial version, created by Cedvdb
