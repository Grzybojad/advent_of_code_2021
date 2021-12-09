import 'input_reader.dart';

int part1() {
  var inputLines = readLines('input/day08_input.txt');

  var outputLines = inputLines.map((line) => line.split("|")[1]).toList();
  var easyDigitsCounts =
      outputLines.map((line) => countEasyDigits(line.split(" ")));

  int easyDigitsSum = easyDigitsCounts.reduce((a, b) => a + b);

  return easyDigitsSum;
}

int part2() {
  var inputLines = readLines('input/day08_input.txt');

  return segmentsToDigit(stringValueToSegments('fac'));
}

int countEasyDigits(List<String> values) {
  return values.where((value) => isEasyDigit(value)).length;
}

bool isEasyDigit(String value) {
  var lengthOfEasyValues = {2, 4, 3, 7};

  return lengthOfEasyValues.contains(value.length);
}

// int decodeDigit(Map<String, String> config, String value) {}

int stringValueToSegments(String value) {
  Map<String, int> config = {
    'a': 0x1000000,
    'b': 0x0100000,
    'c': 0x0010000,
    'd': 0x0001000,
    'e': 0x0000100,
    'f': 0x0000010,
    'g': 0x0000001,
  };

  int segments = 0;
  for (var segmentLetter in value.split('')) {
    var segmentValue = config[segmentLetter];
    if (segmentValue == null) {
      throw "invalid segment value";
    } else {
      segments += segmentValue;
    }
  }

  return segments;
}

int segmentsToDigit(int segments) {
  //                abcdefg
  if (segments == 0x1110111) return 0;
  if (segments == 0x0010010) return 1;
  if (segments == 0x1011101) return 2;
  if (segments == 0x1011011) return 3;
  if (segments == 0x0111010) return 4;
  if (segments == 0x1101011) return 5;
  if (segments == 0x1101111) return 6;
  if (segments == 0x1010010) return 7;
  if (segments == 0x1111111) return 8;
  if (segments == 0x1111011) return 9;

  throw "invalid segments";
}
