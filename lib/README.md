
# national_number_pattern;
  // The national_number_pattern is the pattern that a valid national
  // significant number would match. This specifies information such as its
  // total length and leading digits.

# possible_length
  // These represent the lengths a phone number from this region can be. They
  // will be sorted from smallest to biggest. Note that these lengths are for
  // the full number, without country calling code or national prefix. For
  // example, for the Swiss number +41789270000, in local format 0789270000,
  // this would be 9.
  // This could be used to highlight tokens in a text that may be a phone
  // number, or to quickly prune numbers that could not possibly be a phone
  // number for this locale.

  // These represent the lengths that only local phone numbers (without an area
  // code) from this region can be. They will be sorted from smallest to
  // biggest. For example, since the American number 456-1234 may be locally
  // diallable, although not diallable from outside the area, 7 could be a
  // possible value.
  // This could be used to highlight tokens in a text that may be a phone
  // number.
  // To our knowledge, area codes are usually only relevant for some fixed-line
  // and mobile numbers, so this field should only be set for those types of
  // numbers (and the general description) - however there are exceptions for
  // NANPA countries.
  // This data is used to calculate whether a number could be a possible number
  // for a particular type.
  repeated int32 possible_length_local_only = 10;

  // An example national significant number for the specific type. It should
  // not contain any formatting information.
  optional string example_number = 6;
}

// If you add, remove, or rename fields, or change their semantics, check if you
// should change the excludable field sets or the behavior in MetadataFilter.
message PhoneMetadata {
  // The general_desc contains information which is a superset of descriptions
  // for all types of phone numbers. If any element is missing in the
  // description of a specific type in the XML file, the element will inherit
  // from its counterpart in the general_desc. For all types that are generally
  // relevant to normal phone numbers, if the whole type is missing in the
  // PhoneNumberMetadata XML file, it will not have national number data, and
  // the possible lengths will be [-1].
  optional PhoneNumberDesc general_desc = 1;
  optional PhoneNumberDesc fixed_line = 2;
  optional PhoneNumberDesc mobile = 3;
  optional PhoneNumberDesc toll_free = 4;
  optional PhoneNumberDesc premium_rate = 5;
  optional PhoneNumberDesc shared_cost = 6;
  optional PhoneNumberDesc personal_number = 7;
  optional PhoneNumberDesc voip = 8;
  optional PhoneNumberDesc pager = 21;
  optional PhoneNumberDesc uan = 25;
  optional PhoneNumberDesc emergency = 27;
  optional PhoneNumberDesc voicemail = 28;
  optional PhoneNumberDesc short_code = 29;
  optional PhoneNumberDesc standard_rate = 30;
  optional PhoneNumberDesc carrier_specific = 31;
  optional PhoneNumberDesc sms_services = 33;

  // The rules here distinguish the numbers that are only able to be dialled
  // nationally.
  optional PhoneNumberDesc no_international_dialling = 24;

  // The CLDR 2-letter representation of a country/region, with the exception of
  // "country calling codes" used for non-geographical entities, such as
  // Universal International Toll Free Number (+800). These are all given the ID
  // "001", since this is the numeric region code for the world according to UN
  // M.49: http://en.wikipedia.org/wiki/UN_M.49
  required string id = 9;

  // The country calling code that one would dial from overseas when trying to
  // dial a phone number in this country. For example, this would be "64" for
  // New Zealand.
  optional int32 country_code = 10;

  // The international_prefix of country A is the number that needs to be
  // dialled from country A to another country (country B). This is followed
  // by the country code for country B. Note that some countries may have more
  // than one international prefix, and for those cases, a regular expression
  // matching the international prefixes will be stored in this field.
  optional string international_prefix = 11;

  // If more than one international prefix is present, a preferred prefix can
  // be specified here for out-of-country formatting purposes. If this field is
  // not present, and multiple international prefixes are present, then "+"
  // will be used instead.
  optional string preferred_international_prefix = 17;

  // The national prefix of country A is the number that needs to be dialled
  // before the national significant number when dialling internally. This
  // would not be dialled when dialling internationally. For example, in New
  // Zealand, the number that would be locally dialled as 09 345 3456 would be
  // dialled from overseas as +64 9 345 3456. In this case, 0 is the national
  // prefix.
  optional string national_prefix = 12;

  // The preferred prefix when specifying an extension in this country. This is
  // used for formatting only, and if this is not specified, a suitable default
  // should be used instead. For example, if you wanted extensions to be
  // formatted in the following way:
  // 1 (365) 345 445 ext. 2345
  // " ext. "  should be the preferred extension prefix.
  optional string preferred_extn_prefix = 13;

  // This field is used for cases where the national prefix of a country
  // contains a carrier selection code, and is written in the form of a
  // regular expression. For example, to dial the number 2222-2222 in
  // Fortaleza, Brazil (area code 85) using the long distance carrier Oi
  // (selection code 31), one would dial 0 31 85 2222 2222. Assuming the
  // only other possible carrier selection code is 32, the field will
  // contain "03[12]".
  //
  // When it is missing from the XML file, this field inherits the value of
  // national_prefix, if that is present.
  optional string national_prefix_for_parsing = 15;

  // This field is only populated and used under very rare situations.
  // For example, mobile numbers in Argentina are written in two completely
  // different ways when dialed in-country and out-of-country
  // (e.g. 0343 15 555 1212 is exactly the same number as +54 9 343 555 1212).
  // This field is used together with national_prefix_for_parsing to transform
  // the number into a particular representation for storing in the phonenumber
  // proto buffer in those rare cases.
  optional string national_prefix_transform_rule = 16;

  // Specifies whether the mobile and fixed-line patterns are the same or not.
  // This is used to speed up determining phone number type in countries where
  // these two types of phone numbers can never be distinguished.
  optional bool same_mobile_and_fixed_line_pattern = 18 [default=false];

  // Note that the number format here is used for formatting only, not parsing.
  // Hence all the varied ways a user *may* write a number need not be recorded
  // - just the ideal way we would like to format it for them. When this element
  // is absent, the national significant number will be formatted as a whole
  // without any formatting applied.
  repeated NumberFormat number_format = 19;

  // This field is populated only when the national significant number is
  // formatted differently when it forms part of the INTERNATIONAL format
  // and NATIONAL format. A case in point is mobile numbers in Argentina:
  // The number, which would be written in INTERNATIONAL format as
  // +54 9 343 555 1212, will be written as 0343 15 555 1212 for NATIONAL
  // format. In this case, the prefix 9 is inserted when dialling from
  // overseas, but otherwise the prefix 0 and the carrier selection code
  // 15 (inserted after the area code of 343) is used.
  // Note: this field is populated by setting a value for <intlFormat> inside
  // the <numberFormat> tag in the XML file. If <intlFormat> is not set then it
  // defaults to the same value as the <format> tag.
  //
  // Examples:
  //   To set the <intlFormat> to a different value than the <format>:
  //     <numberFormat pattern=....>
  //       <format>$1 $2 $3</format>
  //       <intlFormat>$1-$2-$3</intlFormat>
  //     </numberFormat>
  //
  //   To have a format only used for national formatting, set <intlFormat> to
  //   "NA":
  //     <numberFormat pattern=....>
  //       <format>$1 $2 $3</format>
  //       <intlFormat>NA</intlFormat>
  //     </numberFormat>
  repeated NumberFormat intl_number_format = 20;

  // This field is set when this country is considered to be the main country
  // for a calling code. It may not be set by more than one country with the
  // same calling code, and it should not be set by countries with a unique
  // calling code. This can be used to indicate that "GB" is the main country
  // for the calling code "44" for example, rather than Jersey or the Isle of
  // Man.
  optional bool main_country_for_code = 22 [default=false];

  // This field is populated only for countries or regions that share a country
  // calling code. If a number matches this pattern, it could belong to this
  // region. This is not intended as a replacement for IsValidForRegion since a
  // matching prefix is insufficient for a number to be valid. Furthermore, it
  // does not contain all the prefixes valid for a region - for example, 800
  // numbers are valid for all NANPA countries and are hence not listed here.
  // This field should be a regular expression of the expected prefix match.
  // It is used merely as a short-cut for working out which region a number
  // comes from in the case that there is only one, so leading_digit prefixes
  // should not overlap.
  optional string leading_digits = 23;

  // Deprecated: do not use. Will be deletd when there are no references to this
  // later.
  optional bool leading_zero_possible = 26 [default=false];

  // This field is set when this country has implemented mobile number
  // portability. This means that transferring mobile numbers between carriers
  // is allowed. A consequence of this is that phone prefix to carrier mapping
  // is less reliable.
  optional bool mobile_number_portable_region = 32 [default=false];
}

message PhoneMetadataCollection {
  repeated PhoneMetadata metadata = 1;
}