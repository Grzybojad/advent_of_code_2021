import 'dart:math';
import 'input_reader.dart';

int part1() {
  return solvePuzzle(10);
}

int part2() {
  return solvePuzzle(40);
}

int solvePuzzle(int steps) {
  var lines = readLines('input/day14_input.txt');
  var template = lines[0];

  var rules = insertionRulesFromLines(lines.skip(2).toList());

  var pairCounts = templateToPairCounts(template);

  for (int i = 0; i < steps; ++i) {
    pairCounts = pairCountsAfterStep(pairCounts, rules);
  }

  Map<String, int> letterCounts = {};
  for (var pair in pairCounts.keys) {
    var letter = pair[0];
    var letterCount = letterCounts[letter];

    if (letterCount == null) {
      letterCounts[letter] = pairCounts[pair]!;
    } else {
      letterCounts[letter] = letterCount + pairCounts[pair]!;
    }
  }
  var lastLetter = template[template.length - 1];
  letterCounts[lastLetter] = letterCounts[lastLetter]! + 1;

  var minCharacterCount = letterCounts.values.reduce(min);
  var maxCharacterCount = letterCounts.values.reduce(max);

  return maxCharacterCount - minCharacterCount;
}

Map<String, Set<String>> insertionRulesFromLines(List<String> lines) {
  Map<String, Set<String>> insertionRules = {};

  for (var line in lines.where((e) => e.length > 1)) {
    var splitLine = line.split(" -> ");
    String match = splitLine[0];
    var replacements = {
      match[0] + splitLine[1],
      splitLine[1] + match[1],
    };

    insertionRules[match] = replacements;
  }

  return insertionRules;
}

Map<String, int> templateToPairCounts(String template) {
  Map<String, int> pairCounts = {};

  for (int i = 0; i < template.length - 1; ++i) {
    String pair = template[i] + template[i + 1];

    if (pairCounts.containsKey(pair)) {
      var val = pairCounts[pair]!;
      pairCounts[pair] = val + 1;
    } else {
      pairCounts[pair] = 1;
    }
  }

  return pairCounts;
}

Map<String, int> pairCountsAfterStep(
    Map<String, int> pairCounts, Map<String, Set<String>> rules) {
  Map<String, int> newPairCounts = Map<String, int>.from(pairCounts);

  for (var rule in rules.keys) {
    var rulePairCount = pairCounts[rule];

    if (rulePairCount == null || rulePairCount == 0) continue;

    newPairCounts[rule] = newPairCounts[rule]! - pairCounts[rule]!;

    var toAdd = rules[rule]!;

    for (var extra in toAdd) {
      var oldValue = newPairCounts[extra];

      if (oldValue == null) {
        newPairCounts[extra] = pairCounts[rule]!;
      } else {
        newPairCounts[extra] = oldValue + pairCounts[rule]!;
      }
    }
  }

  return newPairCounts;
}
