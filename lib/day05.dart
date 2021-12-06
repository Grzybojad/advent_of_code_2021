import 'input_reader.dart';

int part1() {
  return solvePuzzle(ignoreDiagonals: true);
}

int part2() {
  return solvePuzzle(ignoreDiagonals: false);
}

int solvePuzzle({bool ignoreDiagonals = false}) {
  var inputLines = readLines('input/day05_input.txt');
  Map<Point, int> diagram = {};
  var ventLines = inputLines.map((e) => inputLineToPoints(e)).toList();

  for (var ventLine in ventLines) {
    markVentsOnDiagram(diagram, ventLine, ignoreDiagonal: ignoreDiagonals);
  }

  int over2 = diagram.values.where((e) => e >= 2).length;

  return over2;
}

List<Point> inputLineToPoints(String inputLine) {
  var spaceSplitInput = inputLine.split(" ");
  var point1Input = spaceSplitInput[0];
  var point2Input = spaceSplitInput[2];

  List<Point> points = [
    Point.pointFromString(point1Input),
    Point.pointFromString(point2Input),
  ];

  return points;
}

void markVentsOnDiagram(Map<Point, int> diagram, List<Point> ventLine,
    {bool ignoreDiagonal = true}) {
  var point1 = ventLine[0];
  var point2 = ventLine[1];
  var xStart = point1.x < point2.x ? point1.x : point2.x;
  var xEnd = point1.x > point2.x ? point1.x : point2.x;
  var yStart = point1.y < point2.y ? point1.y : point2.y;
  var yEnd = point1.y > point2.y ? point1.y : point2.y;

  bool diagonalLine = xStart != xEnd && yStart != yEnd;
  if (ignoreDiagonal && diagonalLine) {
    return;
  }

  if (!diagonalLine) {
    var xRange = [for (var i = xStart; i <= xEnd; i++) i];
    var yRange = [for (var i = yStart; i <= yEnd; i++) i];

    for (int x in xRange) {
      for (int y in yRange) {
        addValueToDiagramAtPoint(diagram, Point(x, y));
      }
    }
  } else {
    int iterX = point1.x < point2.x ? 1 : -1;
    int iterY = point1.y < point2.y ? 1 : -1;
    int spotsToMark = xEnd - xStart;

    int x = point1.x;
    int y = point1.y;

    for (int i = 0; i <= spotsToMark; i++) {
      addValueToDiagramAtPoint(diagram, Point(x, y));
      x += iterX;
      y += iterY;
    }
  }
}

void addValueToDiagramAtPoint(Map<Point, int> diagram, Point point) {
  var value = diagram[point];
  if (value == null) {
    diagram[point] = 1;
  } else {
    value++;
    diagram[point] = value;
  }
}

void printDiagram(Map<Point, int> diagram) {
  for (int y = 0; y < 10; y++) {
    var line = "";
    for (int x = 0; x < 10; x++) {
      var value = diagram[Point(x, y)];

      line += value == null ? "." : value.toString();
    }
    print(line);
  }
}

class Point {
  int x = 0;
  int y = 0;

  Point(this.x, this.y);

  Point.pointFromString(String pointString) {
    var splitPointString = pointString.split(",");
    x = int.parse(splitPointString[0]);
    y = int.parse(splitPointString[1]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Point && other.x == x && other.y == y;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + x;
    result = 37 * result + y;
    return result;
  }
}
