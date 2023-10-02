import 'package:phone_numbers_parser/src/metadata/generated/metadata_lengths_by_iso_code.dart';
import 'package:phone_numbers_parser/src/models/iso_code.dart';
import 'package:phone_numbers_parser/src/models/phone_number_type.dart';

class MinMaxUtils{
  static MinMaxLength getMaxMinLengthByIsoCode(IsoCode isoCode, PhoneNumberType phoneNumberType){
    if(phoneNumberType == PhoneNumberType.mobile) {
     final data = metadataLenghtsByIsoCode[isoCode]!.mobile;
     if(data.isNotEmpty){
       return MinMaxLength(data.first, data.last);
     }
    }else if(phoneNumberType == PhoneNumberType.fixedLine){
  final data = metadataLenghtsByIsoCode[isoCode]!.fixedLine;
     if(data.isNotEmpty){
       return MinMaxLength(data.first, data.last);
     }
    }
    return MinMaxLength(15, 15);
  } 
}

class MinMaxLength{
  int maxLength;
  int minLength;
  MinMaxLength(this.minLength, this.maxLength);
}