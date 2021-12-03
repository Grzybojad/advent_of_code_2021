import 'input_reader.dart';

int part1() {
  var lines = readLines('input/day03_input.txt');
  var lineLength = lines[0].length;
  var commonBits = _mostCommonBits(lines);
  int gamma = _gammaFromCommonBits(commonBits);

  var epsilon = (1 << (lineLength)) - gamma - 1;

  return gamma * epsilon;
}

List<int> _mostCommonBits(List<String> lines) {
  var lineLength = lines[0].length;
  var commonBits = List<int>.filled(lineLength, 0);

  for (var line in lines) {
    for (int i = 0; i < lineLength; ++i) {
      commonBits[i] += line[i] == '1' ? 1 : -1;
    }
  }

  return commonBits;
}

int _gammaFromCommonBits(List<int> commonBits) {
  int gamma = 0;
  for (int i = 0; i < commonBits.length; ++i) {
    gamma <<= 1;
    gamma += commonBits[i] > 0 ? 1 : 0;
  }

  return gamma;
}
