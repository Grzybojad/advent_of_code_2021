import 'dart:collection';
import 'dart:math';
import 'input_reader.dart';

int part1() {
  var input = readAsString('input/day13_input.txt');

  var splitInput = input.split("\r\n\r\n");
  var inputLines = splitInput[0].split("\n");
  var foldLines = splitInput[1].split("\n");

  var points = linesToPoints(inputLines);

  for (var line in foldLines.take(1)) {
    foldByInstructionsLine(points, line);
  }

  return points.length;
}

int part2() {
  var input = readAsString('input/day13_input.txt');

  var splitInput = input.split("\r\n\r\n");
  var inputLines = splitInput[0].split("\n");
  var foldLines = splitInput[1].split("\n");

  var points = linesToPoints(inputLines);

  for (var line in foldLines) {
    foldByInstructionsLine(points, line);
  }

  // Uncomment to show solution
  // printPoints(points);

  return points.length;
}

HashSet<Point> linesToPoints(List<String> lines) {
  HashSet<Point> points = HashSet();

  for (var line in lines) {
    var splitLines = line.split(',');
    var x = int.parse(splitLines[0]);
    var y = int.parse(splitLines[1]);
    points.add(Point(x, y));
  }

  return points;
}

void foldByInstructionsLine(HashSet<Point> points, String instructionsLine) {
  var spaceSplitLine = instructionsLine.split(" ");

  if (spaceSplitLine.length < 3) return;

  var foldInstructions = spaceSplitLine[2].split('=');
  var direction = foldInstructions[0];
  var foldPos = int.parse(foldInstructions[1]);

  if (direction == 'x') {
    foldAlongX(points, foldPos);
  } else {
    foldAlongY(points, foldPos);
  }
}

void foldAlongX(HashSet<Point> points, int foldPos) {
  var pointsOnRightPart = points.where((point) => point.x > foldPos).toList();
  points.removeWhere((point) => point.x >= foldPos);

  var flippedRight =
      pointsOnRightPart.map((point) => Point(2 * foldPos - point.x, point.y));

  points.addAll(flippedRight);
}

void foldAlongY(HashSet<Point> points, int foldPos) {
  var pointsOnBottomPart = points.where((point) => point.y > foldPos).toList();
  points.removeWhere((point) => point.y >= foldPos);

  var flippedBottom =
      pointsOnBottomPart.map((point) => Point(point.x, 2 * foldPos - point.y));

  points.addAll(flippedBottom);
}

void printPoints(HashSet<Point> points) {
  int width = 0;
  int height = 0;

  for (var point in points) {
    if (point.x >= width) {
      width = point.x.floor() + 1;
    }
    if (point.y >= height) {
      height = point.y.floor() + 1;
    }
  }

  for (int y = 0; y < height; y++) {
    var line = "";
    for (int x = 0; x < width; x++) {
      line += points.contains(Point(x, y)) ? "#" : " ";
    }
    print(line);
  }
}
