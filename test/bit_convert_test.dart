import 'package:bit_convert/bit_convert.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('Testing BitConvert class BitConvert in util/bit_convert.dart', () {
    group('int2string', () {
      test('1', () {
        expect(BitConvert.int2string(1), '\x01');
      });
      test('12', () {
        expect(BitConvert.int2string(12), '\f');
      });
      test('123', () {
        expect(BitConvert.int2string(123), '{');
      });
      test('1234', () {
        expect(BitConvert.int2string(1234), '\x04Ò');
      });
      test('1 with byteLen 6', () {
        expect(BitConvert.int2string(1, byteLen: 6), '\x01');
      });
      test('12 with byteLen 6', () {
        expect(BitConvert.int2string(12, byteLen: 6), '\f');
      });
      test('123 with byteLen 6', () {
        expect(BitConvert.int2string(123, byteLen: 6), '\x01;');
      });
      test('1234 with byteLen 6', () {
        expect(BitConvert.int2string(1234, byteLen: 6), '\x13\x12');
      });
      test('1 with char-shift 32', () {
        expect(BitConvert.int2string(1, charShift: 32), '!');
      });
      test('12 with char-shift 32', () {
        expect(BitConvert.int2string(12, charShift: 32), ',');
      });
      test('123 with char-shift 32', () {
        expect(BitConvert.int2string(123, charShift: 32), '');
      });
      test('1234 with char-shift 32', () {
        expect(BitConvert.int2string(1234, charShift: 32), r'$ò');
      });
      test('1 with byteLen 6 & char-shift 32', () {
        expect(BitConvert.int2string(1, byteLen: 6, charShift: 32), '!');
      });
      test('12 with byteLen 6 & char-shift 32', () {
        expect(BitConvert.int2string(12, byteLen: 6, charShift: 32), ',');
      });
      test('123 with byteLen 6 & char-shift 32', () {
        expect(BitConvert.int2string(123, byteLen: 6, charShift: 32), '![');
      });
      test('1234 with byteLen 6 & char-shift 32', () {
        expect(BitConvert.int2string(1234, byteLen: 6, charShift: 32), '32');
      });
    });

    group('string2int', () {
      test('\x01', () {
        expect(BitConvert.string2int('\x01'), 1);
      });
      test('\f', () {
        expect(BitConvert.string2int('\f'), 12);
      });
      test('{', () {
        expect(BitConvert.string2int('{'), 123);
      });
      test('\x04Ò', () {
        expect(BitConvert.string2int('\x04Ò'), 1234);
      });
    });

    group('int2string <==> string2int', () {
      late int nowMilli;
      late int nowMicro;

      setUp(() {
        nowMilli = DateTime.now().millisecondsSinceEpoch;
        nowMicro = DateTime.now().microsecondsSinceEpoch;
      });

      test('With timestamp milli', () {
        final timeStr = BitConvert.int2string(nowMilli);

        final timeInt = BitConvert.string2int(timeStr);
        expect(nowMilli == timeInt, isTrue);
      });

      test('With timestamp micro', () {
        final timeStr = BitConvert.int2string(nowMicro);

        final timeInt = BitConvert.string2int(timeStr);
        expect(nowMicro == timeInt, isTrue);
      });

      test('With timestamp milli and byteLen 6', () {
        final timeStr = BitConvert.int2string(nowMilli, byteLen: 6);
        final timeInt = BitConvert.string2int(timeStr, byteLen: 6);

        expect(nowMilli == timeInt, isTrue);
      });

      test('With timestamp milli and diff byteLen', () {
        final timeStr = BitConvert.int2string(nowMilli, byteLen: 9);
        final timeInt = BitConvert.string2int(timeStr, byteLen: 6);
        expect(nowMilli == timeInt, isFalse);
      });

      test('With timestamp milli and char-shift', () {
        final timeStr = BitConvert.int2string(nowMilli, charShift: 32);
        final timeInt = BitConvert.string2int(timeStr, charShift: 32);

        expect(nowMilli == timeInt, isTrue);
      });

      test('With timestamp milli and false char-shift', () {
        final timeStr = BitConvert.int2string(nowMilli, charShift: 32);
        final timeInt = BitConvert.string2int(timeStr, charShift: 31);
        expect(nowMilli == timeInt, isFalse);
      });

      test('With timestamp milli and byteLen 6 and char-shift', () {
        final timeStr = BitConvert.int2string(
          nowMilli,
          byteLen: 6,
          charShift: 48,
        );
        final timeInt = BitConvert.string2int(
          timeStr,
          byteLen: 6,
          charShift: 48,
        );
        expect(nowMilli == timeInt, isTrue);
      });

      test('With timestamp micro and byteLen 6 and char-shift', () {
        final timeStr = BitConvert.int2string(
          nowMicro,
          byteLen: 6,
          charShift: 48,
        );
        final timeInt = BitConvert.string2int(
          timeStr,
          byteLen: 6,
          charShift: 48,
        );
        expect(nowMicro == timeInt, isTrue);
      });
    });

    group('splitByLength', () {
      test('splitting with length 1', () {
        final split = BitConvert.splitByLength('abcdefghijklmnop', 1);

        expect(split.length, 16, reason: 'length of the result');

        expect(split.first, 'a', reason: 'first element"');

        expect(split.last, 'p', reason: 'last element"');

        expect(split[0], 'a', reason: '[0] should not be ${split[0]}');
        expect(split[1], 'b', reason: '[1] should not be ${split[1]}');
        expect(split[2], 'c', reason: '[2] should not be ${split[2]}');
        expect(split[3], 'd', reason: '[3] should not be ${split[3]}');
        expect(split[4], 'e', reason: '[4] should not be ${split[4]}');
        expect(split[5], 'f', reason: '[5] should not be ${split[5]}');
        expect(split[6], 'g', reason: '[6] should not be ${split[6]}');
        expect(split[7], 'h', reason: '[7] should not be ${split[7]}');
        expect(split[8], 'i', reason: '[8] should not be ${split[8]}');
        expect(split[9], 'j', reason: '[9] should not be ${split[9]}');
        expect(split[10], 'k', reason: 'wrong [10]');
        expect(split[11], 'l', reason: 'wrong [11]');
        expect(split[12], 'm', reason: 'wrong [12]');
        expect(split[13], 'n', reason: 'wrong [13]');
        expect(split[14], 'o', reason: 'wrong [14]');
        expect(split[15], 'p', reason: 'wrong [15]');
      });

      test('splitting with length 2', () {
        final split = BitConvert.splitByLength('abcdefghijklmnop', 2);

        expect(split.length, 8, reason: 'length of the result');
        expect(split.first, 'ab', reason: 'first element"');
        expect(split.last, 'op', reason: 'last element"');

        expect(split[0], 'ab', reason: '[0] should not be ${split[0]}');
        expect(split[1], 'cd', reason: '[1] should not be ${split[1]}');
        expect(split[2], 'ef', reason: '[2] should not be ${split[2]}');
        expect(split[3], 'gh', reason: '[3] should not be ${split[3]}');
        expect(split[4], 'ij', reason: '[4] should not be ${split[4]}');
        expect(split[5], 'kl', reason: '[5] should not be ${split[5]}');
        expect(split[6], 'mn', reason: '[6] should not be ${split[6]}');
        expect(split[7], 'op', reason: '[7] should not be ${split[7]}');
      });
    });

    group('stringFromBinary', () {
      test('reconstruct a', () {
        expect(BitConvert.stringFromBinary('01100001'), 'a');
      });
      test('reconstruct ä', () {
        expect(BitConvert.stringFromBinary('11100100'), 'ä');
      });
      test('reconstruct aä', () {
        expect(BitConvert.stringFromBinary('0110000111100100'), 'aä');
      });
    });

    group('stringToBinary', () {
      test('a', () {
        expect(BitConvert.stringToBinary('a'), '01100001');
      });
      test('ä', () {
        expect(BitConvert.stringToBinary('ä'), '11100100');
      });
      test('aä', () {
        expect(BitConvert.stringToBinary('aä'), '0110000111100100');
      });
    });
  });
}
