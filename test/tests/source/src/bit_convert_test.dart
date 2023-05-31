// This file works with test_builder
// @MarcR2 (Marc Renken) - https://github.com/MarcR2/test_builder

import 'package:bit_convert/bit_convert.dart';

import '../../../.testGen/source/src/bit_convert.test_gen.dart';
import 'package:test_builder/test_builder.dart';

void main() {
  BitConvertTest();
}

class BitConvertTest extends BitConvertTestTop {
  @override
  void int2stringTest() {
    // TODO: Implement tests;
  }

  @override
  void string2intTest() {
    // TODO: Implement tests
  }

  @override
  void splitByLengthTest() {
    // TODO: Implement tests
  }

  @override
  void stringFromBinaryTest() {
    // TODO: Implement tests
  }

  @override
  void stringToBinaryTest() {
    // TODO: Implement tests
  }

  @override
  void getTimeStringTest() {
    group('in same ms', () {
      test(
        'every should be unique',
        repeated: 64,
        () {
          const repeats = 4096 * 2 * 2 * 2;
          final results = <String>[];
          for (var i = 0; i < repeats; i++) {
            results.add(BitConvert.getTimeString());
          }
          final set = results.toSet();
          print('sample: ${set.take(16)}');
          expect(set.length, equals(repeats));
        },
      );
    });
  }

  @override
  void timeString2DateTimeTest() {
    test(
      'timeString2DateTime',
      repeated: 64,
      () {
        const repeats = 4096 * 2 * 2 * 2;
        for (var i = 0; i < repeats; i++) {
          final time = DateTime.now();
          final timeString = BitConvert.getTimeString(time);
          final dateTime = BitConvert.timeString2DateTime(timeString);

          expect(
            dateTime.millisecondsSinceEpoch,
            equals(time.millisecondsSinceEpoch),
          );
        }
      },
    );
  }

  @override
  void correctForKnownTimesTest() {
    // TODO: implement correctForKnownTimesTest
  }
}
