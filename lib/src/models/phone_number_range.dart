import '../../phone_numbers_parser.dart';

/// Describes a contiguous range of phone numbers
class PhoneNumberRange {
  final PhoneNumber start;
  final PhoneNumber end;

  const PhoneNumberRange(
    this.start,
    this.end,
  );

  @override
  String toString() => '${start.international} - ${end.international}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhoneNumberRange &&
        other.start == start &&
        other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;

  /// Calculates the number of [PhoneNumber]s in the range (inclusive of start and end)
  /// where 'this' is the start of the range and [endOfRange] is the end of the range.
  int get count {
    var first = BigInt.parse(_number(start));
    var last = BigInt.parse(_number(end));

    var bigInterval = last - first;

    var interval = bigInterval.abs().toInt() + 1;

    return interval;
  }

  String _number(PhoneNumber phone) => '${phone.dialCode}${phone.nsn}';

  /// Returns a list of [PhoneNumber]s in the range
  /// [this] to [endOfRange] inclusive.
  List<PhoneNumber> expandRange() {
    var startZeros = _getLeadingZeros(start);

    var first = BigInt.parse(_number(start));
    var last = BigInt.parse(_number(end));

    var range = <PhoneNumber>[];
    for (var current = first; current <= last; current = current + BigInt.one) {
      range.add(PhoneParser().parseRaw(startZeros + current.toString()));
    }

    return range;
  }

  /// Technically this isn't need as [PhoneNumber] uses dial
  /// codes, non of which start with leading zeros.
  /// At a future we may want to support national numbers
  /// which can be of the form 0383208100 in which case
  /// handling leading zeros is already supported.
  String _getLeadingZeros(PhoneNumber phone) {
    var leadingZeros = '';

    for (var digit in _number(phone).runes) {
      if (String.fromCharCode(digit) == '0') {
        leadingZeros += '0';
      } else {
        break;
      }
    }
    return leadingZeros;
  }
}
