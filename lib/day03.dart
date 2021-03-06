import 'input_reader.dart';

int part1() {
  var lines = readLines('input/day03_input.txt');
  var lineLength = lines[0].length;
  var commonBits = _mostCommonBits(lines);
  int gamma = _gammaFromCommonBits(commonBits);

  var epsilon = (1 << (lineLength)) - gamma - 1;

  return gamma * epsilon;
}

int part2() {
  var lines = readLines('input/day03_input.txt');
  var oxygen = _binStringToInt(_filterByMostCommonBits(lines)[0]);

  lines = readLines('input/day03_input.txt');
  var co2scrubber = _binStringToInt(_filterByLeastCommonBits(lines)[0]);

  return oxygen * co2scrubber;
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

int _binStringToInt(String binary) {
  int result = 0;
  for (int i = 0; i < binary.length; ++i) {
    result <<= 1;
    result += binary[i] == '1' ? 1 : 0;
  }

  return result;
}

List<String> _filterByMostCommonBits(List<String> lines) {
  for (int i = 0; lines.length > 1 && i < lines[0].length; ++i) {
    var mostCommonBit = _mostCommonBitCharAtIndex(lines, i);
    lines.removeWhere((line) => line[i] != mostCommonBit);
  }

  return lines;
}

List<String> _filterByLeastCommonBits(List<String> lines) {
  for (int i = 0; lines.length > 1 && i < lines[0].length; ++i) {
    var mostCommonBit = _mostCommonBitCharAtIndex(lines, i);
    lines.removeWhere((line) => line[i] == mostCommonBit);
  }

  return lines;
}

String _mostCommonBitCharAtIndex(List<String> lines, int index) {
  var commonBits = _mostCommonBits(lines);
  return commonBits[index] >= 0 ? '1' : '0';
}
