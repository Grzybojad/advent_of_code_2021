import 'input_reader.dart';

int part1() {
  var inputLines = readLines('input/day10_input.txt');

  var closingBracketsPoints = {
    ')': 3,
    ']': 57,
    '}': 1197,
    '>': 25137,
  };

  var matchingBrackets = {
    '(': ')',
    '[': ']',
    '{': '}',
    '<': '>',
  };

  var points = 0;

  for (var line in inputLines) {
    var prevoiusChars = [];
    prevoiusChars.add(line[0]);

    for (var char in line.split('').skip(1)) {
      if (!matchingBrackets.containsKey(char)) {
        var prevoiusChar = prevoiusChars[prevoiusChars.length - 1];

        if (char == matchingBrackets[prevoiusChar]) {
          prevoiusChars.removeLast();
        } else {
          points += closingBracketsPoints[char]!;
          break;
        }
      } else {
        prevoiusChars.add(char);
      }
    }
  }

  return points;
}
