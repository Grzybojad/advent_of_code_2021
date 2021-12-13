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
    var foldInstructions = line.split(" ")[2].split('=');
    var direction = foldInstructions[0];
    var foldPos = int.parse(foldInstructions[1]);

    if (direction == 'x') {
      foldAlongX(points, foldPos);
    } else {
      foldAlongY(points, foldPos);
    }
  }

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

void foldAlongX(HashSet<Point> points, int foldPos) {
  var pointsOnRightPart = points.where((point) => point.x > foldPos).toList();
  points.removeWhere((point) => point.x >= foldPos);

  var flippedRight =
      pointsOnRightPart.map((e) => Point(2 * foldPos - e.x, e.y));

  points.addAll(flippedRight);
}

void foldAlongY(HashSet<Point> points, int foldPos) {
  var pointsOnBottomPart = points.where((point) => point.y > foldPos).toList();
  points.removeWhere((point) => point.y >= foldPos);

  var flippedBottom =
      pointsOnBottomPart.map((e) => Point(e.x, 2 * foldPos - e.y));

  points.addAll(flippedBottom);
}
