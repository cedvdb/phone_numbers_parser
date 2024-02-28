import 'package:phone_numbers_parser/src/metadata/models/phone_metadata.dart';
import 'package:phone_numbers_parser/src/iso_codes/iso_code.dart';

Map<String, List<IsoCode>> countryCodeToIsoCodeMap(
  Map<IsoCode, PhoneMetadata> allMetadatas,
) {
  final map = <String, List<IsoCode>>{};
  for (var m in allMetadatas.values) {
    final countryCode = m.countryCode;
    final isMainCountry = m.isMainCountryForDialCode;
    if (map[countryCode] == null) {
      map[countryCode] = [];
    }
    // we insert the main country at the start of the array so it's easy to find
    if (isMainCountry == true) {
      map[countryCode]!.insert(0, m.isoCode);
    } else {
      map[countryCode]!.add(m.isoCode);
    }
  }
  return map;
}
