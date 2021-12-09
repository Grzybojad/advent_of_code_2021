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

      if (isLowPoint(heightMap, x, y)) {
        int riskLevel = val + 1;
        risk += riskLevel;
      }
    }
  }

  return risk;
}

int part2() {
  var inputLines = readLines('input/day09_input.txt');

  var heightMap = inputLines
      .map((line) => line.split('').map((c) => int.parse(c)).toList())
      .toList();

  int width = heightMap[0].length;
  int height = heightMap.length;

  var basinSizes = [];

  for (int y = 0; y < height; ++y) {
    for (int x = 0; x < width; ++x) {
      var val = getValueAt(heightMap, x, y);

      if (val != -1 && val != 9) {
        var fillSize = basinFill(heightMap, x, y, 0);
        basinSizes.add(fillSize);
      }
    }
  }

  basinSizes.sort();

  return basinSizes.reversed.take(3).reduce((a, b) => a * b);
}

int getValueAt(List<List<int>> heightMap, int x, int y) => heightMap[y][x];

bool isLowPoint(List<List<int>> heightMap, int x, int y) {
  int width = heightMap[0].length;
  int height = heightMap.length;
  var val = getValueAt(heightMap, x, y);

  return (y == 0 || val < getValueAt(heightMap, x, y - 1)) &&
      (x == 0 || val < getValueAt(heightMap, x - 1, y)) &&
      (y == height - 1 || val < getValueAt(heightMap, x, y + 1)) &&
      (x == width - 1 || val < getValueAt(heightMap, x + 1, y));
}

bool touchesBasin(List<List<int>> heightMap, int x, int y) {
  int width = heightMap[0].length;
  int height = heightMap.length;

  return (y != 0 && getValueAt(heightMap, x, y - 1) == -1) ||
      (x != 0 && getValueAt(heightMap, x - 1, y) == -1) ||
      (y != height - 1 && getValueAt(heightMap, x, y + 1) == -1) ||
      (x != width - 1 && getValueAt(heightMap, x + 1, y) == -1);
}

int basinFill(List<List<int>> heightMap, int x, int y, int basinSize) {
  int width = heightMap[0].length;
  int height = heightMap.length;

  heightMap[y][x] = -1;
  basinSize++;

  if (y != 0 &&
      getValueAt(heightMap, x, y - 1) != -1 &&
      getValueAt(heightMap, x, y - 1) != 9) {
    basinSize = basinFill(heightMap, x, y - 1, basinSize);
  }
  if (x != 0 &&
      getValueAt(heightMap, x - 1, y) != -1 &&
      getValueAt(heightMap, x - 1, y) != 9) {
    basinSize = basinFill(heightMap, x - 1, y, basinSize);
  }
  if (y != height - 1 &&
      getValueAt(heightMap, x, y + 1) != -1 &&
      getValueAt(heightMap, x, y + 1) != 9) {
    basinSize = basinFill(heightMap, x, y + 1, basinSize);
  }
  if (x != width - 1 &&
      getValueAt(heightMap, x + 1, y) != -1 &&
      getValueAt(heightMap, x + 1, y) != 9) {
    basinSize = basinFill(heightMap, x + 1, y, basinSize);
  }

  return basinSize;
}
