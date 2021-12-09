import 'input_reader.dart';

int part1() {
  var inputLines = readLines('input/day09_input.txt');

  var heightMap = inputLines
      .map((line) => line.split('').map((c) => int.parse(c)).toList())
      .toList();

  int risk = 0;

  int width = heightMap[0].length;
  int height = heightMap.length;

  for (int y = 0; y < height; ++y) {
    for (int x = 0; x < width; ++x) {
      var val = getValueAt(heightMap, x, y);

      bool lowPoint = (y == 0 || val < getValueAt(heightMap, x, y - 1)) &&
          (x == 0 || val < getValueAt(heightMap, x - 1, y)) &&
          (y == height - 1 || val < getValueAt(heightMap, x, y + 1)) &&
          (x == width - 1 || val < getValueAt(heightMap, x + 1, y));

      if (lowPoint) {
        int riskLevel = val + 1;
        risk += riskLevel;
      }
    }
  }

  return risk;
}

int getValueAt(List<List<int>> heightMap, int x, int y) => heightMap[y][x];
