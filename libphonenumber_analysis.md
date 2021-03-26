this is pseudo code to keep track of what libphonenumber does, because it does a lot

libphone number

# extract country code

1. get possible country idd from default region
2. calls maybeStripInternationalPrefixAndNormalize which returns:
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

# maybeStripNationalPrefixAndCarrierCode
     - checks begins with national prefix
       - if not there is nothing to do
       - if yes:
         - isViableOriginalNumber = check if match national number pattern and check national pattern is not empty in which case 
         
         - if there is no transform rule or groups in the transform rule:
            - if the original number was viable and the number without the prefix return original
            - else return original with prefix removed 
         - if there is a transform rule then transform, if valid return that or return viable


- skips time stamps and dates patterns