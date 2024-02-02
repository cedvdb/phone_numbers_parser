import 'dart:convert';
import 'dart:io';

import 'package:xml/xml.dart';

extension ReplaceCarrigage on String {
  replaceCarriages() {
    return replaceAll("\t", '')
        .replaceAll("\n", '')
        .replaceAll("\r", '')
        .replaceAll(" ", "");
  }
}

Future<void> convertXMLToJson() async {
  final file = File('resources/data_sources/PhoneNumberMetadata.xml');
  final document = XmlDocument.parse(file.readAsStringSync());
  final territoryIterable = document.findAllElements("territory");
  List dataList = [];
  for (final territory in territoryIterable) {
    try {
      Map<String, dynamic> territoryDict = <String, dynamic>{};
      territoryDict["id"] = territory.getAttribute("id");
      if (territory.getAttribute("countryCode") != null) {
        territoryDict["countryCode"] = territory.getAttribute("countryCode");
      } else if (territory.getAttribute("countrycode") != null) {
        territoryDict["countryCode"] = territory.getAttribute("countrycode");
      }
      if (territory.getAttribute("internationalPrefix") != null) {
        territoryDict["internationalPrefix"] =
            territory.getAttribute("internationalPrefix");
      } else if (territory.getAttribute("internationalprefix") != null) {
        territoryDict["internationalPrefix"] =
            territory.getAttribute("internationalprefix");
      }
      if (territory.getAttribute("leadingDigits") != null) {
        territoryDict["leadingDigits"] =
            territory.getAttribute("leadingDigits")!.replaceCarriages();
      } else if (territory.getAttribute("leadingdigits") != null) {
        territoryDict["leadingDigits"] =
            territory.getAttribute("leadingdigits")!.replaceCarriages();
      }
      if (territory.getAttribute("nationalPrefix") != null) {
        territoryDict["nationalPrefix"] =
            territory.getAttribute("nationalPrefix")!.replaceCarriages();
      } else if (territory.getAttribute("nationalprefix") != null) {
        territoryDict["nationalPrefix"] =
            territory.getAttribute("nationalprefix")!.replaceCarriages();
      }
      if (territory.getAttribute("nationalPrefixForParsing") != null) {
        territoryDict["nationalPrefixForParsing"] = territory
            .getAttribute("nationalPrefixForParsing")!
            .replaceCarriages();
      } else if (territory.getAttribute("nationalprefixforparsing") != null) {
        territoryDict["nationalPrefixForParsing"] = territory
            .getAttribute("nationalprefixforparsing")!
            .replaceCarriages();
      }
      if (territory.getAttribute("nationalPrefixTransformRule") != null) {
        territoryDict["nationalPrefixTransformRule"] = territory
            .getAttribute("nationalPrefixTransformRule")!
            .replaceCarriages();
      } else if (territory.getAttribute("nationalprefixtransformrule") !=
          null) {
        territoryDict["nationalPrefixTransformRule"] = territory
            .getAttribute("nationalprefixtransformrule")!
            .replaceCarriages();
      }
      if (territory.getAttribute("mobileNumberPortableRegion") != null) {
        territoryDict["mobileNumberPortableRegion"] = territory
            .getAttribute("mobileNumberPortableRegion")!
            .replaceCarriages();
      } else if (territory.getAttribute("mobilenumberportableregion") != null) {
        territoryDict["mobileNumberPortableRegion"] = territory
            .getAttribute("mobilenumberportableregion")!
            .replaceCarriages();
      }
      if (territory.getAttribute("preferredExtnPrefix") != null) {
        territoryDict["preferredExtnPrefix"] =
            territory.getAttribute("preferredExtnPrefix");
      } else if (territory.getAttribute("preferredextnprefix") != null) {
        territoryDict["preferredExtnPrefix"] =
            territory.getAttribute("preferredextnprefix");
      }
      if (territory.getAttribute("mainCountryForCode") != null) {
        territoryDict["mainCountryForCode"] =
            territory.getAttribute("mainCountryForCode");
      } else if (territory.getAttribute("maincountryforcode") != null) {
        territoryDict["mainCountryForCode"] =
            territory.getAttribute("maincountryforcode");
      }
      if (territory.getAttribute("preferredInternationalPrefix") != null) {
        territoryDict["preferredInternationalPrefix"] =
            territory.getAttribute("preferredInternationalPrefix");
      } else if (territory.getAttribute("preferredinternationalprefix") !=
          null) {
        territoryDict["preferredInternationalPrefix"] =
            territory.getAttribute("preferredinternationalprefix");
      }
      Iterable<XmlElement> availableFormats =
          territory.findAllElements("availableFormats");
      if (availableFormats.isEmpty) {
        availableFormats = territory.findAllElements("availableformats");
      }
      if (availableFormats.isNotEmpty) {
        Map<String, dynamic> availableFormatDict = {};
        List<Map<String, dynamic>> numberFormatList = [];
        for (final availableFormat in availableFormats) {
          Iterable<XmlElement> numberFormats =
              availableFormat.findAllElements("numberFormat");
          if (numberFormats.isEmpty) {
            numberFormats = availableFormat.findAllElements("numberformat");
          }
          if (numberFormats.isNotEmpty) {
            for (final numberFormat in numberFormats) {
              Map<String, dynamic> numberFormatDict = {};
              if (numberFormat.getAttribute("pattern") != null) {
                numberFormatDict["pattern"] =
                    numberFormat.getAttribute("pattern");
              }
              if (numberFormat.getAttribute("nationalPrefixFormattingRule") !=
                  null) {
                numberFormatDict["nationalPrefixFormattingRule"] =
                    numberFormat.getAttribute("nationalPrefixFormattingRule");
              } else if (numberFormat
                      .getAttribute("nationalprefixformattingrule") !=
                  null) {
                numberFormatDict["nationalPrefixFormattingRule"] =
                    numberFormat.getAttribute("nationalprefixformattingrule");
              }
              if (numberFormat
                      .getAttribute("nationalPrefixOptionalWhenFormatting") !=
                  null) {
                numberFormatDict["nationalPrefixOptionalWhenFormatting"] =
                    numberFormat
                        .getAttribute("nationalPrefixOptionalWhenFormatting");
              } else if (numberFormat
                      .getAttribute("nationalprefixoptionalwhenformatting") !=
                  null) {
                numberFormatDict["nationalPrefixOptionalWhenFormatting"] =
                    numberFormat
                        .getAttribute("nationalprefixoptionalwhenformatting");
              }
              if (numberFormat.getAttribute("carrierCodeFormattingRule") !=
                  null) {
                numberFormatDict["carrierCodeFormattingRule"] =
                    numberFormat.getAttribute("carrierCodeFormattingRule");
              } else if (numberFormat
                      .getAttribute("carriercodeformattingrule") !=
                  null) {
                numberFormatDict["carrierCodeFormattingRule"] =
                    numberFormat.getAttribute("carriercodeformattingrule");
              }
              Iterable<XmlElement> leadingDigits =
                  numberFormat.findAllElements("leadingDigits");
              if (leadingDigits.isEmpty) {
                leadingDigits = numberFormat.findAllElements("leadingdigits");
              }
              if (leadingDigits.length == 1) {
                numberFormatDict["leadingDigits"] =
                    leadingDigits.elementAt(0).innerText.replaceCarriages();
              } else if (leadingDigits.length > 1) {
                List<String> leadingDigitList = [];
                for (final leadingDigit in leadingDigits) {
                  leadingDigitList
                      .add(leadingDigit.innerText.replaceCarriages());
                }
                numberFormatDict["leadingDigits"] = leadingDigitList;
              }
              Iterable<XmlElement> format =
                  numberFormat.findAllElements("format");
              if (format.length == 1) {
                numberFormatDict["format"] = format.elementAt(0).innerText;
              } else if (format.length > 1) {
                List<String> formatList = [];
                for (final f in format) {
                  formatList.add(f.innerText);
                }
                numberFormatDict["format"] = formatList;
              }
              Iterable<XmlElement> intlFormat =
                  numberFormat.findAllElements("intlFormat");
              if (intlFormat.isEmpty) {
                intlFormat = numberFormat.findAllElements("intlformat");
              }
              if (intlFormat.length == 1) {
                numberFormatDict["intlFormat"] =
                    intlFormat.elementAt(0).innerText;
              } else if (intlFormat.length > 1) {
                List<String> intlFormatList = [];
                for (final i in intlFormat) {
                  intlFormatList.add(i.innerText);
                }
                numberFormatDict["format"] = intlFormatList;
              }
              numberFormatList.add(numberFormatDict);
            }
            if (numberFormats.length > 1) {
              availableFormatDict["numberFormat"] = numberFormatList;
            } else if (numberFormats.length == 1) {
              availableFormatDict["numberFormat"] = numberFormatList[0];
            }
            territoryDict["availableFormats"] = availableFormatDict;
          }
        }
      }
      Iterable<XmlElement> generalDesc =
          territory.findAllElements("generaldesc");
      if (generalDesc.isEmpty) {
        generalDesc = territory.findAllElements("generalDesc");
      }
      if (generalDesc.isNotEmpty) {
        Map<String, dynamic> generalDescDict = {};
        if (generalDesc.length == 1) {
          Iterable<XmlElement> nationalNumberPattern =
              generalDesc.elementAt(0).findAllElements("nationalNumberPattern");
          if (nationalNumberPattern.isEmpty) {
            nationalNumberPattern = generalDesc
                .elementAt(0)
                .findAllElements("nationalnumberpattern");
          }
          if (nationalNumberPattern.isNotEmpty) {
            generalDescDict["nationalNumberPattern"] =
                nationalNumberPattern.elementAt(0).innerText.replaceCarriages();
          }
        }
        territoryDict["generalDesc"] = generalDescDict;
        final keyList = [
          "noInternationalDialling",
          "fixedLine",
          "mobile",
          "tollFree",
          "premiumRate",
          "voip",
          "uan",
          "pager",
          "sharedCost",
          "personalNumber",
          "voiceMail"
        ];
        for (final key in keyList) {
          Iterable<XmlElement> noInternationalDiallingIterable =
              territory.findElements(key);
          if (noInternationalDiallingIterable.isEmpty) {
            noInternationalDiallingIterable =
                territory.findAllElements(key.toLowerCase());
          }

          if (noInternationalDiallingIterable.isNotEmpty) {
            Map<String, dynamic> noInternationalDiallingDict = {};
            XmlElement noInternationalDialling =
                noInternationalDiallingIterable.elementAt(0);
            Iterable<XmlElement> possibleLengths =
                noInternationalDialling.findAllElements("possibleLengths");
            if (possibleLengths.isEmpty) {
              possibleLengths =
                  noInternationalDialling.findAllElements("possiblelengths");
            }
            if (possibleLengths.isNotEmpty) {
              Map<String, dynamic> possibleLengthDict = {};
              final possibleLength = possibleLengths.elementAt(0);
              if (possibleLength.getAttribute("national") != null) {
                possibleLengthDict["national"] =
                    possibleLength.getAttribute("national");
              }
              if (possibleLength.getAttribute("localOnly") != null) {
                possibleLengthDict["localOnly"] =
                    possibleLength.getAttribute("localOnly");
              } else if (possibleLength.getAttribute("localonly") != null) {
                possibleLengthDict["localOnly"] =
                    possibleLength.getAttribute("localonly");
              }
              noInternationalDiallingDict["possibleLengths"] =
                  possibleLengthDict;
            }
            Iterable<XmlElement> nationalNumberPatternIterable =
                noInternationalDialling
                    .findAllElements("nationalNumberPattern");
            if (nationalNumberPatternIterable.isEmpty) {
              nationalNumberPatternIterable = noInternationalDialling
                  .findAllElements("nationalnumberpattern");
            }
            if (nationalNumberPatternIterable.isNotEmpty) {
              final nationalNumberPattern =
                  nationalNumberPatternIterable.elementAt(0);
              noInternationalDiallingDict["nationalNumberPattern"] =
                  nationalNumberPattern.innerText.replaceCarriages();
            }
            Iterable<XmlElement> exampleNumberIterable =
                noInternationalDialling.findAllElements("exampleNumber");
            if (exampleNumberIterable.isEmpty) {
              exampleNumberIterable =
                  noInternationalDialling.findAllElements("examplenumber");
            }
            if (exampleNumberIterable.isNotEmpty) {
              final exampleNumber = exampleNumberIterable.elementAt(0);
              noInternationalDiallingDict["exampleNumber"] =
                  exampleNumber.innerText.replaceCarriages();
            }
            territoryDict[key] = noInternationalDiallingDict;
          }
        }
      }
      dataList.add(territoryDict);
    } catch (e) {
      print(e);
    }
  }
  Map<String, dynamic> territory = {"territory": dataList};
  Map<String, dynamic> territories = {"territories": territory};
  Map<String, dynamic> res = {"phoneNumberMetadata": territories};
  await File("resources/data_sources/original_phone_number_metadata.json")
      .writeAsString(jsonEncode(res));
}
