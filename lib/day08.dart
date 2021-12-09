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

  int sum = 0;
  for (var inputLine in inputLines) {
    var splitLine = inputLine.split(" | ");
    var input = splitLine[0].split(" ").join().split('');
    var output = splitLine[1].split(" ");

    Map<String, int> inputCharacterScores = {};

    for (var inputChar in input) {
      if (!inputCharacterScores.containsKey(inputChar)) {
        inputCharacterScores[inputChar] =
            input.where((e) => e == inputChar).length;
      }
    }

    var digits = [];
    for (var outputValue in output) {
      var totalScore = outputValue
          .split('')
          .map((e) => inputCharacterScores[e]!)
          .reduce((a, b) => a + b);

      digits.add(digitsByCommonality(totalScore));
    }

    var parsedDigits = int.parse(digits.map((e) => e.toString()).join());
    sum += parsedDigits;
  }

  return sum;
}

int segmentsCommonality(String segments) {
  return segments
      .split('')
      .map((e) => segmentCommonality(e))
      .reduce((a, b) => a + b);
}

int digitsByCommonality(int commonality) {
  for (int i = 0; i <= 9; ++i) {
    if (commonality == segmentsCommonality(getDigitSegments(i))) {
      return i;
    }
  }

  return -1;
}

int segmentCommonality(String segment) {
  Map<String, int> segmentCounts = {
    "a": 8,
    "b": 6,
    "c": 8,
    "d": 7,
    "e": 4,
    "f": 9,
    "g": 7,
  };

  return segmentCounts[segment]!;
}

String getDigitSegments(int digit) {
  var digitSegments = {
    0: "abcefg",
    1: "cf",
    2: "acdeg",
    3: "acdfg",
    4: "bcdf",
    5: "abdfg",
    6: "abdefg",
    7: "acf",
    8: "abcdefg",
    9: "abcdfg",
  };

  return digitSegments[digit]!;
}

int countEasyDigits(List<String> values) {
  return values.where((value) => isEasyDigit(value)).length;
}

bool isEasyDigit(String value) {
  var lengthOfEasyValues = {2, 4, 3, 7};

  return lengthOfEasyValues.contains(value.length);
}
