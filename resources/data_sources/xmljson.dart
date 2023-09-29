import 'dart:io';

import 'package:xml/xml.dart';

void main() {
  final file = File('/home/sumit/Downloads/PhoneNumberMetadata.xml');
  final document = XmlDocument.parse(file.readAsStringSync());
  final ter = document.findAllElements("territory");
  var dataList = [];
  var generalDescList = [];
  for (final t in ter) {
    try {
      Map<String, dynamic> terDict = <String, dynamic>{};
      terDict["id"] = t.getAttribute("id");
      if (t.getAttribute("countryCode") != null) {
        terDict["countryCode"] = t.getAttribute("countryCode");
      } else if (t.getAttribute("countrycode") != null) {
        terDict["countryCode"] = t.getAttribute("countrycode");
      }
      if (t.getAttribute("internationalPrefix") != null) {
        terDict["internationalPrefix"] = t.getAttribute("internationalPrefix");
      } else if (t.getAttribute("internationalprefix") != null) {
        terDict["internationalPrefix"] = t.getAttribute("internationalprefix");
      }
      if (t.getAttribute("leadingDigits") != null) {
        terDict["leadingDigits"] = t
            .getAttribute("leadingDigits")!
            .replaceAll("\t", '')
            .replaceAll("\n", '')
            .replaceAll(" ", "");
      } else if (t.getAttribute("leadingdigits") != null) {
        terDict["leadingDigits"] = t
            .getAttribute("leadingdigits")!
            .replaceAll("\t", '')
            .replaceAll("\n", '')
            .replaceAll(" ", "");
      }
      if (t.getAttribute("nationalPrefix") != null) {
        terDict["nationalPrefix"] = t.getAttribute("nationalPrefix");
      } else if (t.getAttribute("nationalprefix") != null) {
        terDict["nationalPrefix"] = t.getAttribute("nationalprefix");
      }
      if (t.getAttribute("nationalPrefixForParsing") != null) {
        terDict["nationalPrefixForParsing"] =
            t.getAttribute("nationalPrefixForParsing");
      } else if (t.getAttribute("nationalprefixforparsing") != null) {
        terDict["nationalPrefixForParsing"] =
            t.getAttribute("nationalprefixforparsing");
      }
      if (t.getAttribute("nationalPrefixTransformRule") != null) {
        terDict["nationalPrefixTransformRule"] =
            t.getAttribute("nationalPrefixTransformRule");
      } else if (t.getAttribute("nationalprefixtransformrule") != null) {
        terDict["nationalPrefixTransformRule"] =
            t.getAttribute("nationalprefixtransformrule");
      }
      if (t.getAttribute("mobileNumberPortableRegion") != null) {
        terDict["mobileNumberPortableRegion"] =
            t.getAttribute("mobileNumberPortableRegion");
      } else if (t.getAttribute("mobilenumberportableregion") != null) {
        terDict["mobileNumberPortableRegion"] =
            t.getAttribute("mobilenumberportableregion");
      }
      if (t.getAttribute("preferredExtnPrefix") != null) {
        terDict["preferredExtnPrefix"] = t.getAttribute("preferredExtnPrefix");
      } else if (t.getAttribute("preferredextnprefix") != null) {
        terDict["preferredExtnPrefix"] = t.getAttribute("preferredextnprefix");
      }
      if (t.getAttribute("mainCountryForCode") != null) {
        terDict["mainCountryForCode"] = t.getAttribute("mainCountryForCode");
      } else if (t.getAttribute("maincountryforcode") != null) {
        terDict["mainCountryForCode"] = t.getAttribute("maincountryforcode");
      }
      if (t.getAttribute("preferredInternationalPrefix") != null) {
        terDict["preferredInternationalPrefix"] =
            t.getAttribute("preferredInternationalPrefix");
      } else if (t.getAttribute("preferredinternationalprefix") != null) {
        terDict["preferredInternationalPrefix"] =
            t.getAttribute("preferredinternationalprefix");
      }
      Iterable<XmlElement> availableFormats =
          t.findAllElements("availableFormats");
      if (availableFormats.isEmpty) {
        availableFormats = t.findAllElements("availableformats");
      }
      if (availableFormats.isNotEmpty) {
        Map<String, dynamic> availableFormatDict = {};
        List<Map<String, dynamic>> numberFormatList = [];
        for (final availableFormat in availableFormats) {
          var numberFormats = availableFormat.findAllElements("numberFormat");
          if (numberFormats.isEmpty) {
            numberFormats = availableFormat.findAllElements("numberformat");
          }
          if (numberFormats.isNotEmpty) {
            for (final numberFormat in numberFormats) {
              Map<String, dynamic> formatDict = {};
              if (numberFormat.getAttribute("pattern") != null) {
                formatDict["pattern"] = numberFormat.getAttribute("pattern");
              }
              if (numberFormat.getAttribute("nationalPrefixFormattingRule") !=
                  null) {
                formatDict["nationalPrefixFormattingRule"] =
                    numberFormat.getAttribute("nationalPrefixFormattingRule");
              } else if (numberFormat
                      .getAttribute("nationalprefixformattingrule") !=
                  null) {
                formatDict["nationalPrefixFormattingRule"] =
                    numberFormat.getAttribute("nationalprefixformattingrule");
              }
              if (numberFormat
                      .getAttribute("nationalPrefixOptionalWhenFormatting") !=
                  null) {
                formatDict["nationalPrefixOptionalWhenFormatting"] =
                    numberFormat
                        .getAttribute("nationalPrefixOptionalWhenFormatting");
              } else if (numberFormat
                      .getAttribute("nationalprefixoptionalwhenformatting") !=
                  null) {
                formatDict["nationalPrefixOptionalWhenFormatting"] =
                    numberFormat
                        .getAttribute("nationalprefixoptionalwhenformatting");
              }
              if (numberFormat.getAttribute("carrierCodeFormattingRule") !=
                  null) {
                formatDict["carrierCodeFormattingRule"] =
                    numberFormat.getAttribute("carrierCodeFormattingRule");
              } else if (numberFormat
                      .getAttribute("carriercodeformattingrule") !=
                  null) {
                formatDict["carrierCodeFormattingRule"] =
                    numberFormat.getAttribute("carriercodeformattingrule");
              }
              var leadingDigits = numberFormat.findAllElements("leadingDigits");
              if (leadingDigits.isEmpty) {
                leadingDigits = numberFormat.findAllElements("leadingdigits");
              }
              if (leadingDigits.length == 1) {
                formatDict["leadingDigits"] = leadingDigits
                    .elementAt(0)
                    .innerText
                    .replaceAll("\t", '')
                    .replaceAll("\n", '')
                    .replaceAll(" ", "");
              } else if (leadingDigits.length > 1) {
                List<String> leadingDigitList = [];
                for (var leadingDigit in leadingDigits) {
                  leadingDigitList.add(leadingDigit.innerText
                      .replaceAll("\t", '')
                      .replaceAll("\n", '')
                      .replaceAll(" ", ""));
                }
                formatDict["leadingDigits"] = leadingDigitList;
              }
              var format = numberFormat.findAllElements("format");
              if (format.length == 1) {
                formatDict["format"] = format.elementAt(0).innerText;
              } else if (format.length > 1) {
                List<String> formatList = [];
                for (final f in format) {
                  formatList.add(f.innerText);
                }
                formatDict["format"] = formatList;
              }
              if (numberFormat.findAllElements("intlFormat").isNotEmpty) {
                formatDict["intlFormat"] =
                    numberFormat.findAllElements("intlFormat");
              } else if (numberFormat
                  .findAllElements("intlformat")
                  .isNotEmpty) {
                formatDict["intlFormat"] =
                    numberFormat.findAllElements("intlformat");
              }
              numberFormatList.add(formatDict);
            }
            if (numberFormats.length > 1) {
              availableFormatDict["numberFormat"] = numberFormatList;
            } else if (numberFormats.length == 1) {
              availableFormatDict["numberFormat"] = numberFormatList[0];
            }
            terDict["availableFormats"] = availableFormatDict;
          }
          var generalDesc = t.findAllElements("generaldesc");
          if (generalDesc.isEmpty) {
            generalDesc = t.findAllElements("generalDesc");
          }
          if (generalDesc.isNotEmpty) {
            Map<String, dynamic> generalDescDict = {};
            if (generalDesc.length == 1) {
              var nationalNumberPattern = generalDesc
                  .elementAt(0)
                  .findAllElements("nationalNumberPattern");
              if (nationalNumberPattern.isEmpty) {
                nationalNumberPattern = generalDesc
                    .elementAt(0)
                    .findAllElements("nationalnumberpattern");
              }
              if (nationalNumberPattern.isNotEmpty) {
                generalDescDict["nationalNumberPattern"] = nationalNumberPattern
                    .elementAt(0)
                    .innerText
                    .replaceAll("\t", '')
                    .replaceAll("\n", '')
                    .replaceAll(" ", '');
              }
            }
            terDict["generalDesc"] = generalDescDict;
             dataList.add(terDict);
          }
          
        }
      }
      print(terDict);
    } catch (e) {
      print(e);
    }
  }
  // final t = ter.elementAt(0);
  // print(t.attributes[0].value);
  // print(t.getAttribute("idk"));
  // for (final t in ter) {
  //   print("==============================================");
  //   print(t.findAllElements("availableFormats"));
  //   print("==============================================");
  // }
}
