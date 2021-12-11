class Grid {
  List<List<int>> _grid = [];

  Grid(List<List<int>> gridNumbers) {
    _grid = gridNumbers;
  }

  Grid.linesToGrid(List<String> lines) {
    var gridNumbers = lines
        .map((line) => line.split('').map((c) => int.parse(c)).toList())
        .toList();

    _grid = gridNumbers;
  }

  int width() => _grid[0].length;
  int height() => _grid.length;

  int getValueAt(int x, int y) => _grid[y][x];
  void setValueAt(int x, int y, int value) => _grid[y][x] = value;
  void addValueAt(int x, int y, int valueToAdd) => _grid[y][x] += valueToAdd;

  bool isOutsideGrid(int x, int y) {
    if (x < 0) return true;
    if (y < 0) return true;
    if (x >= width()) return true;
    if (y >= height()) return true;

    return false;
  }

  bool anyValueMatchesTest(bool Function(int) test) =>
      _grid.any((row) => row.any(test));

  void printGrid() {
    _grid.map((e) => e.join()).forEach(print);
  }
}
