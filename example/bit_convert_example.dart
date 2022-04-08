// ignore_for_file: avoid_print

import 'package:bit_convert/bit_convert.dart';

void main() {
  const value = 0x12345678;
  print(value);

  // Convert your int to a interchangeable string
  final str = BitConvert.int2string(value);
  print(str);

  // Convert the string back to your previous int
  final int2 = BitConvert.string2int(str);
  print(int2);
}
