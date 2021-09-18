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
    var first = BigInt.parse(start.international);
    var last = BigInt.parse(end.international);

    var bigInterval = last - first;

    var interval = bigInterval.abs().toInt() + 1;

    return interval;
  }

  /// Returns a list of [PhoneNumber]s in the range
  /// [this] to [endOfRange] inclusive.
  List<PhoneNumber> expandRange() {
    var first = BigInt.parse(start.international);
    var last = BigInt.parse(end.international);

    var range = <PhoneNumber>[];
    for (var current = first; current <= last; current = current + BigInt.one) {
      range.add(PhoneParser().parseRaw(current.toString()));
    }

    return range;
  }
}
