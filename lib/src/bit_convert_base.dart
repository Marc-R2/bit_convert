import 'dart:math';

import 'package:test_builder_annotation/test_builder_annotation.dart';

/// BitConvert - convert on bit-level
@TestGen()
class BitConvert {
  /// Translates the bits of an int into a String
  static String int2string(int i, {int byteLen = 8, int charShift = 0}) {
    var bi = i.toRadixString(2);
    bi = bi.padLeft(bi.length + (byteLen - (bi.length % byteLen)), '0');
    return stringFromBinary(bi, byteLen: byteLen, charShift: charShift);
  }

  /// Translates the bits of a String into an int
  static int string2int(String s, {int byteLen = 8, int charShift = 0}) {
    final bits = splitByLength(stringToBinary(s, byteLen, charShift), 1)
        .reversed
        .toList();
    num res = 0;
    bits
        .asMap()
        .forEach((int key, element) => res += int.parse(element) * pow(2, key));
    return res.toInt();
  }

  /// Splits [str] into chunks of size [n]
  static List<String> splitByLength(String str, int n) {
    // Split the [str] into pieces of length [n]
    final exp = RegExp('.{$n}');
    final Iterable<Match> matches = exp.allMatches(str);
    final res = matches.map((m) => m.group(0) ?? '').toList();
    if (res.length < (str.length.toDouble() / n)) {
      res.add(str.substring(matches.length * n));
    }
    return res;
  }

  /// Converts binary to a String
  static String stringFromBinary(
    String bi, {
    int byteLen = 8,
    int charShift = 0,
  }) {
    // Convert Binary [bi] with [byteLen] bits to List<int> and add [charShift]
    final charCodes = splitByLength(bi, byteLen).map<int>((m) {
      return int.parse(m, radix: 2) + charShift;
    }).toList();
    // Turn List<int> into String
    return String.fromCharCodes(charCodes);
  }

  /// Converts a String into binary
  static String stringToBinary(
    String s, [
    int byteLen = 8,
    int charShift = 0,
  ]) {
    // Convert String to List<int> and map these ints to binary
    return s.codeUnits.map((int strInt) {
      return (strInt - charShift).toRadixString(2).padLeft(byteLen, '0');
    }).join();
  }

  /// Get current time in milliseconds converted string
  /// with byteLen 6 and char-shift 48
  /// Expects a string of length 7 to 8
  static String getTimeString([DateTime? dateTime]) {
    final ms = (dateTime ?? DateTime.now()).millisecondsSinceEpoch;
    final str = int2string(
      ms,
      byteLen: 6,
      charShift: 48,
    ).replaceAll(r'\', 'z');
    return correctForKnownTimes(ms, str);
  }

  static final knownTimes = <int, int>{};

  static String correctForKnownTimes(int timeMS, String str) {
    final count = knownTimes[timeMS] ??= 0;
    knownTimes[timeMS] = count + 1;
    if (count == 0) return str;
    return '$str!${count.toRadixString(36)}';
  }

  /// Convert time string to DateTime
  /// with byteLen 6 and char-shift 48
  static DateTime timeString2DateTime(String timeStringRaw) {
    final timeString = timeStringRaw.replaceAll(RegExp('![0-9a-z]+'), '');
    return DateTime.fromMillisecondsSinceEpoch(
      string2int(timeString.replaceAll('z', r'\'), byteLen: 6, charShift: 48),
    );
  }
}
