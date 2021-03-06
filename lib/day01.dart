import 'input_reader.dart';

int part1() {
  var measurements = readInts('input/day01_input.txt');

  int increases = 0;

  for (int i = 1; i < measurements.length; ++i) {
    if (measurements[i] > measurements[i - 1]) {
      increases++;
    }
  }

  return increases;
}

int part2() {
  var measurements = readInts('input/day01_input.txt');
  int increases = 0;

  for (int i = 0; i < measurements.length - 3; ++i) {
    int firstElement = measurements[i];
    int lastElement = measurements[i + 3];

    if (lastElement > firstElement) {
      increases++;
    }
  }

  return increases;
}
