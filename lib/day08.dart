import 'input_reader.dart';

int part1() {
  var inputLines = readLines('input/day08_input.txt');

  var outputLines = inputLines.map((line) => line.split("|")[1]).toList();
  var easyDigitsCounts =
      outputLines.map((line) => countEasyDigits(line.split(" ")));

  int easyDigitsSum = easyDigitsCounts.reduce((a, b) => a + b);

  return easyDigitsSum;
}

int countEasyDigits(List<String> values) {
  return values.where((value) => isEasyDigit(value)).length;
}

bool isEasyDigit(String value) {
  var lengthOfEasyValues = {2, 4, 3, 7};

  return lengthOfEasyValues.contains(value.length);
}
