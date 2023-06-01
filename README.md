# BitConvert

[![Dart](https://github.com/Marc-R2/bit_convert/actions/workflows/dart.yml/badge.svg)](https://github.com/Marc-R2/com/actions/workflows/dart.yml)
[![codecov](https://codecov.io/gh/Marc-R2/bit_convert/branch/master/graph/badge.svg?token=9IK2AE76P4)](https://codecov.io/gh/Marc-R2/bit_convert)

The `BitConvert` class provides methods for converting between integers and binary strings on a bit-level.

## Usage

1. Import the `BitConvert` class by adding the following line at the beginning of your Dart file:

    ```dart
    import 'package:bit_convert/bit_convert.dart';
    ```

2. Use the static methods of the `BitConvert` class to perform the desired conversions.

## Methods

### `int2string`

```dart
static String int2string(int i, {int byteLen = 8, int charShift = 0})
```

Translates the bits of an integer into a string representation.

- `i`: The integer value to convert.
- `byteLen`: The number of bits per byte (default: 8).
- `charShift`: The character shift value (default: 0).

Returns the string representation of the binary bits.

### `string2int`

```dart
static int string2int(String s, {int byteLen = 8, int charShift = 0})
```

Translates a string of bits into an integer.

- `s`: The string of bits to convert.
- `byteLen`: The number of bits per byte (default: 8).
- `charShift`: The character shift value (default: 0).

Returns the integer value corresponding to the binary bits.

### `splitByLength`

```dart
static List<String> splitByLength(String str, int n)
```

Splits a string into chunks of a specified length.

- `str`: The string to split.
- `n`: The length of each chunk.

Returns a list of strings representing the chunks.

### `stringFromBinary`

```dart
static String stringFromBinary(String bi, {int byteLen = 8, int charShift = 0})
```

Converts a binary string to a string representation.

- `bi`: The binary string to convert.
- `byteLen`: The number of bits per byte (default: 8).
- `charShift`: The character shift value (default: 0).

Returns the string representation of the binary string.

### `stringToBinary`

```dart
static String stringToBinary(String s, [int byteLen = 8, int charShift = 0])
```

Converts a string into a binary string.

- `s`: The string to convert.
- `byteLen`: The number of bits per byte (default: 8).
- `charShift`: The character shift value (default: 0).

Returns the binary string representation of the input string.

### `getTimeString`

```dart
static String getTimeString([DateTime? dateTime])
```

Gets the current time in milliseconds converted to a string representation.

- `dateTime`: Optional DateTime object representing the specific time to convert (default: current time).

Returns the time string representation.

### `correctForKnownTimes`

```dart
static String correctForKnownTimes(int timeMS, String str)
```

Corrects the time string representation for known times.

- `timeMS`: The time in milliseconds.
- `str`: The original time string representation.

Returns the corrected time string representation.

### `timeString2DateTime`

```dart
static DateTime timeString2DateTime(String timeStringRaw)
```

Converts a time string to a DateTime object.

- `timeStringRaw`: The raw time string.

Returns a DateTime object representing the converted time.

## Known Times

The `BitConvert` class maintains a record of known times to correct for duplicate time string representations.
