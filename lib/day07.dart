import 'input_reader.dart';

int part1() {
  var input = readAsString('input/day07_input.txt');

  var numbers = input.split(',');
  var initialPositions = numbers.map((s) => int.parse(s)).toList();

  return getValueOfLowestTotalDistanceForArray(initialPositions);
}

int part2() {
  var input = readAsString('input/day07_input.txt');

  var numbers = input.split(',');
  var initialPositions = numbers.map((s) => int.parse(s)).toList();

  return getValueOfLowestTotalDistanceForArray(initialPositions,
      nonlinear: true);
}

int getValueOfLowestTotalDistanceForArray(List<int> array,
    {bool nonlinear = false}) {
  int bestValue = median(array).floor();
  int bestDistance =
      totalDistanceToTarget(array, bestValue, nonlinear: nonlinear);
  bool foundBetterValue;

  bool tryADifferentValue(int value) {
    int totalDistance =
        totalDistanceToTarget(array, value, nonlinear: nonlinear);

    if (totalDistance < bestDistance) {
      bestValue = value;
      bestDistance = totalDistance;
      foundBetterValue = true;
      return true;
    } else {
      return false;
    }
  }

  do {
    foundBetterValue = false;
    bool isDifferentValueBetter = tryADifferentValue(bestValue + 1);

    if (isDifferentValueBetter) continue;

    tryADifferentValue(bestValue - 1);
  } while (foundBetterValue);

  return bestDistance;
}

int totalDistanceToTarget(List<int> array, int target, {nonlinear = false}) {
  int total = 0;
  for (int number in array) {
    int distance = (number - target).abs();
    total += nonlinear ? getNonLinearValue(distance) : distance;
  }
  return total;
}

int getNonLinearValue(int n) {
  return ((n + 1) * n / 2).floor();
}

num median(List<num> a) {
  var middle = a.length ~/ 2;
  if (a.length % 2 == 1) {
    return a[middle];
  } else {
    return (a[middle - 1] + a[middle]) / 2.0;
  }
}
