import "../../models/iso_code.dart";
import "../models/phone_metadata_patterns.dart";

const metadataPatternsByIsoCode = {
  IsoCode.AC: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[01589]\d|[46])\d{4}",
    mobile: r"4\d{4}",
    fixedLine: r"6[2-467]\d{3}",
  ),
  IsoCode.AD: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1|6\d)\d{7}|[135-9]\d{5}",
    mobile: r"690\d{6}|[356]\d{5}",
    fixedLine: r"[78]\d{5}",
  ),
  IsoCode.AE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[4-7]\d|9[0-689])\d{7}|800\d{2,9}|[2-4679]\d{7}",
    mobile: r"5[024-68]\d{7}",
    fixedLine: r"[2-4679][2-8]\d{6}",
  ),
  IsoCode.AF: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-7]\d{8}",
    mobile: r"7\d{8}",
    fixedLine: r"(?:[25][0-8]|[34][0-4]|6[0-5])[2-9]\d{6}",
  ),
  IsoCode.AG: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([457]\d{6})$|1",
    nationalPrefixTransformRule: r"268$1",
    general: r"(?:268|[58]\d\d|900)\d{7}",
    mobile: r"268(?:464|7(?:1[3-9]|[28]\d|3[0246]|64|7[0-689]))\d{4}",
    fixedLine: r"268(?:4(?:6[0-38]|84)|56[0-2])\d{4}",
  ),
  IsoCode.AI: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2457]\d{6})$|1",
    nationalPrefixTransformRule: r"264$1",
    general: r"(?:264|[58]\d\d|900)\d{7}",
    mobile: r"264(?:235|4(?:69|76)|5(?:3[6-9]|8[1-4])|7(?:29|72))\d{4}",
    fixedLine: r"264(?:292|4(?:6[12]|9[78]))\d{4}",
  ),
  IsoCode.AL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:700\d\d|900)\d{3}|8\d{5,7}|(?:[2-5]|6\d)\d{7}",
    mobile: r"6(?:[78][2-9]|9\d)\d{6}",
    fixedLine:
        r"4505[0-2]\d{3}|(?:[2358][16-9]\d[2-9]|4410)\d{4}|(?:[2358][2-5][2-9]|4(?:[2-57-9][2-9]|6\d))\d{5}",
  ),
  IsoCode.AM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[1-489]\d|55|60|77)\d{6}",
    mobile: r"(?:33|4[1349]|55|77|88|9[13-9])\d{6}",
    fixedLine:
        r"(?:(?:1[0-25]|47)\d|2(?:2[2-46]|3[1-8]|4[2-69]|5[2-7]|6[1-9]|8[1-7])|3[12]2)\d{5}",
  ),
  IsoCode.AO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[29]\d{8}",
    mobile: r"9[1-59]\d{7}",
    fixedLine: r"2\d(?:[0134][25-9]|[25-9]\d)\d{5}",
  ),
  IsoCode.AR: PhoneMetadataPatterns(
    nationalPrefixForParsing:
        r"0?(?:(11|2(?:2(?:02?|[13]|2[13-79]|4[1-6]|5[2457]|6[124-8]|7[1-4]|8[13-6]|9[1267])|3(?:02?|1[467]|2[03-6]|3[13-8]|[49][2-6]|5[2-8]|[67])|4(?:7[3-578]|9)|6(?:[0136]|2[24-6]|4[6-8]?|5[15-8])|80|9(?:0[1-3]|[19]|2\d|3[1-6]|4[02568]?|5[2-4]|6[2-46]|72?|8[23]?))|3(?:3(?:2[79]|6|8[2578])|4(?:0[0-24-9]|[12]|3[5-8]?|4[24-7]|5[4-68]?|6[02-9]|7[126]|8[2379]?|9[1-36-8])|5(?:1|2[1245]|3[237]?|4[1-46-9]|6[2-4]|7[1-6]|8[2-5]?)|6[24]|7(?:[069]|1[1568]|2[15]|3[145]|4[13]|5[14-8]|7[2-57]|8[126])|8(?:[01]|2[15-7]|3[2578]?|4[13-6]|5[4-8]?|6[1-357-9]|7[36-8]?|8[5-8]?|9[124])))15)?",
    nationalPrefixTransformRule: r"9$1",
    general: r"(?:11|[89]\d\d)\d{8}|[2368]\d{9}",
    mobile:
        r"93(?:7(?:1[15]|81)[46]|8(?:(?:21|4[16]|69|9[12])[46]|88[013-9]))\d{5}|9(?:29(?:54|66)|3(?:7(?:55|77)|865))[2-8]\d{5}|9(?:2(?:2(?:2[59]|44|52)|3(?:26|44)|473|9(?:[07]2|2[26]|34|46))|3327)[45]\d{5}|9(?:2(?:284|3(?:02|23)|657|920)|3(?:4(?:8[27]|92)|541|878))[2-7]\d{5}|9(?:2(?:(?:26|62)2|320|477|9(?:42|83))|3(?:329|4(?:[47]6|62|89)|564))[2-6]\d{5}|(?:675\d|9(?:11[1-8]\d|2(?:2(?:0[45]|1[2-6]|3[3-6])|3(?:[06]4|7[45])|494|6(?:04|1[2-8]|[36][45]|4[3-6])|80[45]|9(?:[17][4-6]|[48][45]|9[3-6]))|3(?:364|4(?:1[2-7]|[235][4-6]|84)|5(?:1[2-9]|[38][4-6])|6(?:2[45]|44)|7[069][45]|8(?:0[45]|[17][2-6]|3[4-6]|[58][3-6]))))\d{6}|92(?:2(?:21|4[23]|6[145]|7[1-4]|8[356]|9[267])|3(?:16|3[13-8]|43|5[346-8]|9[3-5])|475|6(?:2[46]|4[78]|5[1568])|9(?:03|2[1457-9]|3[1356]|4[08]|[56][23]|82))4\d{5}|9(?:2(?:2(?:57|81)|3(?:24|46|92)|9(?:01|23|64))|3(?:4(?:42|71)|5(?:25|37|4[347]|71)|7(?:18|5[17])))[3-6]\d{5}|9(?:2(?:2(?:02|2[3467]|4[156]|5[45]|6[6-8]|91)|3(?:1[47]|25|[45][25]|96)|47[48]|625|932)|3(?:38[2578]|4(?:0[0-24-9]|3[78]|4[457]|58|6[03-9]|72|83|9[136-8])|5(?:2[124]|[368][23]|4[2689]|7[2-6])|7(?:16|2[15]|3[145]|4[13]|5[468]|7[2-5]|8[26])|8(?:2[5-7]|3[278]|4[3-5]|5[78]|6[1-378]|[78]7|94)))[4-6]\d{5}",
    fixedLine:
        r"3888[013-9]\d{5}|3(?:7(?:1[15]|81)|8(?:21|4[16]|69|9[12]))[46]\d{5}|(?:29(?:54|66)|3(?:7(?:55|77)|865))[2-8]\d{5}|(?:2(?:2(?:2[59]|44|52)|3(?:26|44)|473|9(?:[07]2|2[26]|34|46))|3327)[45]\d{5}|(?:2(?:284|3(?:02|23)|657|920)|3(?:4(?:8[27]|92)|541|878))[2-7]\d{5}|(?:2(?:(?:26|62)2|320|477|9(?:42|83))|3(?:329|4(?:[47]6|62|89)|564))[2-6]\d{5}|(?:(?:11[1-8]|670)\d|2(?:2(?:0[45]|1[2-6]|3[3-6])|3(?:[06]4|7[45])|494|6(?:04|1[2-8]|[36][45]|4[3-6])|80[45]|9(?:[17][4-6]|[48][45]|9[3-6]))|3(?:364|4(?:1[2-7]|[235][4-6]|84)|5(?:1[2-9]|[38][4-6])|6(?:2[45]|44)|7[069][45]|8(?:0[45]|[17][2-6]|3[4-6]|[58][3-6])))\d{6}|2(?:2(?:21|4[23]|6[145]|7[1-4]|8[356]|9[267])|3(?:16|3[13-8]|43|5[346-8]|9[3-5])|475|6(?:2[46]|4[78]|5[1568])|9(?:03|2[1457-9]|3[1356]|4[08]|[56][23]|82))4\d{5}|(?:2(?:2(?:57|81)|3(?:24|46|92)|9(?:01|23|64))|3(?:4(?:42|71)|5(?:25|37|4[347]|71)|7(?:18|5[17])))[3-6]\d{5}|(?:2(?:2(?:02|2[3467]|4[156]|5[45]|6[6-8]|91)|3(?:1[47]|25|[45][25]|96)|47[48]|625|932)|3(?:38[2578]|4(?:0[0-24-9]|3[78]|4[457]|58|6[03-9]|72|83|9[136-8])|5(?:2[124]|[368][23]|4[2689]|7[2-6])|7(?:16|2[15]|3[145]|4[13]|5[468]|7[2-5]|8[26])|8(?:2[5-7]|3[278]|4[3-5]|5[78]|6[1-378]|[78]7|94)))[4-6]\d{5}",
  ),
  IsoCode.AS: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([267]\d{6})$|1",
    nationalPrefixTransformRule: r"684$1",
    general: r"(?:[58]\d\d|684|900)\d{7}",
    mobile: r"684(?:2(?:48|5[2468]|7[26])|7(?:3[13]|70|82))\d{4}",
    fixedLine: r"6846(?:22|33|44|55|77|88|9[19])\d{4}",
  ),
  IsoCode.AT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"1\d{3,12}|2\d{6,12}|43(?:(?:0\d|5[02-9])\d{3,9}|2\d{4,5}|[3467]\d{4}|8\d{4,6}|9\d{4,7})|5\d{4,12}|8\d{7,12}|9\d{8,12}|(?:[367]\d|4[0-24-9])\d{4,11}",
    mobile: r"6(?:5[0-3579]|6[013-9]|[7-9]\d)\d{4,10}",
    fixedLine:
        r"1(?:11\d|[2-9]\d{3,11})|(?:316|463|(?:51|66|73)2)\d{3,10}|(?:2(?:1[467]|2[13-8]|5[2357]|6[1-46-8]|7[1-8]|8[124-7]|9[1458])|3(?:1[1-578]|3[23568]|4[5-7]|5[1378]|6[1-38]|8[3-68])|4(?:2[1-8]|35|7[1368]|8[2457])|5(?:2[1-8]|3[357]|4[147]|5[12578]|6[37])|6(?:13|2[1-47]|4[135-8]|5[468])|7(?:2[1-8]|35|4[13478]|5[68]|6[16-8]|7[1-6]|9[45]))\d{4,10}",
  ),
  IsoCode.AU: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"(183[12])|0",
    nationalPrefixTransformRule: null,
    general:
        r"1(?:[0-79]\d{7}(?:\d(?:\d{2})?)?|8[0-24-9]\d{7})|[2-478]\d{8}|1\d{4,7}",
    mobile:
        r"4(?:(?:79|94)[01]|83[0-389])\d{5}|4(?:[0-3]\d|4[047-9]|5[0-25-9]|6[016-9]|7[02-8]|8[0-24-9]|9[0-37-9])\d{6}",
    fixedLine:
        r"(?:(?:2(?:[0-26-9]\d|3[0-8]|4[02-9]|5[0135-9])|3(?:[0-3589]\d|4[0-578]|6[1-9]|7[0-35-9])|7(?:[013-57-9]\d|2[0-8]))\d{3}|8(?:51(?:0(?:0[03-9]|[12479]\d|3[2-9]|5[0-8]|6[1-9]|8[0-7])|1(?:[0235689]\d|1[0-69]|4[0-589]|7[0-47-9])|2(?:0[0-79]|[18][13579]|2[14-9]|3[0-46-9]|[4-6]\d|7[89]|9[0-4]))|(?:6[0-8]|[78]\d)\d{3}|9(?:[02-9]\d{3}|1(?:(?:[0-58]\d|6[0135-9])\d|7(?:0[0-24-9]|[1-9]\d)|9(?:[0-46-9]\d|5[0-79])))))\d{3}",
  ),
  IsoCode.AW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[25-79]\d\d|800)\d{4}",
    mobile:
        r"(?:290|5[69]\d|6(?:[03]0|22|4[0-2]|[69]\d)|7(?:[34]\d|7[07])|9(?:6[45]|9[4-8]))\d{4}",
    fixedLine: r"5(?:2\d|8[1-9])\d{4}",
  ),
  IsoCode.AX: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"2\d{4,9}|35\d{4,5}|(?:60\d\d|800)\d{4,6}|7\d{5,11}|(?:[14]\d|3[0-46-9]|50)\d{4,8}",
    mobile: r"4946\d{2,6}|(?:4[0-8]|50)\d{4,8}",
    fixedLine: r"18[1-8]\d{3,6}",
  ),
  IsoCode.AZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"365\d{6}|(?:[124579]\d|60|88)\d{7}",
    mobile: r"36554\d{4}|(?:[16]0|4[04]|5[015]|7[07]|99)\d{7}",
    fixedLine:
        r"(?:2[12]428|3655[02])\d{4}|(?:2(?:22[0-79]|63[0-28])|3654)\d{5}|(?:(?:1[28]|46)\d|2(?:[014-6]2|[23]3))\d{6}",
  ),
  IsoCode.BA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"6\d{8}|(?:[35689]\d|49|70)\d{6}",
    mobile: r"6040\d{5}|6(?:03|[1-356]|44|7\d)\d{6}",
    fixedLine:
        r"(?:3(?:[05-79][2-9]|1[4579]|[23][24-9]|4[2-4689]|8[2457-9])|49[2-579]|5(?:0[2-49]|[13][2-9]|[268][2-4679]|4[4689]|5[2-79]|7[2-69]|9[2-4689]))\d{5}",
  ),
  IsoCode.BB: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-9]\d{6})$|1",
    nationalPrefixTransformRule: r"246$1",
    general: r"(?:246|[58]\d\d|900)\d{7}",
    mobile:
        r"246(?:(?:2(?:[3568]\d|4[0-57-9])|3(?:5[2-9]|6[0-6])|4(?:46|5\d)|69[5-7]|8(?:[2-5]\d|83))\d|52(?:1[147]|20))\d{3}",
    fixedLine:
        r"246521[0369]\d{3}|246(?:2(?:2[78]|7[0-4])|4(?:1[024-6]|2\d|3[2-9])|5(?:20|[34]\d|54|7[1-3])|6(?:2\d|38)|7[35]7|9(?:1[89]|63))\d{4}",
  ),
  IsoCode.BD: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"[1-469]\d{9}|8[0-79]\d{7,8}|[2-79]\d{8}|[2-9]\d{7}|[3-9]\d{6}|[57-9]\d{5}",
    mobile: r"(?:1[13-9]\d|644)\d{7}|(?:3[78]|44|66)[02-9]\d{7}",
    fixedLine:
        r"(?:4(?:31\d\d|423)|5222)\d{3}(?:\d{2})?|8332[6-9]\d\d|(?:3(?:03[56]|224)|4(?:22[25]|653))\d{3,4}|(?:3(?:42[47]|529|823)|4(?:027|525|65(?:28|8))|562|6257|7(?:1(?:5[3-5]|6[12]|7[156]|89)|22[589]56|32|42675|52(?:[25689](?:56|8)|[347]8)|71(?:6[1267]|75|89)|92374)|82(?:2[59]|32)56|9(?:03[23]56|23(?:256|373)|31|5(?:1|2[4589]56)))\d{3}|(?:3(?:02[348]|22[35]|324|422)|4(?:22[67]|32[236-9]|6(?:2[46]|5[57])|953)|5526|6(?:024|6655)|81)\d{4,5}|(?:2(?:7(?:1[0-267]|2[0-289]|3[0-29]|4[01]|5[1-3]|6[013]|7[0178]|91)|8(?:0[125]|1[1-6]|2[0157-9]|3[1-69]|41|6[1-35]|7[1-5]|8[1-8]|9[0-6])|9(?:0[0-2]|1[0-4]|2[568]|3[3-6]|5[5-7]|6[0136-9]|7[0-7]|8[014-9]))|3(?:0(?:2[025-79]|3[2-4])|181|22[12]|32[2356]|824)|4(?:02[09]|22[348]|32[045]|523|6(?:27|54))|666(?:22|53)|7(?:22[57-9]|42[56]|82[35])8|8(?:0[124-9]|2(?:181|2[02-4679]8)|4[12]|[5-7]2)|9(?:[04]2|2(?:2|328)|81))\d{4}|(?:2(?:222|[45]\d)\d|3(?:1(?:2[5-7]|[5-7])|425|822)|4(?:033|1\d|[257]1|332|4(?:2[246]|5[25])|6(?:2[35]|56|62)|8(?:23|54)|92[2-5])|5(?:02[03489]|22[457]|32[35-79]|42[46]|6(?:[18]|53)|724|826)|6(?:023|2(?:2[2-5]|5[3-5]|8)|32[3478]|42[34]|52[47]|6(?:[18]|6(?:2[34]|5[24]))|[78]2[2-5]|92[2-6])|7(?:02|21\d|[3-589]1|6[12]|72[24])|8(?:217|3[12]|[5-7]1)|9[24]1)\d{5}|(?:(?:3[2-8]|5[2-57-9]|6[03-589])1|4[4689][18])\d{5}|[59]1\d{5}",
  ),
  IsoCode.BE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"4\d{8}|[1-9]\d{7}",
    mobile: r"4[5-9]\d{7}",
    fixedLine:
        r"80[2-8]\d{5}|(?:1[0-69]|[23][2-8]|4[23]|5\d|6[013-57-9]|71|8[1-79]|9[2-4])\d{6}",
  ),
  IsoCode.BF: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[025-7]\d{7}",
    mobile: r"(?:0[1-35-7]|5[0-8]|[67]\d)\d{6}",
    fixedLine:
        r"2(?:0(?:49|5[23]|6[5-7]|9[016-9])|4(?:4[569]|5[4-6]|6[5-7]|7[0179])|5(?:[34]\d|50|6[5-7]))\d{4}",
  ),
  IsoCode.BG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"00800\d{7}|[2-7]\d{6,7}|[89]\d{6,8}|2\d{5}",
    mobile: r"(?:43[07-9]|99[69]\d)\d{5}|(?:8[7-9]|98)\d{7}",
    fixedLine:
        r"2\d{5,7}|(?:43[1-6]|70[1-9])\d{4,5}|(?:[36]\d|4[124-7]|[57][1-9]|8[1-6]|9[1-7])\d{5,6}",
  ),
  IsoCode.BH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[136-9]\d{7}",
    mobile:
        r"(?:3(?:[1-79]\d|8[0-47-9])\d|6(?:3(?:00|33|6[16])|6(?:3[03-9]|[69]\d|7[0-6])))\d{4}",
    fixedLine:
        r"(?:1(?:3[1356]|6[0156]|7\d)\d|6(?:1[16]\d|500|6(?:0\d|3[12]|44|7[7-9]|88)|9[69][69])|7(?:1(?:11|78)|7\d\d))\d{4}",
  ),
  IsoCode.BI: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[267]\d|31)\d{6}",
    mobile: r"(?:29|[67][125-9])\d{6}",
    fixedLine: r"(?:22|31)\d{6}",
  ),
  IsoCode.BJ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[24-689]\d{7}",
    mobile: r"(?:4[0-356]|[56]\d|9[013-9])\d{6}",
    fixedLine: r"2(?:02|1[037]|2[45]|3[68]|4\d)\d{5}",
  ),
  IsoCode.BL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"590\d{6}|(?:69|80|9\d)\d{7}",
    mobile: r"69(?:0\d\d|1(?:2[2-9]|3[0-5]))\d{4}",
    fixedLine: r"590(?:2[7-9]|5[12]|87)\d{4}",
  ),
  IsoCode.BM: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-9]\d{6})$|1",
    nationalPrefixTransformRule: r"441$1",
    general: r"(?:441|[58]\d\d|900)\d{7}",
    mobile: r"441(?:[2378]\d|5[0-39]|92)\d{5}",
    fixedLine: r"441(?:[46]\d\d|5(?:4\d|60|89))\d{4}",
  ),
  IsoCode.BN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-578]\d{6}",
    mobile: r"(?:22[89]|[78]\d\d)\d{4}",
    fixedLine: r"22[0-7]\d{4}|(?:2[013-9]|[34]\d|5[0-25-9])\d{5}",
  ),
  IsoCode.BO: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"0(1\d)?",
    nationalPrefixTransformRule: null,
    general: r"(?:[2-467]\d\d|8001)\d{5}",
    mobile: r"[67]\d{7}",
    fixedLine:
        r"(?:2(?:2\d\d|5(?:11|[258]\d|9[67])|6(?:12|2\d|9[34])|8(?:2[34]|39|62))|3(?:3\d\d|4(?:6\d|8[24])|8(?:25|42|5[257]|86|9[25])|9(?:[27]\d|3[2-4]|4[248]|5[24]|6[2-6]))|4(?:4\d\d|6(?:11|[24689]\d|72)))\d{4}",
  ),
  IsoCode.BQ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[34]1|7\d)\d{5}",
    mobile:
        r"(?:31(?:8[14-8]|9[14578])|416[14-9]|7(?:0[01]|7[07]|8\d|9[056])\d)\d{3}",
    fixedLine: r"(?:318[023]|41(?:6[023]|70)|7(?:1[578]|2[05]|50)\d)\d{3}",
  ),
  IsoCode.BR: PhoneMetadataPatterns(
    nationalPrefixForParsing:
        r"(?:0|90)(?:(1[245]|2[1-35]|31|4[13]|[56]5|99)(\d{10,11}))?",
    nationalPrefixTransformRule: r"$2",
    general:
        r"(?:[1-46-9]\d\d|5(?:[0-46-9]\d|5[0-46-9]))\d{8}|[1-9]\d{9}|[3589]\d{8}|[34]\d{7}",
    mobile:
        r"(?:[14689][1-9]|2[12478]|3[1-578]|5[13-5]|7[13-579])(?:7|9\d)\d{7}",
    fixedLine:
        r"(?:[14689][1-9]|2[12478]|3[1-578]|5[13-5]|7[13-579])[2-5]\d{7}",
  ),
  IsoCode.BS: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([3-8]\d{6})$|1",
    nationalPrefixTransformRule: r"242$1",
    general: r"(?:242|[58]\d\d|900)\d{7}",
    mobile:
        r"242(?:3(?:5[79]|7[56]|95)|4(?:[23][1-9]|4[1-35-9]|5[1-8]|6[2-8]|7\d|81)|5(?:2[45]|3[35]|44|5[1-46-9]|65|77)|6[34]6|7(?:27|38)|8(?:0[1-9]|1[02-9]|2\d|[89]9))\d{4}",
    fixedLine:
        r"242(?:3(?:02|[236][1-9]|4[0-24-9]|5[0-68]|7[347]|8[0-4]|9[2-467])|461|502|6(?:0[1-5]|12|2[013]|[45]0|7[67]|8[78]|9[89])|7(?:02|88))\d{4}",
  ),
  IsoCode.BT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[17]\d{7}|[2-8]\d{6}",
    mobile: r"(?:1[67]|77)\d{6}",
    fixedLine: r"(?:2[3-6]|[34][5-7]|5[236]|6[2-46]|7[246]|8[2-4])\d{5}",
  ),
  IsoCode.BW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:0800|(?:[37]|800)\d)\d{6}|(?:[2-6]\d|90)\d{5}",
    mobile: r"(?:321|7(?:[1-7]\d|8[0-4]))\d{5}",
    fixedLine:
        r"(?:2(?:4[0-48]|6[0-24]|9[0578])|3(?:1[0-35-9]|55|[69]\d|7[013])|4(?:6[03]|7[1267]|9[0-5])|5(?:3[03489]|4[0489]|7[1-47]|88|9[0-49])|6(?:2[1-35]|5[149]|8[067]))\d{4}",
  ),
  IsoCode.BY: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"0|80?",
    nationalPrefixTransformRule: null,
    general:
        r"(?:[12]\d|33|44|902)\d{7}|8(?:0[0-79]\d{5,7}|[1-7]\d{9})|8(?:1[0-489]|[5-79]\d)\d{7}|8[1-79]\d{6,7}|8[0-79]\d{5}|8\d{5}",
    mobile: r"(?:2(?:5[5-79]|9[1-9])|(?:33|44)\d)\d{6}",
    fixedLine:
        r"(?:1(?:5(?:1[1-5]|[24]\d|6[2-4]|9[1-7])|6(?:[235]\d|4[1-7])|7\d\d)|2(?:1(?:[246]\d|3[0-35-9]|5[1-9])|2(?:[235]\d|4[0-8])|3(?:[26]\d|3[02-79]|4[024-7]|5[03-7])))\d{5}",
  ),
  IsoCode.BZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:0800\d|[2-8])\d{6}",
    mobile: r"6[0-35-7]\d{5}",
    fixedLine:
        r"(?:2(?:[02]\d|36|[68]0)|[3-58](?:[02]\d|[68]0)|7(?:[02]\d|32|[68]0))\d{4}",
  ),
  IsoCode.CA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-8]\d|90)\d{8}|3\d{6}",
    mobile:
        r"(?:2(?:04|[23]6|[48]9|50|63)|3(?:06|43|54|6[578]|82)|4(?:03|1[68]|[26]8|3[178]|50|74)|5(?:06|1[49]|48|79|8[147])|6(?:04|[18]3|39|47|72)|7(?:0[59]|42|53|78|8[02])|8(?:[06]7|19|25|73)|90[25])[2-9]\d{6}",
    fixedLine:
        r"(?:2(?:04|[23]6|[48]9|50|63)|3(?:06|43|54|6[578]|82)|4(?:03|1[68]|[26]8|3[178]|50|74)|5(?:06|1[49]|48|79|8[147])|6(?:04|[18]3|39|47|72)|7(?:0[59]|42|53|78|8[02])|8(?:[06]7|19|25|73)|90[25])[2-9]\d{6}",
  ),
  IsoCode.CC: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([59]\d{7})$|0",
    nationalPrefixTransformRule: r"8$1",
    general: r"1(?:[0-79]\d{8}(?:\d{2})?|8[0-24-9]\d{7})|[148]\d{8}|1\d{5,7}",
    mobile:
        r"4(?:(?:79|94)[01]|83[0-389])\d{5}|4(?:[0-3]\d|4[047-9]|5[0-25-9]|6[016-9]|7[02-8]|8[0-24-9]|9[0-37-9])\d{6}",
    fixedLine:
        r"8(?:51(?:0(?:02|31|60|89)|1(?:18|76)|223)|91(?:0(?:1[0-2]|29)|1(?:[28]2|50|79)|2(?:10|64)|3(?:[06]8|22)|4[29]8|62\d|70[23]|959))\d{3}",
  ),
  IsoCode.CD: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[189]\d{8}|[1-68]\d{6}",
    mobile: r"88\d{5}|(?:8[0-59]|9[017-9])\d{7}",
    fixedLine: r"12\d{7}|[1-6]\d{6}",
  ),
  IsoCode.CF: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[27]\d{3}|8776)\d{4}",
    mobile: r"7[024-7]\d{6}",
    fixedLine: r"2[12]\d{6}",
  ),
  IsoCode.CG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"222\d{6}|(?:0\d|80)\d{7}",
    mobile:
        r"026(?:1[0-5]|6[6-9])\d{4}|0(?:[14-6]\d\d|2(?:40|5[5-8]|6[07-9]))\d{5}",
    fixedLine: r"222[1-589]\d{5}",
  ),
  IsoCode.CH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"8\d{11}|[2-9]\d{8}",
    mobile: r"7[35-9]\d{7}",
    fixedLine: r"(?:2[12467]|3[1-4]|4[134]|5[256]|6[12]|[7-9]1)\d{7}",
  ),
  IsoCode.CI: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[02]\d{9}",
    mobile: r"0[157]\d{8}",
    fixedLine:
        r"2(?:[15]\d{3}|7(?:2(?:0[23]|1[2357]|2[245]|3[45]|4[3-5])|3(?:06|1[69]|[2-6]7)))\d{5}",
  ),
  IsoCode.CK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-578]\d{4}",
    mobile: r"[578]\d{4}",
    fixedLine: r"(?:2\d|3[13-7]|4[1-5])\d{3}",
  ),
  IsoCode.CL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"12300\d{6}|6\d{9,10}|[2-9]\d{8}",
    mobile:
        r"2(?:1982[0-6]|3314[05-9])\d{3}|(?:2(?:1(?:160|962)|3(?:2\d\d|3(?:[03467]\d|1[0-35-9]|2[1-9]|5[0-24-9]|8[0-3])|600)|646[59])|80[1-9]\d\d|9(?:3(?:[0-57-9]\d\d|6(?:0[02-9]|[1-9]\d))|6(?:[0-8]\d\d|9(?:[02-79]\d|1[05-9]))|7[1-9]\d\d|9(?:[03-9]\d\d|1(?:[0235-9]\d|4[0-24-9])|2(?:[0-79]\d|8[0-46-9]))))\d{4}|(?:22|3[2-5]|[47][1-35]|5[1-3578]|6[13-57]|8[1-9]|9[2458])\d{7}",
    fixedLine:
        r"2(?:1982[0-6]|3314[05-9])\d{3}|(?:2(?:1(?:160|962)|3(?:2\d\d|3(?:[03467]\d|1[0-35-9]|2[1-9]|5[0-24-9]|8[0-3])|600)|646[59])|80[1-9]\d\d|9(?:3(?:[0-57-9]\d\d|6(?:0[02-9]|[1-9]\d))|6(?:[0-8]\d\d|9(?:[02-79]\d|1[05-9]))|7[1-9]\d\d|9(?:[03-9]\d\d|1(?:[0235-9]\d|4[0-24-9])|2(?:[0-79]\d|8[0-46-9]))))\d{4}|(?:22|3[2-5]|[47][1-35]|5[1-3578]|6[13-57]|8[1-9]|9[2458])\d{7}",
  ),
  IsoCode.CM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[26]\d{8}|88\d{6,7}",
    mobile: r"(?:24[23]|6[25-9]\d)\d{6}",
    fixedLine: r"2(?:22|33)\d{6}",
  ),
  IsoCode.CN: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"(1(?:[12]\d|79)\d\d)|0",
    nationalPrefixTransformRule: null,
    general:
        r"1[127]\d{8,9}|2\d{9}(?:\d{2})?|[12]\d{6,7}|86\d{6}|(?:1[03-689]\d|6)\d{7,9}|(?:[3-579]\d|8[0-57-9])\d{6,9}",
    mobile:
        r"1740[0-5]\d{6}|1(?:[38]\d|4[57]|[59][0-35-9]|6[25-7]|7[0-35-8])\d{8}",
    fixedLine:
        r"(?:10(?:[02-79]\d\d|[18](?:0[1-9]|[1-9]\d))|21(?:[18](?:0[1-9]|[1-9]\d)|[2-79]\d\d))\d{5}|(?:43[35]|754)\d{7,8}|8(?:078\d{7}|51\d{7,8})|(?:10|(?:2|85)1|43[35]|754)(?:100\d\d|95\d{3,4})|(?:2[02-57-9]|3(?:11|7[179])|4(?:[15]1|3[12])|5(?:1\d|2[37]|3[12]|51|7[13-79]|9[15])|7(?:[39]1|5[57]|6[09])|8(?:71|98))(?:[02-8]\d{7}|1(?:0(?:0\d\d(?:\d{3})?|[1-9]\d{5})|[1-9]\d{6})|9(?:[0-46-9]\d{6}|5\d{3}(?:\d(?:\d{2})?)?))|(?:3(?:1[02-9]|35|49|5\d|7[02-68]|9[1-68])|4(?:1[02-9]|2[179]|3[46-9]|5[2-9]|6[47-9]|7\d|8[23])|5(?:3[03-9]|4[36]|5[02-9]|6[1-46]|7[028]|80|9[2-46-9])|6(?:3[1-5]|6[0238]|9[12])|7(?:01|[17]\d|2[248]|3[04-9]|4[3-6]|5[0-3689]|6[2368]|9[02-9])|8(?:1[236-8]|2[5-7]|3\d|5[2-9]|7[02-9]|8[36-8]|9[1-7])|9(?:0[1-3689]|1[1-79]|[379]\d|4[13]|5[1-5]))(?:[02-8]\d{6}|1(?:0(?:0\d\d(?:\d{2})?|[1-9]\d{4})|[1-9]\d{5})|9(?:[0-46-9]\d{5}|5\d{3,5}))",
  ),
  IsoCode.CO: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"0(4(?:[14]4|56)|[579])?",
    nationalPrefixTransformRule: null,
    general: r"(?:60\d\d|9101)\d{6}|(?:1\d|3)\d{9}",
    mobile:
        r"3333(?:0(?:0\d|1[0-5])|[4-9]\d\d)\d{3}|(?:3(?:24[1-9]|3(?:00|3[0-24-9]))|9101)\d{6}|3(?:0[0-5]|1\d|2[0-3]|5[01]|70)\d{7}",
    fixedLine:
        r"601055(?:[0-4]\d|50)\d\d|6010(?:[0-4]\d|5[0-4])\d{4}|60[124-8][2-9]\d{6}",
  ),
  IsoCode.CR: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"(19(?:0[0-2468]|1[09]|20|66|77|99))",
    nationalPrefixTransformRule: null,
    general: r"(?:8\d|90)\d{8}|(?:[24-8]\d{3}|3005)\d{4}",
    mobile: r"(?:3005\d|6500[01])\d{3}|(?:5[07]|6[0-4]|7[0-3]|8[3-9])\d{6}",
    fixedLine: r"210[7-9]\d{4}|2(?:[024-7]\d|1[1-9])\d{5}",
  ),
  IsoCode.CU: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[27]\d{6,7}|[34]\d{5,7}|(?:5|8\d\d)\d{7}",
    mobile: r"5\d{7}",
    fixedLine:
        r"(?:3[23]|48)\d{4,6}|(?:31|4[36]|8(?:0[25]|78)\d)\d{6}|(?:2[1-4]|4[1257]|7\d)\d{5,6}",
  ),
  IsoCode.CV: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-59]\d\d|800)\d{4}",
    mobile: r"(?:36|5[1-389]|9\d)\d{5}",
    fixedLine: r"2(?:2[1-7]|3[0-8]|4[12]|5[1256]|6\d|7[1-3]|8[1-5])\d{4}",
  ),
  IsoCode.CW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[34]1|60|(?:7|9\d)\d)\d{5}",
    mobile: r"953[01]\d{4}|9(?:5[12467]|6[5-9])\d{5}",
    fixedLine:
        r"9(?:4(?:3[0-5]|4[14]|6\d)|50\d|7(?:2[014]|3[02-9]|4[4-9]|6[357]|77|8[7-9])|8(?:3[39]|[46]\d|7[01]|8[57-9]))\d{4}",
  ),
  IsoCode.CX: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([59]\d{7})$|0",
    nationalPrefixTransformRule: r"8$1",
    general: r"1(?:[0-79]\d{8}(?:\d{2})?|8[0-24-9]\d{7})|[148]\d{8}|1\d{5,7}",
    mobile:
        r"4(?:(?:79|94)[01]|83[0-389])\d{5}|4(?:[0-3]\d|4[047-9]|5[0-25-9]|6[016-9]|7[02-8]|8[0-24-9]|9[0-37-9])\d{6}",
    fixedLine:
        r"8(?:51(?:0(?:01|30|59|88)|1(?:17|46|75)|2(?:22|35))|91(?:00[6-9]|1(?:[28]1|49|78)|2(?:09|63)|3(?:12|26|75)|4(?:56|97)|64\d|7(?:0[01]|1[0-2])|958))\d{3}",
  ),
  IsoCode.CY: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[279]\d|[58]0)\d{6}",
    mobile: r"9(?:10|[4-79]\d)\d{5}",
    fixedLine: r"2[2-6]\d{6}",
  ),
  IsoCode.CZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-578]\d|60)\d{7}|9\d{8,11}",
    mobile: r"(?:60[1-8]|7(?:0[2-5]|[2379]\d))\d{6}",
    fixedLine: r"(?:2\d|3[1257-9]|4[16-9]|5[13-9])\d{7}",
  ),
  IsoCode.DE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"[2579]\d{5,14}|49(?:[34]0|69|8\d)\d\d?|49(?:37|49|60|7[089]|9\d)\d{1,3}|49(?:2[024-9]|3[2-689]|7[1-7])\d{1,8}|(?:1|[368]\d|4[0-8])\d{3,13}|49(?:[015]\d|2[13]|31|[46][1-8])\d{1,9}",
    mobile: r"15[0-25-9]\d{8}|1(?:6[023]|7\d)\d{7,8}",
    fixedLine:
        r"32\d{9,11}|49[1-6]\d{10}|322\d{6}|49[0-7]\d{3,9}|(?:[34]0|[68]9)\d{3,13}|(?:2(?:0[1-689]|[1-3569]\d|4[0-8]|7[1-7]|8[0-7])|3(?:[3569]\d|4[0-79]|7[1-7]|8[1-8])|4(?:1[02-9]|[2-48]\d|5[0-6]|6[0-8]|7[0-79])|5(?:0[2-8]|[124-6]\d|[38][0-8]|[79][0-7])|6(?:0[02-9]|[1-358]\d|[47][0-8]|6[1-9])|7(?:0[2-8]|1[1-9]|[27][0-7]|3\d|[4-6][0-8]|8[0-5]|9[013-7])|8(?:0[2-9]|1[0-79]|2\d|3[0-46-9]|4[0-6]|5[013-9]|6[1-8]|7[0-8]|8[0-24-6])|9(?:0[6-9]|[1-4]\d|[589][0-7]|6[0-8]|7[0-467]))\d{3,12}",
  ),
  IsoCode.DJ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:2\d|77)\d{6}",
    mobile: r"77\d{6}",
    fixedLine: r"2(?:1[2-5]|7[45])\d{5}",
  ),
  IsoCode.DK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-9]\d{7}",
    mobile: r"(?:[2-7]\d|8[126-9]|9[1-46-9])\d{6}",
    fixedLine: r"(?:[2-7]\d|8[126-9]|9[1-46-9])\d{6}",
  ),
  IsoCode.DM: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-7]\d{6})$|1",
    nationalPrefixTransformRule: r"767$1",
    general: r"(?:[58]\d\d|767|900)\d{7}",
    mobile: r"767(?:2(?:[2-4689]5|7[5-7])|31[5-7]|61[1-8]|70[1-6])\d{4}",
    fixedLine: r"767(?:2(?:55|66)|4(?:2[01]|4[0-25-9])|50[0-4])\d{4}",
  ),
  IsoCode.DO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[58]\d\d|900)\d{7}",
    mobile: r"8[024]9[2-9]\d{6}",
    fixedLine:
        r"8(?:[04]9[2-9]\d\d|29(?:2(?:[0-59]\d|6[04-9]|7[0-27]|8[0237-9])|3(?:[0-35-9]\d|4[7-9])|[45]\d\d|6(?:[0-27-9]\d|[3-5][1-9]|6[0135-8])|7(?:0[013-9]|[1-37]\d|4[1-35689]|5[1-4689]|6[1-57-9]|8[1-79]|9[1-8])|8(?:0[146-9]|1[0-48]|[248]\d|3[1-79]|5[01589]|6[013-68]|7[124-8]|9[0-8])|9(?:[0-24]\d|3[02-46-9]|5[0-79]|60|7[0169]|8[57-9]|9[02-9])))\d{4}",
  ),
  IsoCode.DZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[1-4]|[5-79]\d|80)\d{7}",
    mobile: r"(?:5(?:4[0-29]|5\d|6[0-2])|6(?:[569]\d|7[0-6])|7[7-9]\d)\d{6}",
    fixedLine: r"9619\d{5}|(?:1\d|2[013-79]|3[0-8]|4[013-689])\d{6}",
  ),
  IsoCode.EC: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"1\d{9,10}|(?:[2-7]|9\d)\d{7}",
    mobile: r"964[0-2]\d{5}|9(?:39|[57][89]|6[0-36-9]|[89]\d)\d{6}",
    fixedLine: r"[2-7][2-7]\d{6}",
  ),
  IsoCode.EE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"8\d{9}|[4578]\d{7}|(?:[3-8]\d|90)\d{5}",
    mobile:
        r"(?:5\d{5}|8(?:1(?:0(?:000|[3-9]\d\d)|(?:1(?:0[236]|1\d)|(?:2[0-59]|[3-79]\d)\d)\d)|2(?:0(?:000|(?:19|[2-7]\d)\d)|(?:(?:[124-6]\d|3[5-9])\d|7(?:[0-3679]\d|8[13-9])|8(?:[2-6]\d|7[01]))\d)|[349]\d{4}))\d\d|5(?:(?:[02]\d|5[0-478])\d|1(?:[0-8]\d|95)|6(?:4[0-4]|5[1-589]))\d{3}",
    fixedLine: r"(?:3[23589]|4[3-8]|6\d|7[1-9]|88)\d{5}",
  ),
  IsoCode.EG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[189]\d{8,9}|[24-6]\d{8}|[135]\d{7}",
    mobile: r"1[0-25]\d{8}",
    fixedLine:
        r"13[23]\d{6}|(?:15|57)\d{6,7}|(?:2[2-4]|3|4[05-8]|5[05]|6[24-689]|8[2468]|9[235-7])\d{7}",
  ),
  IsoCode.EH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[5-8]\d{8}",
    mobile:
        r"(?:6(?:[0-79]\d|8[0-247-9])|7(?:[017]\d|2[0-2]|6[0-8]|8[0-3]))\d{6}",
    fixedLine: r"528[89]\d{5}",
  ),
  IsoCode.ER: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[178]\d{6}",
    mobile: r"(?:17[1-3]|7\d\d)\d{4}",
    fixedLine: r"(?:1(?:1[12568]|[24]0|55|6[146])|8\d\d)\d{4}",
  ),
  IsoCode.ES: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[5-9]\d{8}",
    mobile:
        r"(?:590[16]00\d|9(?:6906(?:09|10)|7390\d\d))\d\d|(?:6\d|7[1-48])\d{7}",
    fixedLine:
        r"96906(?:0[0-8]|1[1-9]|[2-9]\d)\d\d|9(?:69(?:0[0-57-9]|[1-9]\d)|73(?:[0-8]\d|9[1-9]))\d{4}|(?:8(?:[1356]\d|[28][0-8]|[47][1-9])|9(?:[135]\d|[268][0-8]|4[1-9]|7[124-9]))\d{6}",
  ),
  IsoCode.ET: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:11|[2-579]\d)\d{7}",
    mobile: r"700[1-9]\d{5}|(?:7(?:0[1-9]|1[0-8]|22|77|86|99)|9\d\d)\d{6}",
    fixedLine:
        r"11667[01]\d{3}|(?:11(?:1(?:1[124]|2[2-7]|3[1-5]|5[5-8]|8[6-8])|2(?:13|3[6-8]|5[89]|7[05-9]|8[2-6])|3(?:2[01]|3[0-289]|4[1289]|7[1-4]|87)|4(?:1[69]|3[2-49]|4[0-3]|6[5-8])|5(?:1[578]|44|5[0-4])|6(?:1[578]|2[69]|39|4[5-7]|5[0-5]|6[0-59]|8[015-8]))|2(?:2(?:11[1-9]|22[0-7]|33\d|44[1467]|66[1-68])|5(?:11[124-6]|33[2-8]|44[1467]|55[14]|66[1-3679]|77[124-79]|880))|3(?:3(?:11[0-46-8]|(?:22|55)[0-6]|33[0134689]|44[04]|66[01467])|4(?:44[0-8]|55[0-69]|66[0-3]|77[1-5]))|4(?:6(?:119|22[0-24-7]|33[1-5]|44[13-69]|55[14-689]|660|88[1-4])|7(?:(?:11|22)[1-9]|33[13-7]|44[13-6]|55[1-689]))|5(?:7(?:227|55[05]|(?:66|77)[14-8])|8(?:11[149]|22[013-79]|33[0-68]|44[013-8]|550|66[1-5]|77\d)))\d{4}",
  ),
  IsoCode.FI: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"[1-35689]\d{4}|7\d{10,11}|(?:[124-7]\d|3[0-46-9])\d{8}|[1-9]\d{5,8}",
    mobile: r"4946\d{2,6}|(?:4[0-8]|50)\d{4,8}",
    fixedLine: r"(?:1[3-79][1-8]|[235689][1-8]\d)\d{2,6}",
  ),
  IsoCode.FJ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"45\d{5}|(?:0800\d|[235-9])\d{6}",
    mobile: r"(?:[279]\d|45|5[01568]|8[034679])\d{5}",
    fixedLine: r"603\d{4}|(?:3[0-5]|6[25-7]|8[58])\d{5}",
  ),
  IsoCode.FK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-7]\d{4}",
    mobile: r"[56]\d{4}",
    fixedLine: r"[2-47]\d{4}",
  ),
  IsoCode.FM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[39]\d\d|820)\d{4}",
    mobile:
        r"31(?:00[67]|208|309)\d\d|(?:3(?:[2357]0[1-9]|602|804|905)|(?:820|9[2-7]\d)\d)\d{3}",
    fixedLine:
        r"31(?:00[67]|208|309)\d\d|(?:3(?:[2357]0[1-9]|602|804|905)|(?:820|9[2-6]\d)\d)\d{3}",
  ),
  IsoCode.FO: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"(10(?:01|[12]0|88))",
    nationalPrefixTransformRule: null,
    general: r"[2-9]\d{5}",
    mobile: r"(?:[27][1-9]|5\d|9[16])\d{4}",
    fixedLine: r"(?:20|[34]\d|8[19])\d{4}",
  ),
  IsoCode.FR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-9]\d{8}",
    mobile: r"(?:6(?:[0-24-8]\d|3[0-8]|9[589])|7[3-9]\d)\d{6}",
    fixedLine: r"(?:[1-35]\d|4[1-9])\d{7}",
  ),
  IsoCode.GA: PhoneMetadataPatterns(
    nationalPrefixForParsing:
        r"0(11\d{6}|60\d{6}|61\d{6}|6[256]\d{6}|7[467]\d{6})",
    nationalPrefixTransformRule: r"$1",
    general: r"(?:[067]\d|11)\d{6}|[2-7]\d{6}",
    mobile: r"(?:(?:0[2-7]|7[467])\d|6(?:0[0-4]|10|[256]\d))\d{5}|[2-7]\d{6}",
    fixedLine: r"[01]1\d{6}",
  ),
  IsoCode.GB: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-357-9]\d{9}|[18]\d{8}|8\d{6}",
    mobile:
        r"7(?:457[0-57-9]|700[01]|911[028])\d{5}|7(?:[1-3]\d\d|4(?:[0-46-9]\d|5[0-689])|5(?:0[0-8]|[13-9]\d|2[0-35-9])|7(?:0[1-9]|[1-7]\d|8[02-9]|9[0-689])|8(?:[014-9]\d|[23][0-8])|9(?:[024-9]\d|1[02-9]|3[0-689]))\d{6}",
    fixedLine:
        r"(?:1(?:1(?:3(?:[0-58]\d\d|73[0235])|4(?:[0-5]\d\d|69[7-9]|70[0-579])|(?:(?:5[0-26-9]|[78][0-49])\d|6(?:[0-4]\d|50))\d)|(?:2(?:(?:0[024-9]|2[3-9]|3[3-79]|4[1-689]|[58][02-9]|6[0-47-9]|7[013-9]|9\d)\d|1(?:[0-7]\d|8[0-2]))|(?:3(?:0\d|1[0-8]|[25][02-9]|3[02-579]|[468][0-46-9]|7[1-35-79]|9[2-578])|4(?:0[03-9]|[137]\d|[28][02-57-9]|4[02-69]|5[0-8]|[69][0-79])|5(?:0[1-35-9]|[16]\d|2[024-9]|3[015689]|4[02-9]|5[03-9]|7[0-35-9]|8[0-468]|9[0-57-9])|6(?:0[034689]|1\d|2[0-35689]|[38][013-9]|4[1-467]|5[0-69]|6[13-9]|7[0-8]|9[0-24578])|7(?:0[0246-9]|2\d|3[0236-8]|4[03-9]|5[0-46-9]|6[013-9]|7[0-35-9]|8[024-9]|9[02-9])|8(?:0[35-9]|2[1-57-9]|3[02-578]|4[0-578]|5[124-9]|6[2-69]|7\d|8[02-9]|9[02569])|9(?:0[02-589]|[18]\d|2[02-689]|3[1-57-9]|4[2-9]|5[0-579]|6[2-47-9]|7[0-24578]|9[2-57]))\d)\d)|2(?:0[013478]|3[0189]|4[017]|8[0-46-9]|9[0-2])\d{3})\d{4}|1(?:2(?:0(?:46[1-4]|87[2-9])|545[1-79]|76(?:2\d|3[1-8]|6[1-6])|9(?:7(?:2[0-4]|3[2-5])|8(?:2[2-8]|7[0-47-9]|8[3-5])))|3(?:6(?:38[2-5]|47[23])|8(?:47[04-9]|64[0157-9]))|4(?:044[1-7]|20(?:2[23]|8\d)|6(?:0(?:30|5[2-57]|6[1-8]|7[2-8])|140)|8(?:052|87[1-3]))|5(?:2(?:4(?:3[2-79]|6\d)|76\d)|6(?:26[06-9]|686))|6(?:06(?:4\d|7[4-79])|295[5-7]|35[34]\d|47(?:24|61)|59(?:5[08]|6[67]|74)|9(?:55[0-4]|77[23]))|7(?:26(?:6[13-9]|7[0-7])|(?:442|688)\d|50(?:2[0-3]|[3-68]2|76))|8(?:27[56]\d|37(?:5[2-5]|8[239])|843[2-58])|9(?:0(?:0(?:6[1-8]|85)|52\d)|3583|4(?:66[1-8]|9(?:2[01]|81))|63(?:23|3[1-4])|9561))\d{3}",
  ),
  IsoCode.GD: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-9]\d{6})$|1",
    nationalPrefixTransformRule: r"473$1",
    general: r"(?:473|[58]\d\d|900)\d{7}",
    mobile: r"473(?:4(?:0[2-79]|1[04-9]|2[0-5]|58)|5(?:2[01]|3[3-8])|901)\d{4}",
    fixedLine:
        r"473(?:2(?:3[0-2]|69)|3(?:2[89]|86)|4(?:[06]8|3[5-9]|4[0-49]|5[5-79]|73|90)|63[68]|7(?:58|84)|800|938)\d{4}",
  ),
  IsoCode.GE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[3-57]\d\d|800)\d{6}",
    mobile:
        r"5(?:(?:(?:0555|1(?:[17]77|555))[5-9]|757(?:7[7-9]|8[01]))\d|22252[0-4])\d\d|(?:5(?:00(?:0\d|44|5[05]|77|88|99)|1(?:1(?:00|[124]\d|3[01])|4\d\d)|(?:44|68)\d\d|5(?:[0157-9]\d\d|200)|7(?:[0147-9]\d\d|5(?:00|[57]5))|8(?:0(?:[01]\d|2[0-4])|58[89]|8(?:55|88))|9(?:090|[1-35-9]\d\d))|790\d\d)\d{4}|5(?:0(?:070|505)|1(?:0[01]0|1(?:07|33|51))|2(?:0[02]0|2[25]2)|3(?:0[03]0|3[35]3)|(?:40[04]|900)0|5222)[0-4]\d{3}",
    fixedLine:
        r"(?:3(?:[256]\d|4[124-9]|7[0-4])|4(?:1\d|2[2-7]|3[1-79]|4[2-8]|7[239]|9[1-7]))\d{6}",
  ),
  IsoCode.GF: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[56]94\d{6}|(?:80|9\d)\d{7}",
    mobile: r"694(?:[0-249]\d|3[0-8])\d{4}",
    fixedLine: r"594(?:[0239]\d|[16][0-3]|4[03-9]|5[6-9]|80)\d{4}",
  ),
  IsoCode.GG: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([25-9]\d{5})$|0",
    nationalPrefixTransformRule: r"1481$1",
    general: r"(?:1481|[357-9]\d{3})\d{6}|8\d{6}(?:\d{2})?",
    mobile: r"7(?:(?:781|839)\d|911[17])\d{5}",
    fixedLine: r"1481[25-9]\d{5}",
  ),
  IsoCode.GH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[235]\d{3}|800)\d{5}",
    mobile: r"(?:2(?:[0346-9]\d|5[67])|5(?:[03-7]\d|9[1-9]))\d{6}",
    fixedLine:
        r"3082[0-5]\d{4}|3(?:0(?:[237]\d|8[01])|[167](?:2[0-6]|7\d|80)|2(?:2[0-5]|7\d|80)|3(?:2[0-3]|7\d|80)|4(?:2[013-9]|3[01]|7\d|80)|5(?:2[0-7]|7\d|80)|8(?:2[0-2]|7\d|80)|9(?:[28]0|7\d))\d{5}",
  ),
  IsoCode.GI: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[25]\d|60)\d{6}",
    mobile: r"5251[0-4]\d{3}|(?:5(?:[146-8]\d\d|250)|60(?:1[01]|6\d))\d{4}",
    fixedLine: r"2190[0-2]\d{3}|2(?:0(?:[02]\d|3[01])|16[24-9]|2[2-5]\d)\d{4}",
  ),
  IsoCode.GL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:19|[2-689]\d|70)\d{4}",
    mobile: r"[245]\d{5}",
    fixedLine: r"(?:19|3[1-7]|6[14689]|70|8[14-79]|9\d)\d{4}",
  ),
  IsoCode.GM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-9]\d{6}",
    mobile: r"(?:[23679]\d|5[0-489])\d{5}",
    fixedLine:
        r"(?:4(?:[23]\d\d|4(?:1[024679]|[6-9]\d))|5(?:5(?:3\d|4[0-7])|6[67]\d|7(?:1[04]|2[035]|3[58]|48))|8\d{3})\d{3}",
  ),
  IsoCode.GN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"722\d{6}|(?:3|6\d)\d{7}",
    mobile: r"6[0-356]\d{7}",
    fixedLine:
        r"3(?:0(?:24|3[12]|4[1-35-7]|5[13]|6[189]|[78]1|9[1478])|1\d\d)\d{4}",
  ),
  IsoCode.GP: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"590\d{6}|(?:69|80|9\d)\d{7}",
    mobile: r"69(?:0\d\d|1(?:2[2-9]|3[0-5]))\d{4}",
    fixedLine:
        r"590(?:0[1-68]|[14][0-24-9]|2[0-68]|3[1289]|5[3-579]|[68][0-689]|7[08]|9\d)\d{4}",
  ),
  IsoCode.GQ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"222\d{6}|(?:3\d|55|[89]0)\d{7}",
    mobile: r"(?:222|55\d)\d{6}",
    fixedLine: r"33[0-24-9]\d[46]\d{4}|3(?:33|5\d)\d[7-9]\d{4}",
  ),
  IsoCode.GR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"5005000\d{3}|8\d{9,11}|(?:[269]\d|70)\d{8}",
    mobile: r"68[57-9]\d{7}|(?:69|94)\d{8}",
    fixedLine:
        r"2(?:1\d\d|2(?:2[1-46-9]|[36][1-8]|4[1-7]|5[1-4]|7[1-5]|[89][1-9])|3(?:1\d|2[1-57]|[35][1-3]|4[13]|7[1-7]|8[124-6]|9[1-79])|4(?:1\d|2[1-8]|3[1-4]|4[13-5]|6[1-578]|9[1-5])|5(?:1\d|[29][1-4]|3[1-5]|4[124]|5[1-6])|6(?:1\d|[269][1-6]|3[1245]|4[1-7]|5[13-9]|7[14]|8[1-5])|7(?:1\d|2[1-5]|3[1-6]|4[1-7]|5[1-57]|6[135]|9[125-7])|8(?:1\d|2[1-5]|[34][1-4]|9[1-57]))\d{6}",
  ),
  IsoCode.GT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1\d{3}|[2-7])\d{7}",
    mobile: r"[3-5]\d{7}",
    fixedLine: r"[267][2-9]\d{6}",
  ),
  IsoCode.GU: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([3-9]\d{6})$|1",
    nationalPrefixTransformRule: r"671$1",
    general: r"(?:[58]\d\d|671|900)\d{7}",
    mobile:
        r"671(?:3(?:00|3[39]|4[349]|55|6[26])|4(?:00|56|7[1-9]|8[02-46-9])|5(?:55|6[2-5]|88)|6(?:3[2-578]|4[24-9]|5[34]|78|8[235-9])|7(?:[0479]7|2[0167]|3[45]|8[7-9])|8(?:[2-57-9]8|6[48])|9(?:2[29]|6[79]|7[1279]|8[7-9]|9[78]))\d{4}",
    fixedLine:
        r"671(?:3(?:00|3[39]|4[349]|55|6[26])|4(?:00|56|7[1-9]|8[02-46-9])|5(?:55|6[2-5]|88)|6(?:3[2-578]|4[24-9]|5[34]|78|8[235-9])|7(?:[0479]7|2[0167]|3[45]|8[7-9])|8(?:[2-57-9]8|6[48])|9(?:2[29]|6[79]|7[1279]|8[7-9]|9[78]))\d{4}",
  ),
  IsoCode.GW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[49]\d{8}|4\d{6}",
    mobile: r"9(?:5\d|6[569]|77)\d{6}",
    fixedLine: r"443\d{6}",
  ),
  IsoCode.GY: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"9008\d{3}|(?:[2-467]\d\d|862)\d{4}",
    mobile: r"(?:6\d\d|70[0-35-7])\d{4}",
    fixedLine:
        r"(?:2(?:1[6-9]|2[0-35-9]|3[1-4]|5[3-9]|6\d|7[0-24-79])|3(?:2[25-9]|3\d)|4(?:4[0-24]|5[56])|77[1-57])\d{4}",
  ),
  IsoCode.HK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"8[0-46-9]\d{6,7}|9\d{4,7}|(?:[2-7]|9\d{3})\d{7}",
    mobile:
        r"(?:4(?:44[5-9]|6(?:0[0-7]|1[0-6]|4[0-57-9]|6[0-4]|7[0-8]))|573[0-6]|6(?:26[013-8]|66[0-3])|70(?:7[1-5]|8[0-4])|848[015-9]|9(?:29[013-9]|59[0-4]))\d{4}|(?:4(?:4[01]|6[2358])|5(?:[1-59][0-46-9]|6[0-4689]|7[0-246-9])|6(?:0[1-9]|[13-59]\d|[268][0-57-9]|7[0-79])|84[09]|9(?:0[1-9]|1[02-9]|[2358][0-8]|[467]\d))\d{5}",
    fixedLine:
        r"(?:2(?:[13-9]\d|2[013-9])\d|3(?:(?:[1569][0-24-9]|4[0-246-9]|7[0-24-69])\d|8(?:[45][0-8]|6[01]|9\d))|58(?:0[1-8]|1[2-9]))\d{4}",
  ),
  IsoCode.HN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"8\d{10}|[237-9]\d{7}",
    mobile: r"[37-9]\d{7}",
    fixedLine:
        r"2(?:2(?:0[0-59]|1[1-9]|[23]\d|4[02-6]|5[57]|6[245]|7[0135689]|8[01346-9]|9[0-2])|4(?:0[578]|2[3-59]|3[13-9]|4[0-68]|5[1-3589])|5(?:0[2357-9]|1[1-356]|4[03-5]|5\d|6[014-69]|7[04]|80)|6(?:[056]\d|17|2[067]|3[047]|4[0-378]|[78][0-8]|9[01])|7(?:0[5-79]|6[46-9]|7[02-9]|8[034]|91)|8(?:79|8[0-357-9]|9[1-57-9]))\d{4}",
  ),
  IsoCode.HR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[24-69]\d|3[0-79])\d{7}|80\d{5,7}|[1-79]\d{7}|6\d{5,6}",
    mobile:
        r"9(?:(?:0[1-9]|[12589]\d)\d\d|7(?:[0679]\d\d|5(?:[01]\d|44|77|9[67])))\d{4}|98\d{6}",
    fixedLine: r"1\d{7}|(?:2[0-3]|3[1-5]|4[02-47-9]|5[1-3])\d{6,7}",
  ),
  IsoCode.HT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-489]\d|55)\d{6}",
    mobile: r"(?:[34]\d|55)\d{6}",
    fixedLine: r"2(?:2\d|5[1-5]|81|9[149])\d{5}",
  ),
  IsoCode.HU: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[235-7]\d{8}|[1-9]\d{7}",
    mobile: r"(?:[257]0|3[01])\d{7}",
    fixedLine:
        r"(?:1\d|[27][2-9]|3[2-7]|4[24-9]|5[2-79]|6[23689]|8[2-57-9]|9[2-69])\d{6}",
  ),
  IsoCode.ID: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"(?:(?:00[1-9]|8\d)\d{4}|[1-36])\d{6}|00\d{10}|[1-9]\d{8,10}|[2-9]\d{7}",
    mobile: r"8[1-35-9]\d{7,10}",
    fixedLine:
        r"2[124]\d{7,8}|619\d{8}|2(?:1(?:14|500)|2\d{3})\d{3}|61\d{5,8}|(?:2(?:[35][1-4]|6[0-8]|7[1-6]|8\d|9[1-8])|3(?:1|[25][1-8]|3[1-68]|4[1-3]|6[1-3568]|7[0-469]|8\d)|4(?:0[1-589]|1[01347-9]|2[0-36-8]|3[0-24-68]|43|5[1-378]|6[1-5]|7[134]|8[1245])|5(?:1[1-35-9]|2[25-8]|3[124-9]|4[1-3589]|5[1-46]|6[1-8])|6(?:[25]\d|3[1-69]|4[1-6])|7(?:02|[125][1-9]|[36]\d|4[1-8]|7[0-36-9])|9(?:0[12]|1[013-8]|2[0-479]|5[125-8]|6[23679]|7[159]|8[01346]))\d{5,8}",
  ),
  IsoCode.IE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1\d|[2569])\d{6,8}|4\d{6,9}|7\d{8}|8\d{8,9}",
    mobile: r"8(?:22|[35-9]\d)\d{6}",
    fixedLine:
        r"(?:1\d|21)\d{6,7}|(?:2[24-9]|4(?:0[24]|5\d|7)|5(?:0[45]|1\d|8)|6(?:1\d|[237-9])|9(?:1\d|[35-9]))\d{5}|(?:23|4(?:[1-469]|8\d)|5[23679]|6[4-6]|7[14]|9[04])\d{7}",
  ),
  IsoCode.IL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"1\d{6}(?:\d{3,5})?|[57]\d{8}|[1-489]\d{7}",
    mobile:
        r"55410\d{4}|5(?:(?:[02368]\d|[19][2-9]|4[1-9])\d|5(?:01|1[79]|2[2-9]|3[0-3]|4[34]|5[015689]|6[6-8]|7[0-267]|8[7-9]|9[1-9]))\d{5}",
    fixedLine: r"153\d{8,9}|29[1-9]\d{5}|(?:2[0-8]|[3489]\d)\d{6}",
  ),
  IsoCode.IM: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([25-8]\d{5})$|0",
    nationalPrefixTransformRule: r"1624$1",
    general: r"1624\d{6}|(?:[3578]\d|90)\d{8}",
    mobile: r"76245[06]\d{4}|7(?:4576|[59]24\d|624[0-4689])\d{5}",
    fixedLine: r"1624(?:230|[5-8]\d\d)\d{3}",
  ),
  IsoCode.IN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:000800|[2-9]\d\d)\d{7}|1\d{7,12}",
    mobile:
        r"(?:61279|7(?:887[02-9]|9(?:313|79[07-9]))|8(?:079[04-9]|(?:84|91)7[02-8]))\d{5}|(?:6(?:12|[2-47]1|5[17]|6[13]|80)[0189]|7(?:1(?:2[0189]|9[0-5])|2(?:[14][017-9]|8[0-59])|3(?:2[5-8]|[34][017-9]|9[016-9])|4(?:1[015-9]|[29][89]|39|8[389])|5(?:[15][017-9]|2[04-9]|9[7-9])|6(?:0[0-47]|1[0-257-9]|2[0-4]|3[19]|5[4589])|70[0289]|88[089]|97[02-8])|8(?:0(?:6[67]|7[02-8])|70[017-9]|84[01489]|91[0-289]))\d{6}|(?:7(?:31|4[47])|8(?:16|2[014]|3[126]|6[136]|7[78]|83))(?:[0189]\d|7[02-8])\d{5}|(?:6(?:[09]\d|1[04679]|2[03689]|3[05-9]|4[0489]|50|6[069]|7[07]|8[7-9])|7(?:0\d|2[0235-79]|3[05-8]|40|5[0346-8]|6[6-9]|7[1-9]|8[0-79]|9[089])|8(?:0[01589]|1[0-57-9]|2[235-9]|3[03-57-9]|[45]\d|6[02457-9]|7[1-69]|8[0-25-9]|9[02-9])|9\d\d)\d{7}|(?:6(?:(?:1[1358]|2[2457]|3[2-4]|4[235-7]|5[2-689]|6[24578]|8[124-6])\d|7(?:[235689]\d|4[0189]))|7(?:1(?:[013-8]\d|9[6-9])|28[6-8]|3(?:2[0-49]|9[2-5])|4(?:1[2-4]|[29][0-7]|3[0-8]|[56]\d|8[0-24-7])|5(?:2[1-3]|9[0-6])|6(?:0[5689]|2[5-9]|3[02-8]|4\d|5[0-367])|70[13-7]|881))[0189]\d{5}",
    fixedLine:
        r"2717(?:[2-7]\d|95)\d{4}|(?:271[0-689]|782[0-6])[2-7]\d{5}|(?:170[24]|2(?:(?:[02][2-79]|90)\d|80[13468])|(?:3(?:23|80)|683|79[1-7])\d|4(?:20[24]|72[2-8])|552[1-7])\d{6}|(?:11|33|4[04]|80)[2-7]\d{7}|(?:342|674|788)(?:[0189][2-7]|[2-7]\d)\d{5}|(?:1(?:2[0-249]|3[0-25]|4[145]|[59][14]|6[014]|7[1257]|8[01346])|2(?:1[257]|3[013]|4[01]|5[0137]|6[0158]|78|8[1568]|9[14])|3(?:26|4[13]|5[34]|6[01489]|7[02-46]|8[159])|4(?:1[36]|2[1-47]|3[15]|5[12]|6[0-26-9]|7[014-9]|8[013-57]|9[014-7])|5(?:1[025]|22|[36][25]|4[28]|[578]1|9[15])|6(?:12|[2-47]1|5[17]|6[13]|80)|7(?:12|2[14]|3[134]|4[47]|5[15]|[67]1)|8(?:16|2[014]|3[126]|6[136]|7[078]|8[34]|91))[2-7]\d{6}|(?:1(?:2[35-8]|3[346-9]|4[236-9]|[59][0235-9]|6[235-9]|7[34689]|8[257-9])|2(?:1[134689]|3[24-8]|4[2-8]|5[25689]|6[2-4679]|7[3-79]|8[2-479]|9[235-9])|3(?:01|1[79]|2[1245]|4[5-8]|5[125689]|6[235-7]|7[157-9]|8[2-46-8])|4(?:1[14578]|2[5689]|3[2-467]|5[4-7]|6[35]|73|8[2689]|9[2389])|5(?:[16][146-9]|2[14-8]|3[1346]|4[14-69]|5[46]|7[2-4]|8[2-8]|9[246])|6(?:1[1358]|2[2457]|3[2-4]|4[235-7]|5[2-689]|6[24578]|7[235689]|8[124-6])|7(?:1[013-9]|2[0235-9]|3[2679]|4[1-35689]|5[2-46-9]|[67][02-9]|8[013-7]|9[089])|8(?:1[1357-9]|2[235-8]|3[03-57-9]|4[0-24-9]|5\d|6[2457-9]|7[1-6]|8[1256]|9[2-4]))\d[2-7]\d{5}",
  ),
  IsoCode.IO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"3\d{6}",
    mobile: r"38\d{5}",
    fixedLine: r"37\d{5}",
  ),
  IsoCode.IQ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1|7\d\d)\d{7}|[2-6]\d{7,8}",
    mobile: r"7[3-9]\d{8}",
    fixedLine: r"1\d{7}|(?:2[13-5]|3[02367]|4[023]|5[03]|6[026])\d{6,7}",
  ),
  IsoCode.IR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-9]\d{9}|(?:[1-8]\d\d|9)\d{3,4}",
    mobile:
        r"9(?:(?:0(?:[0-35]\d|4[4-6])|(?:[13]\d|2[0-3])\d)\d|9(?:[0-46]\d\d|5[15]0|8(?:[12]\d|88)|9(?:0[0-3]|[19]\d|21|69|77|8[7-9])))\d{5}",
    fixedLine:
        r"(?:1[137]|2[13-68]|3[1458]|4[145]|5[1468]|6[16]|7[1467]|8[13467])(?:[03-57]\d{7}|[16]\d{3}(?:\d{4})?|[289]\d{3}(?:\d(?:\d{3})?)?)|94(?:000[09]|2(?:121|[2689]0\d)|30[0-2]\d|4(?:111|40\d))\d{4}",
  ),
  IsoCode.IS: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:38\d|[4-9])\d{6}",
    mobile:
        r"(?:38[589]\d\d|6(?:1[1-8]|2[0-6]|3[026-9]|4[014679]|5[0159]|6[0-69]|70|8[06-8]|9\d)|7(?:5[057]|[6-9]\d)|8(?:2[0-59]|[3-69]\d|8[238]))\d{4}",
    fixedLine:
        r"(?:4(?:1[0-24-69]|2[0-7]|[37][0-8]|4[0-24589]|5[0-68]|6\d|8[0-36-8])|5(?:05|[156]\d|2[02578]|3[0-579]|4[03-7]|7[0-2578]|8[0-35-9]|9[013-689])|872)\d{4}",
  ),
  IsoCode.IT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"0\d{5,10}|1\d{8,10}|3(?:[0-8]\d{7,10}|9\d{7,8})|(?:55|70)\d{8}|8\d{5}(?:\d{2,4})?",
    mobile: r"3[1-9]\d{8}|3[2-9]\d{7}",
    fixedLine:
        r"0669[0-79]\d{1,6}|0(?:1(?:[0159]\d|[27][1-5]|31|4[1-4]|6[1356]|8[2-57])|2\d\d|3(?:[0159]\d|2[1-4]|3[12]|[48][1-6]|6[2-59]|7[1-7])|4(?:[0159]\d|[23][1-9]|4[245]|6[1-5]|7[1-4]|81)|5(?:[0159]\d|2[1-5]|3[2-6]|4[1-79]|6[4-6]|7[1-578]|8[3-8])|6(?:[0-57-9]\d|6[0-8])|7(?:[0159]\d|2[12]|3[1-7]|4[2-46]|6[13569]|7[13-6]|8[1-59])|8(?:[0159]\d|2[3-578]|3[1-356]|[6-8][1-5])|9(?:[0159]\d|[238][1-5]|4[12]|6[1-8]|7[1-6]))\d{2,7}",
  ),
  IsoCode.JE: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([0-24-8]\d{5})$|0",
    nationalPrefixTransformRule: r"1534$1",
    general: r"1534\d{6}|(?:[3578]\d|90)\d{8}",
    mobile: r"7(?:(?:(?:50|82)9|937)\d|7(?:00[378]|97[7-9]))\d{5}",
    fixedLine: r"1534[0-24-8]\d{5}",
  ),
  IsoCode.JM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[58]\d\d|658|900)\d{7}",
    mobile:
        r"(?:658295|876(?:2(?:0[1-9]|[13-9]\d|2[013-9])|[348]\d\d|5(?:0[1-9]|[1-9]\d)|6(?:4[89]|6[67])|7(?:0[07]|7\d|8[1-47-9]|9[0-36-9])|9(?:[01]9|9[0579])))\d{4}",
    fixedLine:
        r"8766060\d{3}|(?:658(?:2(?:[0-8]\d|9[0-46-9])|[3-9]\d\d)|876(?:52[35]|6(?:0[1-3579]|1[0235-9]|[23]\d|40|5[06]|6[2-589]|7[025-9]|8[04]|9[4-9])|7(?:0[2-689]|[1-6]\d|8[056]|9[45])|9(?:0[1-8]|1[02378]|[2-8]\d|9[2-468])))\d{4}",
  ),
  IsoCode.JO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:(?:[2689]|7\d)\d|32|53)\d{6}",
    mobile: r"7(?:[78][0-25-9]|9\d)\d{6}",
    fixedLine:
        r"87(?:000|90[01])\d{3}|(?:2(?:6(?:2[0-35-9]|3[0-578]|4[24-7]|5[0-24-8]|[6-8][023]|9[0-3])|7(?:0[1-79]|10|2[014-7]|3[0-689]|4[019]|5[0-3578]))|32(?:0[1-69]|1[1-35-7]|2[024-7]|3\d|4[0-3]|[5-7][023])|53(?:0[0-3]|[13][023]|2[0-59]|49|5[0-35-9]|6[15]|7[45]|8[1-6]|9[0-36-9])|6(?:2(?:[05]0|22)|3(?:00|33)|4(?:0[0-25]|1[2-7]|2[0569]|[38][07-9]|4[025689]|6[0-589]|7\d|9[0-2])|5(?:[01][056]|2[034]|3[0-57-9]|4[178]|5[0-69]|6[0-35-9]|7[1-379]|8[0-68]|9[0239]))|87(?:20|7[078]|99))\d{4}",
  ),
  IsoCode.JP: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"00[1-9]\d{6,14}|[257-9]\d{9}|(?:00|[1-9]\d\d)\d{6}",
    mobile: r"[7-9]0[1-9]\d{7}",
    fixedLine:
        r"(?:1(?:1[235-8]|2[3-6]|3[3-9]|4[2-6]|[58][2-8]|6[2-7]|7[2-9]|9[1-9])|(?:2[2-9]|[36][1-9])\d|4(?:[2-578]\d|6[02-8]|9[2-59])|5(?:[2-589]\d|6[1-9]|7[2-8])|7(?:[25-9]\d|3[4-9]|4[02-9])|8(?:[2679]\d|3[2-9]|4[5-9]|5[1-9]|8[03-9])|9(?:[2-58]\d|[679][1-9]))\d{6}",
  ),
  IsoCode.KE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[17]\d\d|900)\d{6}|(?:2|80)0\d{6,7}|[4-6]\d{6,8}",
    mobile: r"(?:1(?:0[0-6]|1[0-5]|2[014]|30)|7\d\d)\d{6}",
    fixedLine:
        r"(?:4[245]|5[1-79]|6[01457-9])\d{5,7}|(?:4[136]|5[08]|62)\d{7}|(?:[24]0|66)\d{6,7}",
  ),
  IsoCode.KG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"8\d{9}|(?:[235-8]\d|99)\d{7}",
    mobile:
        r"312(?:58\d|973)\d{3}|(?:2(?:0[0-35]|2\d)|5[0-24-7]\d|600|7(?:[07]\d|55)|88[08]|99[05-9])\d{6}",
    fixedLine:
        r"312(?:5[0-79]\d|9(?:[0-689]\d|7[0-24-9]))\d{3}|(?:3(?:1(?:2[0-46-8]|3[1-9]|47|[56]\d)|2(?:22|3[0-479]|6[0-7])|4(?:22|5[6-9]|6\d)|5(?:22|3[4-7]|59|6\d)|6(?:22|5[35-7]|6\d)|7(?:22|3[468]|4[1-9]|59|[67]\d)|9(?:22|4[1-8]|6\d))|6(?:09|12|2[2-4])\d)\d{5}",
  ),
  IsoCode.KH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"1\d{9}|[1-9]\d{7,8}",
    mobile:
        r"(?:(?:1[28]|3[18]|9[67])\d|6[016-9]|7(?:[07-9]|[16]\d)|8(?:[013-79]|8\d))\d{6}|(?:1\d|9[0-57-9])\d{6}|(?:2[3-6]|3[2-6]|4[2-4]|[5-7][2-5])48\d{5}",
    fixedLine:
        r"23(?:4(?:[2-4]|[56]\d)|[568]\d\d)\d{4}|23[236-9]\d{5}|(?:2[4-6]|3[2-6]|4[2-4]|[5-7][2-5])(?:(?:[237-9]|4[56]|5\d)\d{5}|6\d{5,6})",
  ),
  IsoCode.KI: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[37]\d|6[0-79])\d{6}|(?:[2-48]\d|50)\d{3}",
    mobile:
        r"(?:6200[01]|7(?:310[1-9]|5(?:02[03-9]|12[0-47-9]|22[0-7]|[34](?:0[1-9]|8[02-9])|50[1-9])))\d{3}|(?:63\d\d|7(?:(?:[0146-9]\d|2[0-689])\d|3(?:[02-9]\d|1[1-9])|5(?:[0-2][013-9]|[34][1-79]|5[1-9]|[6-9]\d)))\d{4}",
    fixedLine:
        r"(?:[24]\d|3[1-9]|50|65(?:02[12]|12[56]|22[89]|[3-5]00)|7(?:27\d\d|3100|5(?:02[12]|12[56]|22[89]|[34](?:00|81)|500))|8[0-5])\d{3}",
  ),
  IsoCode.KM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[3478]\d{6}",
    mobile: r"[34]\d{6}",
    fixedLine: r"7[4-7]\d{5}",
  ),
  IsoCode.KN: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-7]\d{6})$|1",
    nationalPrefixTransformRule: r"869$1",
    general: r"(?:[58]\d\d|900)\d{7}",
    mobile: r"869(?:48[89]|55[6-8]|66\d|76[02-7])\d{4}",
    fixedLine: r"869(?:2(?:29|36)|302|4(?:6[015-9]|70)|56[5-7])\d{4}",
  ),
  IsoCode.KP: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"85\d{6}|(?:19\d|[2-7])\d{7}",
    mobile: r"19[1-3]\d{7}",
    fixedLine: r"(?:(?:195|2)\d|3[19]|4[159]|5[37]|6[17]|7[39]|85)\d{6}",
  ),
  IsoCode.KR: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"0(8(?:[1-46-8]|5\d\d))?",
    nationalPrefixTransformRule: null,
    general:
        r"00[1-9]\d{8,11}|(?:[12]|5\d{3})\d{7}|[13-6]\d{9}|(?:[1-6]\d|80)\d{7}|[3-6]\d{4,5}|(?:00|7)0\d{8}",
    mobile:
        r"1(?:05(?:[0-8]\d|9[0-6])|22[13]\d)\d{4,5}|1(?:0[1-46-9]|[16-9]\d|2[013-9])\d{6,7}",
    fixedLine:
        r"(?:2|3[1-3]|[46][1-4]|5[1-5])[1-9]\d{6,7}|(?:3[1-3]|[46][1-4]|5[1-5])1\d{2,3}",
  ),
  IsoCode.KW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"18\d{5}|(?:[2569]\d|41)\d{6}",
    mobile:
        r"(?:41\d\d|5(?:(?:[05]\d|1[0-7]|6[56])\d|2(?:22|5[25])|7(?:55|77)|88[58])|6(?:(?:0[034679]|5[015-9]|6\d)\d|1(?:00|11|66)|222|3[36]3|444|7(?:0[013-9]|[67]\d)|888|9(?:[069]\d|3[039]))|9(?:(?:0[09]|[4679]\d|8[057-9])\d|1(?:1[01]|99)|2(?:00|2\d)|3(?:00|3[03])|5(?:00|5\d)))\d{4}",
    fixedLine:
        r"2(?:[23]\d\d|4(?:[1-35-9]\d|44)|5(?:0[034]|[2-46]\d|5[1-3]|7[1-7]))\d{4}",
  ),
  IsoCode.KY: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-9]\d{6})$|1",
    nationalPrefixTransformRule: r"345$1",
    general: r"(?:345|[58]\d\d|900)\d{7}",
    mobile:
        r"345(?:32[1-9]|42[0-4]|5(?:1[67]|2[5-79]|4[6-9]|50|76)|649|82[56]|9(?:1[679]|2[2-9]|3[06-9]|90))\d{4}",
    fixedLine:
        r"345(?:2(?:22|3[23]|44|66)|333|444|6(?:23|38|40)|7(?:30|4[35-79]|6[6-9]|77)|8(?:00|1[45]|[48]8)|9(?:14|4[035-9]))\d{4}",
  ),
  IsoCode.KZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:33622|8\d{8})\d{5}|[78]\d{9}",
    mobile: r"7(?:0[0-25-8]|47|6[0-4]|7[15-8]|85)\d{7}",
    fixedLine:
        r"(?:33622|7(?:1(?:0(?:[23]\d|4[0-3]|59|63)|1(?:[23]\d|4[0-79]|59)|2(?:[23]\d|59)|3(?:2\d|3[0-79]|4[0-35-9]|59)|4(?:[24]\d|3[013-9]|5[1-9]|97)|5(?:2\d|3[1-9]|4[0-7]|59)|6(?:[2-4]\d|5[19]|61)|72\d|8(?:[27]\d|3[1-46-9]|4[0-5]|59))|2(?:1(?:[23]\d|4[46-9]|5[3469])|2(?:2\d|3[0679]|46|5[12679])|3(?:[2-4]\d|5[139])|4(?:2\d|3[1-35-9]|59)|5(?:[23]\d|4[0-8]|59|61)|6(?:2\d|3[1-9]|4[0-4]|59)|7(?:[2379]\d|40|5[279])|8(?:[23]\d|4[0-3]|59)|9(?:2\d|3[124578]|59))))\d{5}",
  ),
  IsoCode.LA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[23]\d{9}|3\d{8}|(?:[235-8]\d|41)\d{6}",
    mobile: r"(?:20(?:[2359]\d|7[6-8]|88)|302\d)\d{6}",
    fixedLine: r"(?:2[13]|[35-7][14]|41|8[1468])\d{6}",
  ),
  IsoCode.LB: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[27-9]\d{7}|[13-9]\d{6}",
    mobile:
        r"793(?:[01]\d|2[0-4])\d{3}|(?:(?:3|81)\d|7(?:[01]\d|6[013-9]|8[89]|9[12]))\d{5}",
    fixedLine:
        r"7(?:62|8[0-7]|9[04-9])\d{4}|(?:[14-69]\d|2(?:[14-69]\d|[78][1-9])|7[2-57]|8[02-9])\d{5}",
  ),
  IsoCode.LC: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-8]\d{6})$|1",
    nationalPrefixTransformRule: r"758$1",
    general: r"(?:[58]\d\d|758|900)\d{7}",
    mobile:
        r"758(?:28[4-7]|384|4(?:6[01]|8[4-9])|5(?:1[89]|20|84)|7(?:1[2-9]|2\d|3[0-3])|812)\d{4}",
    fixedLine: r"758(?:234|4(?:30|5\d|6[2-9]|8[0-2])|57[0-2]|(?:63|75)8)\d{4}",
  ),
  IsoCode.LI: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"(1001)|0",
    nationalPrefixTransformRule: null,
    general: r"[68]\d{8}|(?:[2378]\d|90)\d{5}",
    mobile:
        r"(?:6(?:(?:4[5-9]|5[0-4])\d|6(?:[0245]\d|[17]0|3[7-9]))\d|7(?:[37-9]\d|42|56))\d{4}",
    fixedLine:
        r"(?:2(?:01|1[27]|2[02]|3\d|6[02-578]|96)|3(?:[24]0|33|7[0135-7]|8[048]|9[0269]))\d{4}",
  ),
  IsoCode.LK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-9]\d{8}",
    mobile: r"7(?:[0-25-8]\d|4[0-4])\d{6}",
    fixedLine:
        r"(?:12[2-9]|602|8[12]\d|9(?:1\d|22|9[245]))\d{6}|(?:11|2[13-7]|3[1-8]|4[157]|5[12457]|6[35-7])[2-57]\d{6}",
  ),
  IsoCode.LR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[25]\d|33|77|88)\d{7}|(?:2\d|[4-6])\d{6}",
    mobile: r"(?:(?:(?:22|33)0|555|(?:77|88)\d)\d|4[67])\d{5}|[56]\d{6}",
    fixedLine: r"2\d{7}",
  ),
  IsoCode.LS: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[256]\d\d|800)\d{5}",
    mobile: r"[56]\d{7}",
    fixedLine: r"2\d{7}",
  ),
  IsoCode.LT: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"[08]",
    nationalPrefixTransformRule: null,
    general: r"(?:[3469]\d|52|[78]0)\d{6}",
    mobile: r"6\d{7}",
    fixedLine: r"(?:3[1478]|4[124-6]|52)\d{6}",
  ),
  IsoCode.LU: PhoneMetadataPatterns(
    nationalPrefixForParsing:
        r"(15(?:0[06]|1[12]|[35]5|4[04]|6[26]|77|88|99)\d)",
    nationalPrefixTransformRule: null,
    general:
        r"35[013-9]\d{4,8}|6\d{8}|35\d{2,4}|(?:[2457-9]\d|3[0-46-9])\d{2,9}",
    mobile: r"6(?:[269][18]|5[1568]|7[189]|81)\d{6}",
    fixedLine:
        r"(?:35[013-9]|80[2-9]|90[89])\d{1,8}|(?:2[2-9]|3[0-46-9]|[457]\d|8[13-9]|9[2-579])\d{2,9}",
  ),
  IsoCode.LV: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[268]\d|90)\d{6}",
    mobile:
        r"23(?:23[0-57-9]|33[0238])\d{3}|2(?:[0-24-9]\d\d|3(?:0[07]|[14-9]\d|2[024-9]|3[0-24-9]))\d{4}",
    fixedLine: r"6\d{7}",
  ),
  IsoCode.LY: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-9]\d{8}",
    mobile: r"9[1-6]\d{7}",
    fixedLine:
        r"(?:2(?:0[56]|[1-6]\d|7[124579]|8[124])|3(?:1\d|2[2356])|4(?:[17]\d|2[1-357]|5[2-4]|8[124])|5(?:[1347]\d|2[1-469]|5[13-5]|8[1-4])|6(?:[1-479]\d|5[2-57]|8[1-5])|7(?:[13]\d|2[13-79])|8(?:[124]\d|5[124]|84))\d{6}",
  ),
  IsoCode.MA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[5-8]\d{8}",
    mobile:
        r"(?:6(?:[0-79]\d|8[0-247-9])|7(?:[017]\d|2[0-2]|6[0-8]|8[0-3]))\d{6}",
    fixedLine:
        r"5293[01]\d{4}|5(?:2(?:[0-25-7]\d|3[1-578]|4[02-46-8]|8[0235-7]|9[0-289])|3(?:[0-47]\d|5[02-9]|6[02-8]|8[0189]|9[3-9])|(?:4[067]|5[03])\d)\d{5}",
  ),
  IsoCode.MC: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[3489]|6\d)\d{7}",
    mobile: r"4(?:[46]\d|5[1-9])\d{5}|(?:3|6\d)\d{7}",
    fixedLine: r"(?:870|9[2-47-9]\d)\d{5}",
  ),
  IsoCode.MD: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[235-7]\d|[89]0)\d{6}",
    mobile: r"562\d{5}|(?:6\d|7[16-9])\d{6}",
    fixedLine: r"(?:(?:2[1-9]|3[1-79])\d|5(?:33|5[257]))\d{5}",
  ),
  IsoCode.ME: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:20|[3-79]\d)\d{6}|80\d{6,7}",
    mobile: r"6(?:[07-9]\d|3[024]|6[0-25])\d{5}",
    fixedLine:
        r"(?:20[2-8]|3(?:[0-2][2-7]|3[24-7])|4(?:0[2-467]|1[2467])|5(?:0[2467]|1[24-7]|2[2-467]))\d{5}",
  ),
  IsoCode.MF: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"590\d{6}|(?:69|80|9\d)\d{7}",
    mobile: r"69(?:0\d\d|1(?:2[2-9]|3[0-5]))\d{4}",
    fixedLine: r"590(?:0[079]|[14]3|[27][79]|30|5[0-268]|87)\d{4}",
  ),
  IsoCode.MG: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([24-9]\d{6})$|0",
    nationalPrefixTransformRule: r"20$1",
    general: r"[23]\d{8}",
    mobile: r"3[2-47-9]\d{7}",
    fixedLine:
        r"2072[29]\d{4}|20(?:2\d|4[47]|5[3467]|6[279]|7[35]|8[268]|9[245])\d{5}",
  ),
  IsoCode.MH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"329\d{4}|(?:[256]\d|45)\d{5}",
    mobile: r"(?:(?:23|54)5|329|45[356])\d{4}",
    fixedLine: r"(?:247|45[78]|528|625)\d{4}",
  ),
  IsoCode.MK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-578]\d{7}",
    mobile:
        r"7(?:3555|(?:474|9[019]7)7)\d{3}|7(?:[0-25-8]\d\d|3(?:[1-48]\d|7[01578])|4(?:2\d|60|7[01578])|9(?:[2-4]\d|5[01]|7[015]))\d{4}",
    fixedLine:
        r"(?:(?:2(?:62|77)0|3444)\d|4[56]440)\d{3}|(?:34|4[357])700\d{3}|(?:2(?:[0-3]\d|5[0-578]|6[01]|82)|3(?:1[3-68]|[23][2-68]|4[23568])|4(?:[23][2-68]|4[3-68]|5[2568]|6[25-8]|7[24-68]|8[4-68]))\d{5}",
  ),
  IsoCode.ML: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[24-9]\d{7}",
    mobile: r"2(?:0(?:01|79)|17\d)\d{4}|(?:5[01]|[679]\d|8[2-49])\d{6}",
    fixedLine:
        r"2(?:07[0-8]|12[67])\d{4}|(?:2(?:02|1[4-689])|4(?:0[0-4]|4[1-39]))\d{5}",
  ),
  IsoCode.MM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"1\d{5,7}|95\d{6}|(?:[4-7]|9[0-46-9])\d{6,8}|(?:2|8\d)\d{5,8}",
    mobile:
        r"(?:17[01]|9(?:2(?:[0-4]|[56]\d\d)|(?:3(?:[0-36]|4\d)|(?:6\d|8[89]|9[4-8])\d|7(?:3|40|[5-9]\d))\d|4(?:(?:[0245]\d|[1379])\d|88)|5[0-6])\d)\d{4}|9[69]1\d{6}|9(?:[68]\d|9[089])\d{5}",
    fixedLine:
        r"(?:1(?:(?:2\d|3[56]|[89][0-6])\d|4(?:2[29]|62|7[0-2]|83)|6)|2(?:2(?:00|8[34])|4(?:0\d|[26]2|7[0-2]|83)|51\d\d)|4(?:2(?:2\d\d|48[013])|3(?:20\d|4(?:70|83)|56)|420\d|5470)|6(?:0(?:[23]|88\d)|(?:124|[56]2\d)\d|2472|3(?:20\d|470)|4(?:2[04]\d|472)|7(?:(?:3\d|8[01459])\d|4[67]0)))\d{4}|5(?:2(?:2\d{5,6}|47[02]\d{4})|(?:3472|4(?:2(?:1|86)|470)|522\d|6(?:20\d|483)|7(?:20\d|48[01])|8(?:20\d|47[02])|9(?:20\d|470))\d{4})|7(?:(?:0470|4(?:25\d|470)|5(?:202|470|96\d))\d{4}|1(?:20\d{4,5}|4(?:70|83)\d{4}))|8(?:1(?:2\d{5,6}|4(?:10|7[01]\d)\d{3})|2(?:2\d{5,6}|(?:320|490\d)\d{3})|(?:3(?:2\d\d|470)|4[24-7]|5(?:(?:2\d|51)\d|4(?:[1-35-9]\d|4[0-57-9]))|6[23])\d{4})|(?:1[2-6]\d|4(?:2[24-8]|3[2-7]|[46][2-6]|5[3-5])|5(?:[27][2-8]|3[2-68]|4[24-8]|5[23]|6[2-4]|8[24-7]|9[2-7])|6(?:[19]20|42[03-6]|(?:52|7[45])\d)|7(?:[04][24-8]|[15][2-7]|22|3[2-4])|8(?:1[2-689]|2[2-8]|[35]2\d))\d{4}|25\d{5,6}|(?:2[2-9]|6(?:1[2356]|[24][2-6]|3[24-6]|5[2-4]|6[2-8]|7[235-7]|8[245]|9[24])|8(?:3[24]|5[245]))\d{4}",
  ),
  IsoCode.MN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[12]\d{7,9}|[5-9]\d{7}",
    mobile: r"(?:83[01]|92[039])\d{5}|(?:5[05]|6[069]|8[015689]|9[013-9])\d{6}",
    fixedLine:
        r"[12]2[1-3]\d{5,6}|(?:(?:[12](?:1|27)|5[368])\d\d|7(?:0(?:[0-5]\d|7[078]|80)|128))\d{4}|[12](?:3[2-8]|4[2-68]|5[1-4689])\d{6,7}",
  ),
  IsoCode.MO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"0800\d{3}|(?:28|[68]\d)\d{6}",
    mobile:
        r"6800[0-79]\d{3}|6(?:[235]\d\d|6(?:0[0-5]|[1-9]\d)|8(?:0[1-9]|[14-8]\d|2[5-9]|[39][0-4]))\d{4}",
    fixedLine: r"(?:28[2-9]|8(?:11|[2-57-9]\d))\d{5}",
  ),
  IsoCode.MP: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-9]\d{6})$|1",
    nationalPrefixTransformRule: r"670$1",
    general: r"[58]\d{9}|(?:67|90)0\d{7}",
    mobile:
        r"670(?:2(?:3[3-7]|56|8[4-8])|32[1-38]|4(?:33|8[348])|5(?:32|55|88)|6(?:64|70|82)|78[3589]|8[3-9]8|989)\d{4}",
    fixedLine:
        r"670(?:2(?:3[3-7]|56|8[4-8])|32[1-38]|4(?:33|8[348])|5(?:32|55|88)|6(?:64|70|82)|78[3589]|8[3-9]8|989)\d{4}",
  ),
  IsoCode.MQ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"596\d{6}|(?:69|80|9\d)\d{7}",
    mobile: r"69(?:6(?:[0-46-9]\d|5[0-6])|727)\d{4}",
    fixedLine: r"596(?:[03-7]\d|10|2[7-9]|8[09]|9[4-9])\d{4}",
  ),
  IsoCode.MR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-4]\d\d|800)\d{5}",
    mobile: r"[2-4][0-46-9]\d{6}",
    fixedLine: r"(?:25[08]|35\d|45[1-7])\d{5}",
  ),
  IsoCode.MS: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([34]\d{6})$|1",
    nationalPrefixTransformRule: r"664$1",
    general: r"(?:[58]\d\d|664|900)\d{7}",
    mobile: r"664(?:3(?:49|9[1-6])|49[2-6])\d{4}",
    fixedLine: r"6644(?:1[0-3]|91)\d{4}",
  ),
  IsoCode.MT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"3550\d{4}|(?:[2579]\d\d|800)\d{5}",
    mobile:
        r"(?:7(?:210|[79]\d\d)|9(?:[29]\d\d|69[67]|8(?:1[1-3]|89|97)))\d{4}",
    fixedLine: r"20(?:3[1-4]|6[059])\d{4}|2(?:0[19]|[1-357]\d|60)\d{5}",
  ),
  IsoCode.MU: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[57]|8\d\d)\d{7}|[2-468]\d{6}",
    mobile:
        r"5(?:4(?:2[1-389]|7[1-9])|87[15-8])\d{4}|(?:5(?:2[5-9]|4[3-689]|[57]\d|8[0-689]|9[0-8])|7(?:0[0-2]|3[013]))\d{5}",
    fixedLine:
        r"(?:2(?:[0346-8]\d|1[0-7])|4(?:[013568]\d|2[4-7])|54(?:[3-5]\d|71)|6\d\d|8(?:14|3[129]))\d{4}",
  ),
  IsoCode.MV: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:800|9[0-57-9]\d)\d{7}|[34679]\d{6}",
    mobile: r"(?:46[46]|[79]\d\d)\d{4}",
    fixedLine:
        r"(?:3(?:0[0-3]|3[0-59])|6(?:[58][024689]|6[024-68]|7[02468]))\d{4}",
  ),
  IsoCode.MW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[1289]\d|31|77)\d{7}|1\d{6}",
    mobile: r"111\d{6}|(?:31|77|[89][89])\d{7}",
    fixedLine: r"(?:1[2-9]|2[12]\d\d)\d{5}",
  ),
  IsoCode.MX: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"0(?:[12]|4[45])|1",
    nationalPrefixTransformRule: null,
    general:
        r"1(?:(?:[27]2|44|99)[1-9]|65[0-689])\d{7}|(?:1(?:[01]\d|2[13-9]|[35][1-9]|4[0-35-9]|6[0-46-9]|7[013-9]|8[1-79]|9[1-8])|[2-9]\d)\d{8}",
    mobile:
        r"657[12]\d{6}|(?:1(?:2(?:2[1-9]|3[1-35-8]|4[13-9]|7[1-689]|8[1-578]|9[467])|3(?:1[1-79]|[2458][1-9]|3\d|7[1-8]|9[1-5])|4(?:1[1-57-9]|[24-7][1-9]|3[1-8]|8[1-35-9]|9[2-689])|5(?:[56]\d|88|9[1-79])|6(?:1[2-68]|[2-4][1-9]|5[1-3689]|6[1-57-9]|7[1-7]|8[67]|9[4-8])|7(?:[1-467][1-9]|5[13-9]|8[1-69]|9[17])|8(?:1\d|2[13-689]|3[1-6]|4[124-6]|6[1246-9]|7[1-378]|9[12479])|9(?:1[346-9]|2[1-4]|3[2-46-8]|5[1348]|[69][1-9]|7[12]|8[1-8]))|2(?:2\d|3[1-35-8]|4[13-9]|7[1-689]|8[1-578]|9[467])|3(?:1[1-79]|[2458][1-9]|3\d|7[1-8]|9[1-5])|4(?:1[1-57-9]|[25-7][1-9]|3[1-8]|4\d|8[1-35-9]|9[2-689])|5(?:[56]\d|88|9[1-79])|6(?:1[2-68]|[2-4][1-9]|5[1-3689]|6[1-57-9]|7[1-7]|8[67]|9[4-8])|7(?:[13467][1-9]|2\d|5[13-9]|8[1-69]|9[17])|8(?:1\d|2[13-689]|3[1-6]|4[124-6]|6[1246-9]|7[1-378]|9[12479])|9(?:1[346-9]|2[1-4]|3[2-46-8]|5[1348]|6[1-9]|7[12]|8[1-8]|9\d))\d{7}",
    fixedLine:
        r"657[12]\d{6}|(?:2(?:0[01]|2\d|3[1-35-8]|4[13-9]|7[1-689]|8[1-578]|9[467])|3(?:1[1-79]|[2458][1-9]|3\d|7[1-8]|9[1-5])|4(?:1[1-57-9]|[25-7][1-9]|3[1-8]|4\d|8[1-35-9]|9[2-689])|5(?:[56]\d|88|9[1-79])|6(?:1[2-68]|[2-4][1-9]|5[1-3689]|6[1-57-9]|7[1-7]|8[67]|9[4-8])|7(?:[13467][1-9]|2\d|5[13-9]|8[1-69]|9[17])|8(?:1\d|2[13-689]|3[1-6]|4[124-6]|6[1246-9]|7[1-378]|9[12479])|9(?:1[346-9]|2[1-4]|3[2-46-8]|5[1348]|6[1-9]|7[12]|8[1-8]|9\d))\d{7}",
  ),
  IsoCode.MY: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"1\d{8,9}|(?:3\d|[4-9])\d{7}",
    mobile:
        r"1(?:1888[689]|4400|8(?:47|8[27])[0-4])\d{4}|1(?:0(?:[23568]\d|4[0-6]|7[016-9]|9[0-8])|1(?:[1-5]\d\d|6(?:0[5-9]|[1-9]\d)|7(?:[0-4]\d|5[0-6]))|(?:[269]\d|[37][1-9]|4[235-9])\d|5(?:31|9\d\d)|8(?:1[23]|[236]\d|4[06]|5(?:46|[7-9])|7[016-9]|8[01]|9[0-8]))\d{5}",
    fixedLine:
        r"(?:3(?:2[0-36-9]|3[0-368]|4[0-278]|5[0-24-8]|6[0-467]|7[1246-9]|8\d|9[0-57])\d|4(?:2[0-689]|[3-79]\d|8[1-35689])|5(?:2[0-589]|[3468]\d|5[0-489]|7[1-9]|9[23])|6(?:2[2-9]|3[1357-9]|[46]\d|5[0-6]|7[0-35-9]|85|9[015-8])|7(?:[2579]\d|3[03-68]|4[0-8]|6[5-9]|8[0-35-9])|8(?:[24][2-8]|3[2-5]|5[2-7]|6[2-589]|7[2-578]|[89][2-9])|9(?:0[57]|13|[25-7]\d|[3489][0-8]))\d{5}",
  ),
  IsoCode.MZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:2|8\d)\d{7}",
    mobile: r"8[2-79]\d{7}",
    fixedLine: r"2(?:[1346]\d|5[0-2]|[78][12]|93)\d{5}",
  ),
  IsoCode.NA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[68]\d{7,8}",
    mobile: r"(?:60|8[1245])\d{7}",
    fixedLine:
        r"64426\d{3}|6(?:1(?:2[2-7]|3[01378]|4[0-4])|254|32[0237]|4(?:27|41|5[25])|52[236-8]|626|7(?:2[2-4]|30))\d{4,5}|6(?:1(?:(?:0\d|2[0189]|3[24-69]|4[5-9])\d|17|69|7[014])|2(?:17|5[0-36-8]|69|70)|3(?:17|2[14-689]|34|6[289]|7[01]|81)|4(?:17|2[0-2]|4[06]|5[0137]|69|7[01])|5(?:17|2[0459]|69|7[01])|6(?:17|25|38|42|69|7[01])|7(?:17|2[569]|3[13]|6[89]|7[01]))\d{4}",
  ),
  IsoCode.NC: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:050|[2-57-9]\d\d)\d{3}",
    mobile: r"(?:5[0-4]|[79]\d|8[0-79])\d{4}",
    fixedLine: r"(?:2[03-9]|3[0-5]|4[1-7]|88)\d{4}",
  ),
  IsoCode.NE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[027-9]\d{7}",
    mobile: r"(?:23|7[047]|[89]\d)\d{6}",
    fixedLine:
        r"2(?:0(?:20|3[1-8]|4[13-5]|5[14]|6[14578]|7[1-578])|1(?:4[145]|5[14]|6[14-68]|7[169]|88))\d{4}",
  ),
  IsoCode.NF: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([0-258]\d{4})$",
    nationalPrefixTransformRule: r"3$1",
    general: r"[13]\d{5}",
    mobile: r"(?:14|3[58])\d{4}",
    fixedLine: r"(?:1(?:06|17|28|39)|3[0-2]\d)\d{3}",
  ),
  IsoCode.NG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[124-7]|9\d{3})\d{6}|[1-9]\d{7}|[78]\d{9,13}",
    mobile:
        r"(?:702[0-24-9]|819[01])\d{6}|(?:70[13-689]|8(?:0[1-9]|1[0-8])|9(?:0[1-9]|1[1-356]))\d{7}",
    fixedLine:
        r"(?:(?:[1-356]\d|4[02-8]|8[2-9])\d|9(?:0[3-9]|[1-9]\d))\d{5}|7(?:0(?:[013-689]\d|2[0-24-9])\d{3,4}|[1-79]\d{6})|(?:[12]\d|4[147]|5[14579]|6[1578]|7[1-3578])\d{5}",
  ),
  IsoCode.NI: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1800|[25-8]\d{3})\d{4}",
    mobile:
        r"(?:5(?:5[0-7]|[78]\d)|6(?:20|3[035]|4[045]|5[05]|77|8[1-9]|9[059])|(?:7[5-8]|8\d)\d)\d{5}",
    fixedLine: r"2\d{7}",
  ),
  IsoCode.NL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"(?:[124-7]\d\d|3(?:[02-9]\d|1[0-8]))\d{6}|8\d{6,9}|9\d{6,10}|1\d{4,5}",
    mobile: r"(?:6[1-58]|970\d)\d{7}",
    fixedLine:
        r"(?:1(?:[035]\d|1[13-578]|6[124-8]|7[24]|8[0-467])|2(?:[0346]\d|2[2-46-9]|5[125]|9[479])|3(?:[03568]\d|1[3-8]|2[01]|4[1-8])|4(?:[0356]\d|1[1-368]|7[58]|8[15-8]|9[23579])|5(?:[0358]\d|[19][1-9]|2[1-57-9]|4[13-8]|6[126]|7[0-3578])|7\d\d)\d{6}",
  ),
  IsoCode.NO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:0|[2-9]\d{3})\d{4}",
    mobile: r"(?:4[015-8]|59|9\d)\d{6}",
    fixedLine: r"(?:2[1-4]|3[1-3578]|5[1-35-7]|6[1-4679]|7[0-8])\d{6}",
  ),
  IsoCode.NP: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1\d|9)\d{9}|[1-9]\d{7}",
    mobile: r"9(?:6[0-3]|7[024-6]|8[0-24-68])\d{7}",
    fixedLine:
        r"(?:1[0-6]\d|99[02-6])\d{5}|(?:2[13-79]|3[135-8]|4[146-9]|5[135-7]|6[13-9]|7[15-9]|8[1-46-9]|9[1-7])[2-6]\d{5}",
  ),
  IsoCode.NR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:444|(?:55|8\d)\d|666)\d{4}",
    mobile: r"(?:55[3-9]|666|8\d\d)\d{4}",
    fixedLine: r"444\d{4}",
  ),
  IsoCode.NU: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[47]|888\d)\d{3}",
    mobile: r"888[4-9]\d{3}",
    fixedLine: r"[47]\d{3}",
  ),
  IsoCode.NZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"[29]\d{7,9}|50\d{5}(?:\d{2,3})?|6[0-35-9]\d{6}|7\d{7,8}|8\d{4,9}|(?:11\d|[34])\d{7}",
    mobile: r"2[0-27-9]\d{7,8}|2(?:1\d|75)\d{5}",
    fixedLine: r"24099\d{3}|(?:3[2-79]|[49][2-9]|6[235-9]|7[2-57-9])\d{6}",
  ),
  IsoCode.OM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1505|[279]\d{3}|500)\d{4}|800\d{5,6}",
    mobile: r"1505\d{4}|(?:7(?:[1289]\d|69|7[0-5])|9(?:0[1-9]|[1-9]\d))\d{5}",
    fixedLine: r"2[1-6]\d{6}",
  ),
  IsoCode.PA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:00800|8\d{3})\d{6}|[68]\d{7}|[1-57-9]\d{6}",
    mobile: r"(?:1[16]1|21[89]|6\d{3}|8(?:1[01]|7[23]))\d{4}",
    fixedLine:
        r"(?:1(?:0\d|1[479]|2[37]|3[0137]|4[17]|5[05]|6[58]|7[0167]|8[2358]|9[1389])|2(?:[0235-79]\d|1[0-7]|4[013-9]|8[02-9])|3(?:[089]\d|1[0-7]|2[0-5]|33|4[0-79]|5[0-35]|6[068]|7[0-8])|4(?:00|3[0-579]|4\d|7[0-57-9])|5(?:[01]\d|2[0-7]|[56]0|79)|7(?:0[09]|2[0-26-8]|3[03]|4[04]|5[05-9]|6[056]|7[0-24-9]|8[5-9]|90)|8(?:09|2[89]|3\d|4[0-24-689]|5[014]|8[02])|9(?:0[5-9]|1[0135-8]|2[036-9]|3[35-79]|40|5[0457-9]|6[05-9]|7[04-9]|8[35-8]|9\d))\d{4}",
  ),
  IsoCode.PE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[14-8]|9\d)\d{7}",
    mobile: r"9\d{8}",
    fixedLine:
        r"(?:(?:4[34]|5[14])[0-8]\d|7(?:173|3[0-8]\d)|8(?:10[05689]|6(?:0[06-9]|1[6-9]|29)|7(?:0[569]|[56]0)))\d{4}|(?:1[0-8]|4[12]|5[236]|6[1-7]|7[246]|8[2-4])\d{6}",
  ),
  IsoCode.PF: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"4\d{5}(?:\d{2})?|8\d{7,8}",
    mobile: r"8[7-9]\d{6}",
    fixedLine: r"4(?:0[4-689]|9[4-68])\d{5}",
  ),
  IsoCode.PG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:180|[78]\d{3})\d{4}|(?:[2-589]\d|64)\d{5}",
    mobile: r"(?:7\d|8[128])\d{6}",
    fixedLine: r"(?:(?:3[0-2]|4[257]|5[34]|9[78])\d|64[1-9]|85[02-46-9])\d{4}",
  ),
  IsoCode.PH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-7]|9\d)\d{8}|2\d{5}|(?:1800|8)\d{7,9}",
    mobile:
        r"(?:8(?:1[37]|9[5-8])|9(?:0[5-9]|1[0-24-9]|[235-7]\d|4[2-9]|8[135-9]|9[1-9]))\d{7}",
    fixedLine:
        r"(?:(?:2[3-8]|3[2-68]|4[2-9]|5[2-6]|6[2-58]|7[24578])\d{3}|88(?:22\d\d|42))\d{4}|(?:2|8[2-8]\d\d)\d{5}",
  ),
  IsoCode.PK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"122\d{6}|[24-8]\d{10,11}|9(?:[013-9]\d{8,10}|2(?:[01]\d\d|2(?:[06-8]\d|1[01]))\d{7})|(?:[2-8]\d{3}|92(?:[0-7]\d|8[1-9]))\d{6}|[24-9]\d{8}|[89]\d{7}",
    mobile: r"3(?:[0-24]\d|3[0-7]|55|64)\d{7}",
    fixedLine:
        r"(?:(?:21|42)[2-9]|58[126])\d{7}|(?:2[25]|4[0146-9]|5[1-35-7]|6[1-8]|7[14]|8[16]|91)[2-9]\d{6,7}|(?:2(?:3[2358]|4[2-4]|9[2-8])|45[3479]|54[2-467]|60[468]|72[236]|8(?:2[2-689]|3[23578]|4[3478]|5[2356])|9(?:2[2-8]|3[27-9]|4[2-6]|6[3569]|9[25-8]))[2-9]\d{5,6}",
  ),
  IsoCode.PL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:6|8\d\d)\d{7}|[1-9]\d{6}(?:\d{2})?|[26]\d{5}",
    mobile:
        r"21(?:1(?:[145]\d|3[1-5])|2[0-4]\d)\d{4}|(?:45|5[0137]|6[069]|7[2389]|88)\d{7}",
    fixedLine:
        r"47\d{7}|(?:1[2-8]|2[2-69]|3[2-4]|4[1-468]|5[24-689]|6[1-3578]|7[14-7]|8[1-79]|9[145])(?:[02-9]\d{6}|1(?:[0-8]\d{5}|9\d{3}(?:\d{2})?))",
  ),
  IsoCode.PM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[45]\d{5}|(?:708|80\d)\d{6}",
    mobile: r"(?:4[02-4]|5[056]|708[45][0-5])\d{4}",
    fixedLine: r"(?:4[1-356]|50)\d{4}",
  ),
  IsoCode.PR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[589]\d\d|787)\d{7}",
    mobile: r"(?:787|939)[2-9]\d{6}",
    fixedLine: r"(?:787|939)[2-9]\d{6}",
  ),
  IsoCode.PS: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2489]2\d{6}|(?:1\d|5)\d{8}",
    mobile: r"5[69]\d{7}",
    fixedLine: r"(?:22[2-47-9]|42[45]|82[014-68]|92[3569])\d{5}",
  ),
  IsoCode.PT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"1693\d{5}|(?:[26-9]\d|30)\d{7}",
    mobile:
        r"6(?:[06]92(?:30|9\d)|[35]92(?:3[03]|9\d))\d{3}|(?:(?:16|6[0356])93|9(?:[1-36]\d\d|480))\d{5}",
    fixedLine:
        r"2(?:[12]\d|3[1-689]|4[1-59]|[57][1-9]|6[1-35689]|8[1-69]|9[1256])\d{6}",
  ),
  IsoCode.PW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[24-8]\d\d|345|900)\d{4}",
    mobile: r"(?:(?:46|83)[0-5]|6[2-4689]0)\d{4}|(?:45|77|88)\d{5}",
    fixedLine:
        r"(?:2(?:55|77)|345|488|5(?:35|44|87)|6(?:22|54|79)|7(?:33|47)|8(?:24|55|76)|900)\d{4}",
  ),
  IsoCode.PY: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"59\d{4,6}|9\d{5,10}|(?:[2-46-8]\d|5[0-8])\d{4,7}",
    mobile: r"9(?:51|6[129]|[78][1-6]|9[1-5])\d{6}",
    fixedLine:
        r"(?:[26]1|3[289]|4[1246-8]|7[1-3]|8[1-36])\d{5,7}|(?:2(?:2[4-68]|[4-68]\d|7[15]|9[1-5])|3(?:18|3[167]|4[2357]|51|[67]\d)|4(?:3[12]|5[13]|9[1-47])|5(?:[1-4]\d|5[02-4])|6(?:3[1-3]|44|7[1-8])|7(?:4[0-4]|5\d|6[1-578]|75|8[0-8])|858)\d{5,6}",
  ),
  IsoCode.QA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"800\d{4}|(?:2|800)\d{6}|(?:0080|[3-7])\d{7}",
    mobile: r"[35-7]\d{7}",
    fixedLine: r"4(?:1111|2022)\d{3}|4(?:[04]\d\d|14[0-6]|999)\d{4}",
  ),
  IsoCode.RE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:26|[689]\d)\d{7}",
    mobile:
        r"(?:69(?:2\d\d|3(?:0[0-46]|1[013]|2[0-2]|3[0-39]|4\d|5[0-5]|6[0-6]|7[0-27]|8[0-8]|9[0-479]))|9(?:399[0-3]|479[0-2]|76(?:2[27]|3[0-37]|9\d)))\d{4}",
    fixedLine: r"26(?:2\d\d|3(?:0\d|1[0-3]))\d{4}",
  ),
  IsoCode.RO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2378]\d|90)\d{7}|[23]\d{5}",
    mobile: r"7020\d{5}|7(?:0[013-9]|1[0-3]|[2-7]\d|8[03-8]|9[0-29])\d{6}",
    fixedLine: r"[23][13-6]\d{7}|(?:2(?:19\d|[3-6]\d9)|31\d\d)\d\d",
  ),
  IsoCode.RS: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"38[02-9]\d{6,9}|6\d{7,9}|90\d{4,8}|38\d{5,6}|(?:7\d\d|800)\d{3,9}|(?:[12]\d|3[0-79])\d{5,10}",
    mobile: r"6(?:[0-689]|7\d)\d{6,7}",
    fixedLine:
        r"(?:11[1-9]\d|(?:2[389]|39)(?:0[2-9]|[2-9]\d))\d{3,8}|(?:1[02-9]|2[0-24-7]|3[0-8])[2-9]\d{4,9}",
  ),
  IsoCode.RU: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"8\d{13}|[347-9]\d{9}",
    mobile: r"9\d{9}",
    fixedLine:
        r"(?:3(?:0[12]|4[1-35-79]|5[1-3]|65|8[1-58]|9[0145])|4(?:01|1[1356]|2[13467]|7[1-5]|8[1-7]|9[1-689])|8(?:1[1-8]|2[01]|3[13-6]|4[0-8]|5[15]|6[1-35-79]|7[1-37-9]))\d{7}",
  ),
  IsoCode.RW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:06|[27]\d\d|[89]00)\d{6}",
    mobile: r"7[2389]\d{7}",
    fixedLine: r"(?:06|2[23568]\d)\d{6}",
  ),
  IsoCode.SA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"92\d{7}|(?:[15]|8\d)\d{8}",
    mobile: r"579[01]\d{5}|5(?:[013-689]\d|7[0-35-8])\d{6}",
    fixedLine: r"1(?:1\d|2[24-8]|3[35-8]|4[3-68]|6[2-5]|7[235-7])\d{6}",
  ),
  IsoCode.SB: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[1-6]|[7-9]\d\d)\d{4}",
    mobile:
        r"48\d{3}|(?:(?:7[1-9]|8[4-9])\d|9(?:1[2-9]|2[013-9]|3[0-2]|[46]\d|5[0-46-9]|7[0-689]|8[0-79]|9[0-8]))\d{4}",
    fixedLine: r"(?:1[4-79]|[23]\d|4[0-2]|5[03]|6[0-37])\d{3}",
  ),
  IsoCode.SC: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"800\d{4}|(?:[249]\d|64)\d{5}",
    mobile: r"2[125-8]\d{5}",
    fixedLine: r"4[2-46]\d{5}",
  ),
  IsoCode.SD: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[19]\d{8}",
    mobile: r"(?:1[0-2]|9[0-3569])\d{7}",
    fixedLine: r"1(?:5\d|8[35-7])\d{6}",
  ),
  IsoCode.SE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"(?:[26]\d\d|9)\d{9}|[1-9]\d{8}|[1-689]\d{7}|[1-4689]\d{6}|2\d{5}",
    mobile: r"7[02369]\d{7}",
    fixedLine:
        r"(?:(?:[12][136]|3[356]|4[0246]|6[03]|8\d)\d|90[1-9])\d{4,6}|(?:1(?:2[0-35]|4[0-4]|5[0-25-9]|7[13-6]|[89]\d)|2(?:2[0-7]|4[0136-8]|5[0138]|7[018]|8[01]|9[0-57])|3(?:0[0-4]|1\d|2[0-25]|4[056]|7[0-2]|8[0-3]|9[023])|4(?:1[013-8]|3[0135]|5[14-79]|7[0-246-9]|8[0156]|9[0-689])|5(?:0[0-6]|[15][0-5]|2[0-68]|3[0-4]|4\d|6[03-5]|7[013]|8[0-79]|9[01])|6(?:1[1-3]|2[0-4]|4[02-57]|5[0-37]|6[0-3]|7[0-2]|8[0247]|9[0-356])|9(?:1[0-68]|2\d|3[02-5]|4[0-3]|5[0-4]|[68][01]|7[0135-8]))\d{5,6}",
  ),
  IsoCode.SG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:(?:1\d|8)\d\d|7000)\d{7}|[3689]\d{7}",
    mobile:
        r"8(?:06[0-689]|95[0-2])\d{4}|(?:8(?:0[1-5]|[1-8]\d|9[0-4])|9[0-8]\d)\d{5}",
    fixedLine: r"662[0-24-9]\d{4}|6(?:[0-578]\d|6[013-57-9]|9[0-35-9])\d{5}",
  ),
  IsoCode.SH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[256]\d|8)\d{3}",
    mobile: r"[56]\d{4}",
    fixedLine: r"2(?:[0-57-9]\d|6[4-9])\d\d",
  ),
  IsoCode.SI: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-7]\d{7}|8\d{4,7}|90\d{4,6}",
    mobile:
        r"65(?:[178]\d|5[56]|6[01])\d{4}|(?:[37][01]|4[0139]|51|6[489])\d{6}",
    fixedLine: r"(?:[1-357][2-8]|4[24-8])\d{6}",
  ),
  IsoCode.SJ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"0\d{4}|(?:[489]\d|[57]9)\d{6}",
    mobile: r"(?:4[015-8]|59|9\d)\d{6}",
    fixedLine: r"79\d{6}",
  ),
  IsoCode.SK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-689]\d{8}|[2-59]\d{6}|[2-5]\d{5}",
    mobile: r"909[1-9]\d{5}|9(?:0[1-8]|1[0-24-9]|4[03-57-9]|5\d)\d{6}",
    fixedLine:
        r"(?:2(?:16|[2-9]\d{3})|(?:(?:[3-5][1-8]\d|819)\d|601[1-5])\d)\d{4}|(?:2|[3-5][1-8])1[67]\d{3}|[3-5][1-8]16\d\d",
  ),
  IsoCode.SL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[237-9]\d|66)\d{6}",
    mobile: r"(?:25|3[0-5]|66|7[2-9]|8[08]|9[09])\d{6}",
    fixedLine: r"22[2-4][2-9]\d{4}",
  ),
  IsoCode.SM: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([89]\d{5})$",
    nationalPrefixTransformRule: r"0549$1",
    general: r"(?:0549|[5-7]\d)\d{6}",
    mobile: r"6[16]\d{6}",
    fixedLine: r"0549(?:8[0157-9]|9\d)\d{4}",
  ),
  IsoCode.SN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[378]\d|93)\d{7}",
    mobile: r"7(?:(?:[06-8]\d|21|90)\d|5(?:01|[19]0|25|[38]3|[4-7]\d))\d{5}",
    fixedLine: r"3(?:0(?:1[0-2]|80)|282|3(?:8[1-9]|9[3-9])|611)\d{5}",
  ),
  IsoCode.SO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[346-9]\d{8}|[12679]\d{7}|[1-5]\d{6}|[1348]\d{5}",
    mobile:
        r"(?:(?:15|(?:3[59]|4[89]|6\d|79|8[08])\d|9(?:0\d|[2-9]))\d|2(?:4\d|8))\d{5}|(?:[67]\d\d|904)\d{5}",
    fixedLine:
        r"(?:1\d|2[0-79]|3[0-46-8]|4[0-7]|5[57-9])\d{5}|(?:[134]\d|8[125])\d{4}",
  ),
  IsoCode.SR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-5]|68|[78]\d)\d{5}",
    mobile: r"(?:7[124-7]|8[124-9])\d{5}",
    fixedLine: r"(?:2[1-3]|3[0-7]|(?:4|68)\d|5[2-58])\d{4}",
  ),
  IsoCode.SS: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[19]\d{8}",
    mobile: r"(?:12|9[1257-9])\d{7}",
    fixedLine: r"1[89]\d{7}",
  ),
  IsoCode.ST: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:22|9\d)\d{5}",
    mobile: r"900[5-9]\d{3}|9(?:0[1-9]|[89]\d)\d{4}",
    fixedLine: r"22\d{5}",
  ),
  IsoCode.SV: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[267]\d{7}|[89]00\d{4}(?:\d{4})?",
    mobile: r"66(?:[02-9]\d\d|1(?:[02-9]\d|16))\d{3}|(?:6[0-57-9]|7\d)\d{6}",
    fixedLine: r"2(?:(?:[1-6]\d\d|990)\d|790[034]|890[0245])\d{3}",
  ),
  IsoCode.SX: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"(5\d{6})$|1",
    nationalPrefixTransformRule: r"721$1",
    general: r"7215\d{6}|(?:[58]\d\d|900)\d{7}",
    mobile: r"7215(?:1[02]|2\d|5[034679]|8[014-8])\d{4}",
    fixedLine: r"7215(?:4[2-8]|8[239]|9[056])\d{4}",
  ),
  IsoCode.SY: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-39]\d{8}|[1-5]\d{7}",
    mobile: r"9[1-689]\d{7}",
    fixedLine:
        r"21\d{6,7}|(?:1(?:[14]\d|[2356])|2[235]|3(?:[13]\d|4)|4[134]|5[1-3])\d{6}",
  ),
  IsoCode.SZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"0800\d{4}|(?:[237]\d|900)\d{6}",
    mobile: r"7[6-9]\d{6}",
    fixedLine: r"[23][2-5]\d{6}",
  ),
  IsoCode.TA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"8\d{3}",
    mobile: r"8\d{3}",
    fixedLine: r"8\d{3}",
  ),
  IsoCode.TC: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-479]\d{6})$|1",
    nationalPrefixTransformRule: r"649$1",
    general: r"(?:[58]\d\d|649|900)\d{7}",
    mobile: r"649(?:2(?:3[129]|4[1-79])|3\d\d|4[34][1-3])\d{4}",
    fixedLine: r"649(?:266|712|9(?:4\d|50))\d{4}",
  ),
  IsoCode.TD: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:22|[69]\d|77)\d{6}",
    mobile: r"(?:6[0235689]|77|9\d)\d{6}",
    fixedLine: r"22(?:[37-9]0|5[0-5]|6[89])\d{4}",
  ),
  IsoCode.TG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[279]\d{7}",
    mobile: r"(?:7[019]|9[0-36-9])\d{6}",
    fixedLine: r"2(?:2[2-7]|3[23]|4[45]|55|6[67]|77)\d{5}",
  ),
  IsoCode.TH: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:001800|[2-57]|[689]\d)\d{7}|1\d{7,9}",
    mobile: r"671[0-8]\d{5}|(?:14|6[1-6]|[89]\d)\d{7}",
    fixedLine: r"(?:1[0689]|2\d|3[2-9]|4[2-5]|5[2-6]|7[3-7])\d{6}",
  ),
  IsoCode.TJ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[0-57-9]\d{8}",
    mobile:
        r"41[18]\d{6}|(?:0[0-27]|1[017]|2[02]|[34]0|5[05]|7[0178]|8[078]|9\d)\d{7}",
    fixedLine:
        r"(?:3(?:1[3-5]|2[245]|3[12]|4[24-7]|5[25]|72)|4(?:46|74|87))\d{6}",
  ),
  IsoCode.TK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-47]\d{3,6}",
    mobile: r"7[2-4]\d{2,5}",
    fixedLine: r"(?:2[2-4]|[34]\d)\d{2,5}",
  ),
  IsoCode.TL: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"7\d{7}|(?:[2-47]\d|[89]0)\d{5}",
    mobile: r"7[2-8]\d{6}",
    fixedLine: r"(?:2[1-5]|3[1-9]|4[1-4])\d{5}",
  ),
  IsoCode.TM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-6]\d{7}",
    mobile: r"6\d{7}",
    fixedLine:
        r"(?:1(?:2\d|3[1-9])|2(?:22|4[0-35-8])|3(?:22|4[03-9])|4(?:22|3[128]|4\d|6[15])|5(?:22|5[7-9]|6[014-689]))\d{5}",
  ),
  IsoCode.TN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-57-9]\d{7}",
    mobile:
        r"3(?:001|[12]40)\d{4}|(?:(?:[259]\d|4[0-7])\d|3(?:1[1-35]|6[0-4]|91))\d{5}",
    fixedLine: r"81200\d{3}|(?:3[0-2]|7\d)\d{6}",
  ),
  IsoCode.TO: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:0800|(?:[5-8]\d\d|999)\d)\d{3}|[2-8]\d{4}",
    mobile: r"(?:55[4-6]|6(?:[09]\d|3[02]|8[15-9])|(?:7\d|8[46-9])\d|999)\d{4}",
    fixedLine: r"(?:2\d|3[0-8]|4[0-4]|50|6[09]|7[0-24-69]|8[05])\d{3}",
  ),
  IsoCode.TR: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"4\d{6}|8\d{11,12}|(?:[2-58]\d\d|900)\d{7}",
    mobile: r"56161\d{5}|5(?:0[15-7]|1[06]|24|[34]\d|5[1-59]|9[46])\d{7}",
    fixedLine:
        r"(?:2(?:[13][26]|[28][2468]|[45][268]|[67][246])|3(?:[13][28]|[24-6][2468]|[78][02468]|92)|4(?:[16][246]|[23578][2468]|4[26]))\d{7}",
  ),
  IsoCode.TT: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-46-8]\d{6})$|1",
    nationalPrefixTransformRule: r"868$1",
    general: r"(?:[58]\d\d|900)\d{7}",
    mobile:
        r"868(?:(?:2[5-9]|3\d)\d|4(?:3[0-6]|[6-9]\d)|6(?:20|78|8\d)|7(?:0[1-9]|1[02-9]|[2-9]\d))\d{4}",
    fixedLine:
        r"868(?:2(?:01|1[5-9]|[23]\d|4[0-2])|6(?:0[7-9]|1[02-8]|2[1-9]|[3-69]\d|7[0-79])|82[124])\d{4}",
  ),
  IsoCode.TV: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:2|7\d\d|90)\d{4}",
    mobile: r"(?:7[01]\d|90)\d{4}",
    fixedLine: r"2[02-9]\d{3}",
  ),
  IsoCode.TW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-689]\d{8}|7\d{9,10}|[2-8]\d{7}|2\d{6}",
    mobile: r"(?:40001[0-2]|9[0-8]\d{4})\d{3}",
    fixedLine:
        r"(?:2[2-8]\d|370|55[01]|7[1-9])\d{6}|4(?:(?:0(?:0[1-9]|[2-48]\d)|1[023]\d)\d{4,5}|(?:[239]\d\d|4(?:0[56]|12|49))\d{5})|6(?:[01]\d{7}|4(?:0[56]|12|24|4[09])\d{4,5})|8(?:(?:2(?:3\d|4[0-269]|[578]0|66)|36[24-9]|90\d\d)\d{4}|4(?:0[56]|12|24|4[09])\d{4,5})|(?:2(?:2(?:0\d\d|4(?:0[68]|[249]0|3[0-467]|5[0-25-9]|6[0235689]))|(?:3(?:[09]\d|1[0-4])|(?:4\d|5[0-49]|6[0-29]|7[0-5])\d)\d)|(?:(?:3[2-9]|5[2-8]|6[0-35-79]|8[7-9])\d\d|4(?:2(?:[089]\d|7[1-9])|(?:3[0-4]|[78]\d|9[01])\d))\d)\d{3}",
  ),
  IsoCode.TZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[25-8]\d|41|90)\d{7}",
    mobile: r"77[2-9]\d{6}|(?:6[125-9]|7[13-689])\d{7}",
    fixedLine: r"2[2-8]\d{7}",
  ),
  IsoCode.UA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[89]\d{9}|[3-9]\d{8}",
    mobile: r"(?:39|50|6[36-8]|7[1-3]|9[1-9])\d{7}",
    fixedLine: r"(?:3[1-8]|4[13-8]|5[1-7]|6[12459])\d{7}",
  ),
  IsoCode.UG: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"800\d{6}|(?:[29]0|[347]\d)\d{7}",
    mobile: r"726[01]\d{5}|7(?:[01578]\d|20|36|[46][0-4]|9[89])\d{6}",
    fixedLine:
        r"20(?:(?:240|30[67])\d|6(?:00[0-2]|30[0-4]))\d{3}|(?:20(?:[017]\d|2[5-9]|32|5[0-4]|6[15-9])|[34]\d{3})\d{5}",
  ),
  IsoCode.US: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[2-9]\d{9}|3\d{6}",
    mobile:
        r"5056(?:[0-35-9]\d|4[46])\d{4}|(?:4722|505[2-57-9])\d{6}|(?:2(?:0[1-35-9]|1[02-9]|2[03-589]|3[149]|4[08]|5[1-46]|6[0279]|7[0269]|8[13])|3(?:0[1-57-9]|1[02-9]|2[01356]|3[0-24679]|4[167]|5[0-2]|6[014]|8[056])|4(?:0[124-9]|1[02-579]|2[3-5]|3[0245]|4[023578]|58|6[349]|7[0589]|8[04])|5(?:0[1-47-9]|1[0235-8]|20|3[0149]|4[01]|5[179]|6[1-47]|7[0-5]|8[0256])|6(?:0[1-35-9]|1[024-9]|2[03689]|[34][016]|5[01679]|6[0-279]|78|8[0-29])|7(?:0[1-46-8]|1[2-9]|2[04-7]|3[1247]|4[037]|5[47]|6[02359]|7[0-59]|8[156])|8(?:0[1-68]|1[02-8]|2[068]|3[0-2589]|4[03578]|5[046-9]|6[02-5]|7[028])|9(?:0[1346-9]|1[02-9]|2[0589]|3[0146-8]|4[01357-9]|5[12469]|7[0-389]|8[04-69]))[2-9]\d{6}",
    fixedLine:
        r"5056(?:[0-35-9]\d|4[46])\d{4}|(?:4722|505[2-57-9])\d{6}|(?:2(?:0[1-35-9]|1[02-9]|2[03-589]|3[149]|4[08]|5[1-46]|6[0279]|7[0269]|8[13])|3(?:0[1-57-9]|1[02-9]|2[01356]|3[0-24679]|4[167]|5[0-2]|6[014]|8[056])|4(?:0[124-9]|1[02-579]|2[3-5]|3[0245]|4[023578]|58|6[349]|7[0589]|8[04])|5(?:0[1-47-9]|1[0235-8]|20|3[0149]|4[01]|5[179]|6[1-47]|7[0-5]|8[0256])|6(?:0[1-35-9]|1[024-9]|2[03689]|[34][016]|5[01679]|6[0-279]|78|8[0-29])|7(?:0[1-46-8]|1[2-9]|2[04-7]|3[1247]|4[037]|5[47]|6[02359]|7[0-59]|8[156])|8(?:0[1-68]|1[02-8]|2[068]|3[0-2589]|4[03578]|5[046-9]|6[02-5]|7[028])|9(?:0[1346-9]|1[02-9]|2[0589]|3[0146-8]|4[01357-9]|5[12469]|7[0-389]|8[04-69]))[2-9]\d{6}",
  ),
  IsoCode.UY: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:0004|4)\d{9}|[1249]\d{7}|(?:[49]\d|80)\d{5}",
    mobile: r"9[1-9]\d{6}",
    fixedLine: r"(?:1(?:770|987)|(?:2\d|4[2-7])\d\d)\d{4}",
  ),
  IsoCode.UZ: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:33|[5-79]\d|88)\d{7}",
    mobile:
        r"(?:(?:33|50|88|9[0-57-9])\d{3}|6(?:1(?:2(?:2[01]|98)|35[0-4]|50\d|61[23]|7(?:[01][017]|4\d|55|9[5-9]))|2(?:(?:11|7\d)\d|2(?:[12]1|9[01379])|5(?:[126]\d|3[0-4]))|5(?:19[01]|2(?:27|9[26])|(?:30|59|7\d)\d)|6(?:2(?:1[5-9]|2[0367]|38|41|52|60)|(?:3[79]|9[0-3])\d|4(?:56|83)|7(?:[07]\d|1[017]|3[07]|4[047]|5[057]|67|8[0178]|9[79]))|7(?:2(?:24|3[237]|4[5-9]|7[15-8])|5(?:7[12]|8[0589])|7(?:0\d|[39][07])|9(?:0\d|7[079]))|9(?:2(?:1[1267]|3[01]|5\d|7[0-4])|(?:5[67]|7\d)\d|6(?:2[0-26]|8\d)))|7(?:[07]\d{3}|1(?:13[01]|6(?:0[47]|1[67]|66)|71[3-69]|98\d)|2(?:2(?:2[79]|95)|3(?:2[5-9]|6[0-6])|57\d|7(?:0\d|1[17]|2[27]|3[37]|44|5[057]|66|88))|3(?:2(?:1[0-6]|21|3[469]|7[159])|(?:33|9[4-6])\d|5(?:0[0-4]|5[579]|9\d)|7(?:[0-3579]\d|4[0467]|6[67]|8[078]))|4(?:2(?:29|5[0257]|6[0-7]|7[1-57])|5(?:1[0-4]|8\d|9[5-9])|7(?:0\d|1[024589]|2[0-27]|3[0137]|[46][07]|5[01]|7[5-9]|9[079])|9(?:7[015-9]|[89]\d))|5(?:112|2(?:0\d|2[29]|[49]4)|3[1568]\d|52[6-9]|7(?:0[01578]|1[017]|[23]7|4[047]|[5-7]\d|8[78]|9[079]))|6(?:2(?:2[1245]|4[2-4])|39\d|41[179]|5(?:[349]\d|5[0-2])|7(?:0[017]|[13]\d|22|44|55|67|88))|9(?:22[128]|3(?:2[0-4]|7\d)|57[02569]|7(?:2[05-9]|3[37]|4\d|60|7[2579]|87|9[07]))))\d{4}",
    fixedLine:
        r"(?:55\d\d|6(?:1(?:22|3[124]|4[1-4]|5[1-3578]|64)|2(?:22|3[0-57-9]|41)|5(?:22|3[3-7]|5[024-8])|6\d\d|7(?:[23]\d|7[69])|9(?:22|4[1-8]|6[135]))|7(?:0(?:5[4-9]|6[0146]|7[124-6]|9[135-8])|(?:1[12]|8\d)\d|2(?:22|3[13-57-9]|4[1-3579]|5[14])|3(?:2\d|3[1578]|4[1-35-7]|5[1-57]|61)|4(?:2\d|3[1-579]|7[1-79])|5(?:22|5[1-9]|6[1457])|6(?:22|3[12457]|4[13-8])|9(?:22|5[1-9])))\d{5}",
  ),
  IsoCode.VA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"0\d{5,10}|3[0-8]\d{7,10}|55\d{8}|8\d{5}(?:\d{2,4})?|(?:1\d|39)\d{7,8}",
    mobile: r"3[1-9]\d{8}|3[2-9]\d{7}",
    fixedLine: r"06698\d{1,6}",
  ),
  IsoCode.VC: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-7]\d{6})$|1",
    nationalPrefixTransformRule: r"784$1",
    general: r"(?:[58]\d\d|784|900)\d{7}",
    mobile: r"784(?:4(?:3[0-5]|5[45]|89|9[0-8])|5(?:2[6-9]|3[0-4])|720)\d{4}",
    fixedLine:
        r"784(?:266|3(?:6[6-9]|7\d|8[0-6])|4(?:38|5[0-36-8]|8[0-8])|5(?:55|7[0-2]|93)|638|784)\d{4}",
  ),
  IsoCode.VE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[68]00\d{7}|(?:[24]\d|[59]0)\d{8}",
    mobile: r"4(?:1[24-8]|2[46])\d{7}",
    fixedLine: r"(?:2(?:12|3[457-9]|[467]\d|[58][1-9]|9[1-6])|[4-6]00)\d{7}",
  ),
  IsoCode.VG: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-578]\d{6})$|1",
    nationalPrefixTransformRule: r"284$1",
    general: r"(?:284|[58]\d\d|900)\d{7}",
    mobile:
        r"284(?:245|3(?:0[0-3]|4[0-7]|68|9[34])|4(?:4[0-6]|68|9[69])|5(?:4[0-7]|68|9[69]))\d{4}",
    fixedLine: r"284(?:229|4(?:22|9[45])|774|8(?:52|6[459]))\d{4}",
  ),
  IsoCode.VI: PhoneMetadataPatterns(
    nationalPrefixForParsing: r"([2-9]\d{6})$|1",
    nationalPrefixTransformRule: r"340$1",
    general: r"[58]\d{9}|(?:34|90)0\d{7}",
    mobile:
        r"340(?:2(?:0[0-368]|2[06-8]|4[49]|77)|3(?:32|44)|4(?:2[23]|44|7[34]|89)|5(?:1[34]|55)|6(?:2[56]|4[23]|77|9[023])|7(?:1[2-57-9]|2[57]|7\d)|884|998)\d{4}",
    fixedLine:
        r"340(?:2(?:0[0-368]|2[06-8]|4[49]|77)|3(?:32|44)|4(?:2[23]|44|7[34]|89)|5(?:1[34]|55)|6(?:2[56]|4[23]|77|9[023])|7(?:1[2-57-9]|2[57]|7\d)|884|998)\d{4}",
  ),
  IsoCode.VN: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[12]\d{9}|[135-9]\d{8}|[16]\d{7}|[16-8]\d{6}",
    mobile:
        r"(?:5(?:2[238]|59)|89[6-9]|99[013-9])\d{6}|(?:3\d|5[689]|7[06-9]|8[1-8]|9[0-8])\d{7}",
    fixedLine:
        r"2(?:0[3-9]|1[0-689]|2[0-25-9]|[38][2-9]|4[2-8]|5[124-9]|6[0-39]|7[0-7]|9[0-4679])\d{7}",
  ),
  IsoCode.VU: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[57-9]\d{6}|(?:[238]\d|48)\d{3}",
    mobile: r"(?:[58]\d|7[013-7])\d{5}",
    fixedLine: r"(?:38[0-8]|48[4-9])\d\d|(?:2[02-9]|3[4-7]|88)\d{3}",
  ),
  IsoCode.WF: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:40|72)\d{4}|8\d{5}(?:\d{3})?",
    mobile: r"(?:72|8[23])\d{4}",
    fixedLine: r"72\d{4}",
  ),
  IsoCode.WS: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:[2-6]|8\d{5})\d{4}|[78]\d{6}|[68]\d{5}",
    mobile: r"(?:7[1-35-7]|8(?:[3-7]|9\d{3}))\d{5}",
    fixedLine: r"6[1-9]\d{3}|(?:[2-5]|60)\d{4}",
  ),
  IsoCode.XK: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[23]\d{7,8}|(?:4\d\d|[89]00)\d{5}",
    mobile: r"4[3-9]\d{6}",
    fixedLine: r"(?:2[89]|39)0\d{6}|[23][89]\d{6}",
  ),
  IsoCode.YE: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:1|7\d)\d{7}|[1-7]\d{6}",
    mobile: r"7[01378]\d{7}",
    fixedLine:
        r"78[0-7]\d{4}|17\d{6}|(?:[12][2-68]|3[2358]|4[2-58]|5[2-6]|6[3-58]|7[24-6])\d{5}",
  ),
  IsoCode.YT: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"(?:(?:(?:26|63)9|80\d)\d|9398)\d{5}",
    mobile:
        r"(?:639(?:0[0-79]|1[019]|[267]\d|3[09]|40|5[05-9]|9[04-79])|9398[01])\d{4}",
    fixedLine: r"269(?:0[0-467]|5[0-3]|6\d|[78]0)\d{4}",
  ),
  IsoCode.ZA: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"[1-79]\d{8}|8\d{4,9}",
    mobile:
        r"(?:1(?:3492[0-25]|4495[0235]|549(?:20|5[01]))|4[34]492[01])\d{3}|8[1-4]\d{3,7}|(?:2[27]|47|54)4950\d{3}|(?:1(?:049[2-4]|9[12]\d\d)|(?:6\d|7[0-46-9])\d{3}|8(?:5\d{3}|7(?:08[67]|158|28[5-9]|310)))\d{4}|(?:1[6-8]|28|3[2-69]|4[025689]|5[36-8])4920\d{3}|(?:12|[2-5]1)492\d{4}",
    fixedLine:
        r"(?:2(?:0330|4302)|52087)0\d{3}|(?:1[0-8]|2[1-378]|3[1-69]|4\d|5[1346-8])\d{7}",
  ),
  IsoCode.ZM: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general: r"800\d{6}|(?:21|63|[79]\d)\d{7}",
    mobile: r"(?:7[5-79]|9[5-8])\d{7}",
    fixedLine: r"21[1-8]\d{6}",
  ),
  IsoCode.ZW: PhoneMetadataPatterns(
    nationalPrefixForParsing: null,
    nationalPrefixTransformRule: null,
    general:
        r"2(?:[0-57-9]\d{6,8}|6[0-24-9]\d{6,7})|[38]\d{9}|[35-8]\d{8}|[3-6]\d{7}|[1-689]\d{6}|[1-3569]\d{5}|[1356]\d{4}",
    mobile: r"7(?:[178]\d|3[1-9])\d{6}",
    fixedLine:
        r"(?:1(?:(?:3\d|9)\d|[4-8])|2(?:(?:(?:0(?:2[014]|5)|(?:2[0157]|31|84|9)\d\d|[56](?:[14]\d\d|20)|7(?:[089]|2[03]|[35]\d\d))\d|4(?:2\d\d|8))\d|1(?:2|[39]\d{4}))|3(?:(?:123|(?:29\d|92)\d)\d\d|7(?:[19]|[56]\d))|5(?:0|1[2-478]|26|[37]2|4(?:2\d{3}|83)|5(?:25\d\d|[78])|[689]\d)|6(?:(?:[16-8]21|28|52[013])\d\d|[39])|8(?:[1349]28|523)\d\d)\d{3}|(?:4\d\d|9[2-9])\d{4,5}|(?:(?:2(?:(?:(?:0|8[146])\d|7[1-7])\d|2(?:[278]\d|92)|58(?:2\d|3))|3(?:[26]|9\d{3})|5(?:4\d|5)\d\d)\d|6(?:(?:(?:[0-246]|[78]\d)\d|37)\d|5[2-8]))\d\d|(?:2(?:[569]\d|8[2-57-9])|3(?:[013-59]\d|8[37])|6[89]8)\d{3}",
  ),
};
