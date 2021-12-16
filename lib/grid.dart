import 'dart:math';

class Grid {
  List<List<int>> _grid = [];

  Grid(List<List<int>> gridNumbers) {
    _grid = gridNumbers;
  }

  Grid.filledGrid(int width, int height, int fillValue) {
    _grid = List.filled(height, List<int>.filled(width, fillValue));
  }

  Grid.linesToGrid(List<String> lines) {
    var gridNumbers = lines
        .map((line) => line.split('').map((c) => int.parse(c)).toList())
        .toList();

    _grid = gridNumbers;
  }

  int width() => _grid[0].length;
  int height() => _grid.length;

  int getValueAtPoint(Point<int> p) => getValueAt(p.x, p.y);
  void setValueAtPoint(Point<int> p, int value) =>
      setValueAt(p.x.floor(), p.y.floor(), value);
  void addValueAtPoint(Point<int> p, int valueToAdd) =>
      addValueAt(p.x.floor(), p.y.floor(), valueToAdd);

  int getValueAt(int x, int y) => _grid[y][x];
  void setValueAt(int x, int y, int value) => _grid[y][x] = value;
  void addValueAt(int x, int y, int valueToAdd) => _grid[y][x] += valueToAdd;

  bool isPointOutsideGrid(Point p) => isOutsideGrid(p.x.floor(), p.y.floor());

  bool isOutsideGrid(int x, int y) {
    if (x < 0) return true;
    if (y < 0) return true;
    if (x >= width()) return true;
    if (y >= height()) return true;

    return false;
  }

  List<Point<int>> neighbourPositions(Point<int> p) {
    List<Point<int>> neighours = [];
    if (!isPointOutsideGrid(p + Point(0, 1))) neighours.add(p + Point(0, 1));
    if (!isPointOutsideGrid(p + Point(1, 0))) neighours.add(p + Point(1, 0));
    if (!isPointOutsideGrid(p + Point(0, -1))) neighours.add(p + Point(0, -1));
    if (!isPointOutsideGrid(p + Point(-1, 0))) neighours.add(p + Point(-1, 0));

    return neighours;
  }

  bool anyValueMatchesTest(bool Function(int) test) =>
      _grid.any((row) => row.any(test));

  void printGrid() {
    _grid.map((e) => e.join(" ")).forEach(print);
  }
}
