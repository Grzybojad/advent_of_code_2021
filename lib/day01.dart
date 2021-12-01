import 'input_reader.dart';

Future<int> calculate() async {
  var measurements = await readInts('input/day01_input');

  int previousMeasurement = measurements[0];
  int increases = 0;

  for (int measurement in measurements.skip(1)) {
    if (measurement > previousMeasurement) {
      increases++;
    }

    previousMeasurement = measurement;
  }

  return increases;
}
