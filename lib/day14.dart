import 'dart:math';
import 'input_reader.dart';

int part1() {
  var input = readAsString('input/day14_input.txt');

  var splitInput = input.split("\r\n\r\n");
  var templateLine = splitInput[0];
  var pairInsetionLines = splitInput[1].split("\r\n");

  var polymer = templateLine;

  Map<String, String> rules = insertionRulesFromLines(pairInsetionLines);

  int steps = 10;
  for (int i = 0; i < steps; ++i) {
    polymer = getPolymerAfterStep(rules, polymer);
  }

  var counts = characterCounts(polymer);

  var minCharacterCount = counts.values.reduce(min);
  var maxCharacterCount = counts.values.reduce(max);

  return maxCharacterCount - minCharacterCount;
}

Map<String, String> insertionRulesFromLines(List<String> lines) {
  Map<String, String> insertionRules = {};

  for (var line in lines.where((e) => e.length > 1)) {
    var splitLine = line.split(" -> ");
    String match = splitLine[0];
    String replacement = splitLine[1];

    insertionRules[match] = replacement;
  }

  return insertionRules;
}

Map<String, int> characterCounts(String line) {
  Map<String, int> characterCounts = {};

  for (var char in line.split('')) {
    if (characterCounts.containsKey(char)) {
      var val = characterCounts[char]!;
      characterCounts[char] = val + 1;
    } else {
      characterCounts[char] = 1;
    }
  }

  return characterCounts;
}

String getPolymerAfterStep(Map<String, String> rules, String polymer) {
  String newPolymer = "";

  for (int i = 0; i < polymer.length - 1; ++i) {
    String pair = polymer[i] + polymer[i + 1];
    newPolymer += polymer[i];

    var valueToInsert = rules[pair];

    if (valueToInsert != null) {
      newPolymer += valueToInsert;
    }
  }

  newPolymer += polymer[polymer.length - 1];

  return newPolymer;
}
