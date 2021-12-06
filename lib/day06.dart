import 'input_reader.dart';

int part1() {
  return solvePuzzle(80);
}

int part2() {
  return solvePuzzle(256);
}

int solvePuzzle(int days) {
  var input = readAsString('input/day06_input.txt');
  var numbers = input.split(',');
  var initialStates = numbers.map((s) => int.parse(s)).toList();

  var statesCounter = initialStatesToStatesCounter(initialStates);
  statesCounter = simulateDays(statesCounter, days);

  return statesCounter.reduce((a, b) => a + b);
}

List<int> initialStatesToStatesCounter(List<int> states) {
  var statesCounter = List.filled(9, 0);
  for(int initialState in states) {
    statesCounter[initialState]++;
  }

  return statesCounter;
}

List<int> simulateDays(List<int> statesCounter, int days) {
  var newCounter = statesCounter;
  for(int i=0; i<days; ++i) {
    newCounter = simulateDay(newCounter);
  }

  return newCounter;
}

List<int> simulateDay(List<int> statesCounter) {
  var newCounter = List.filled(9, 0);

  for(int i = 0; i < 8; ++i) {
    newCounter[i] = statesCounter[i+1];
  }
  newCounter[8] = statesCounter[0];
  newCounter[6] += statesCounter[0];

  return newCounter;
}
