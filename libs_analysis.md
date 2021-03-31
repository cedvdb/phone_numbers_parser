this is pseudo code to keep track of what libphonenumber does, because it does a lot


# new algo

## extract country code

  1. check number starts with +
    - yes: easy
  2. if not stripInternationlPrefix:

## strip international prefix

 - if number starts with + return ['+number']
 - else check default country 
   - if match strip and return [number, prefix] and check next digit
 - if starts with 00 or 011 strip
 - if no default country => not a valid phone number

# libphone number

## extract country code

1. get possible country idd from default region
2. calls **maybeStripInternationalPrefixAndNormalize** which returns:
   - if the number starts with a plus: DialCodeSource.FROM_NUMBER_WITH_PLUS
   - if the phone number starts with the default idd we check the next number to see
      if it's not 0 if it is not zero DialCodeSource.FROM_NUMBER_WITH_IDD
      if it is 0 DialCodeSource.FROM_DEFAULT_COUNTRY
      if it does not start with the idd DialCodeSource.FROM_DEFAULT_COUNTRY
3. if dial code source is different from DialCodeSource.FROM_DEFAULT_COUNTRY: (could be idd removed or + removed)
   - checks Country codes do not begin with a '0'
   - for 1 to MAX_LENGTH_COUNTRY_CODE check if dialCodeMap contains key, when found return key

4. else if there is default country
  - check to see if the number starts with the dial code from the default region
      - if yes => return that
      - if not assumes we don't know
  - potentialNationalNumber maybeStripNationalPrefixAndCarrierCode
        // If the number was not valid before but is valid now, or if it was too long before, we
        // consider the number with the country calling code stripped to be a better result and
        // keep that instead.

replace national prefix

## maybeStripNationalPrefixAndCarrierCode
     - checks begins with national prefix
       - if not there is nothing to do
       - if yes:
         - isViableOriginalNumber = check if match national number pattern and check national pattern is not empty in which case 
         
         - if there is no transform rule or groups in the transform rule:
            - if the original number was viable and the number without the prefix return original
            - else return original with prefix removed 
         - if there is a transform rule then transform, if valid return that or else return viable


- skips time stamps and dates patterns

# Parse

  - extract phone number
  - check is viable
  - check that is has default region or + sign or throw
  - extract country code
  - get isocode for country (first match)
  - test length



# Phone number kit

more succint code


## extract country code

```swift
 func extractPotentialCountryCode(_ fullNumber: String, nationalNumber: inout String) -> UInt64? {
        let nsFullNumber = fullNumber as NSString
        if nsFullNumber.length == 0 || nsFullNumber.substring(to: 1) == "0" {
            return 0
        }
        let numberLength = nsFullNumber.length
        let maxCountryCode = PhoneNumberConstants.maxLengthCountryCode
        var startPosition = 0
        if fullNumber.hasPrefix("+") {
            if nsFullNumber.length == 1 {
                return 0
            }
            startPosition = 1
        }
        for i in 1...numberLength {
            if i > maxCountryCode {
                break
            }
            let stringRange = NSRange(location: startPosition, length: i)
            let subNumber = nsFullNumber.substring(with: stringRange)
            if let potentialCountryCode = UInt64(subNumber), metadata.territoriesByCode[potentialCountryCode] != nil {
                nationalNumber = nsFullNumber.substring(from: i)
                return potentialCountryCode
            }
        }
        return 0
    }

```

## string international prefix

```swift
    func stripInternationalPrefixAndNormalize(_ number: inout String, possibleIddPrefix: String?) -> PhoneNumberCountryCodeSource {
        if self.regex.matchesAtStart(PhoneNumberPatterns.leadingPlusCharsPattern, string: number as String) {
            number = self.regex.replaceStringByRegex(PhoneNumberPatterns.leadingPlusCharsPattern, string: number as String)
            return .numberWithPlusSign
        }
        number = self.normalizePhoneNumber(number as String)
        guard let possibleIddPrefix = possibleIddPrefix else {
            return .numberWithoutPlusSign
        }
        let prefixResult = self.parsePrefixAsIdd(&number, iddPattern: possibleIddPrefix)
        if prefixResult == true {
            return .numberWithIDD
        } else {
            return .defaultCountry
        }
    }
```

## stripNationalPrefix
```swift
guard let possibleNationalPrefix = metadata.nationalPrefixForParsing else {
            return
        }
 let prefixPattern = "^(?:\(possibleNationalPrefix))"
        #endif
        do {
            let matches = try regex.regexMatches(prefixPattern, string: number)
            if let firstMatch = matches.first {
                let nationalNumberRule = metadata.generalDesc?.nationalNumberPattern
                let firstMatchString = number.substring(with: firstMatch.range)
                let numOfGroups = firstMatch.numberOfRanges - 1
                var transformedNumber: String = String()
                let firstRange = firstMatch.range(at: numOfGroups)
                let firstMatchStringWithGroup = (firstRange.location != NSNotFound && firstRange.location < number.count) ? number.substring(with: firstRange) : String()
                let firstMatchStringWithGroupHasValue = self.regex.hasValue(firstMatchStringWithGroup)
                if let transformRule = metadata.nationalPrefixTransformRule, firstMatchStringWithGroupHasValue == true {
                    transformedNumber = self.regex.replaceFirstStringByRegex(prefixPattern, string: number, templateString: transformRule)
                } else {
                    let index = number.index(number.startIndex, offsetBy: firstMatchString.count)
                    transformedNumber = String(number[index...])
                }
                if self.regex.hasValue(nationalNumberRule), self.regex.matchesEntirely(nationalNumberRule, string: number), self.regex.matchesEntirely(nationalNumberRule, string: transformedNumber) == false {
                    return
                }
                number = transformedNumber
                return
            }
```