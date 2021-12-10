import 'input_reader.dart';

var closingBracketsPoints = {
  ')': 3,
  ']': 57,
  '}': 1197,
  '>': 25137,
};

var closingBracketsPointsAutocomplete = {
  ')': 1,
  ']': 2,
  '}': 3,
  '>': 4,
};

var matchingBrackets = {
  '(': ')',
  '[': ']',
  '{': '}',
  '<': '>',
};

int part1() {
  var inputLines = readLines('input/day10_input.txt');

  var points = 0;

  for (var line in inputLines) {
    var prevoiusChars = [];
    prevoiusChars.add(line[0]);

    var corruptingChar = isLineCorrupted(line);

    if (corruptingChar != null) {
      points += closingBracketsPoints[corruptingChar]!;
    }
  }

  return points;
}

int part2() {
  var inputLines = readLines('input/day10_input.txt');

  var points = [];

  var notCurruptedLines = getIncompleteLines(inputLines);

  for (var line in notCurruptedLines) {
    var unclosedBrackets = getUnclosedBrackets(line);
    points.add(countPointsForUnclosedBrackets(unclosedBrackets));
  }

  points.sort();
  var middlePoints = points[(points.length / 2).floor()];

  return middlePoints;
}

List<String> getIncompleteLines(List<String> lines) {
  List<String> notCurruptedLines = [];
  for (var line in lines) {
    var previousChars = [];
    previousChars.add(line[0]);

    var corruptingChar = isLineCorrupted(line);

    if (corruptingChar == null) {
      notCurruptedLines.add(line);
    }
  }

  return notCurruptedLines;
}

String? isLineCorrupted(String line) {
  var previousChars = [];
  previousChars.add(line[0]);

  for (var char in line.split('').skip(1)) {
    if (!matchingBrackets.containsKey(char)) {
      var prevoiusChar = previousChars[previousChars.length - 1];

      if (char == matchingBrackets[prevoiusChar]) {
        previousChars.removeLast();
      } else {
        return char;
      }
    } else {
      previousChars.add(char);
    }
  }
}

String getUnclosedBrackets(String line) {
  var previousChars = [];
  previousChars.add(line[0]);
  for (var char in line.split('').skip(1)) {
    if (!matchingBrackets.containsKey(char)) {
      var prevoiusChar = previousChars[previousChars.length - 1];

      if (char == matchingBrackets[prevoiusChar]) {
        previousChars.removeLast();
      } else {
        previousChars.add(char);
      }
    } else {
      previousChars.add(char);
    }
  }
  return previousChars.join();
}

int countPointsForUnclosedBrackets(String line) {
  int points = 0;
  for (var bracket in line.split('').reversed) {
    points *= 5;
    var missingBracket = matchingBrackets[bracket];
    points += closingBracketsPointsAutocomplete[missingBracket]!;
  }
  return points;
}
