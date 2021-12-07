import 'input_reader.dart';

int part1() {
  var input = readAsString('input/day07_input.txt');

  var numbers = input.split(',');
  var initialPositions = numbers.map((s) => int.parse(s)).toList();

  return getValueOfLowestTotalDistanceForArray(initialPositions);
}

int getValueOfLowestTotalDistanceForArray(List<int> array) {
  int bestValue = median(array).floor();
  int bestDistance = totalDistanceToTarget(array, bestValue);

  bool foundBetterValue;
  do {
    foundBetterValue = false;
    int distanceToHigherValue = totalDistanceToTarget(array, bestValue + 1);

    if (distanceToHigherValue < bestDistance) {
      bestValue = bestValue + 1;
      bestDistance = distanceToHigherValue;
      foundBetterValue = true;
      continue;
    }

    int distanceToLowerValue = totalDistanceToTarget(array, bestValue - 1);

    if (distanceToLowerValue < bestDistance) {
      bestValue = bestValue - 1;
      bestDistance = distanceToLowerValue;
      foundBetterValue = true;
    }
  } while (foundBetterValue);

  return bestDistance;
}

int totalDistanceToTarget(List<int> array, int target) {
  int total = 0;
  for (int number in array) {
    total += (number - target).abs();
  }
  return total;
}

num median(List<num> a) {
  var middle = a.length ~/ 2;
  if (a.length % 2 == 1) {
    return a[middle];
  } else {
    return (a[middle - 1] + a[middle]) / 2.0;
  }
}
