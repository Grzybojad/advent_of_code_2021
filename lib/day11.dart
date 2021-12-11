import 'input_reader.dart';
import 'grid.dart';

const int MaxValueBeforeFlash = 9;

int part1() {
  var inputLines = readLines('input/day11_input.txt');

  var grid = Grid.linesToGrid(inputLines);

  int flashes = 0;
  int steps = 100;
  for (int i = 1; i <= steps; ++i) {
    increaseEnergyBy1(grid);

    while (doesAnyPointWantToFlash(grid)) {
      flashes += handleStepFlashes(grid);
    }
  }

  return flashes;
}

void increaseEnergyBy1(Grid grid) {
  for (int y = 0; y < grid.height(); ++y) {
    for (int x = 0; x < grid.width(); ++x) {
      grid.addValueAt(x, y, 1);
    }
  }
}

int handleStepFlashes(Grid grid) {
  var flashes = 0;

  for (int y = 0; y < grid.height(); ++y) {
    for (int x = 0; x < grid.width(); ++x) {
      var val = grid.getValueAt(x, y);

      if (val > MaxValueBeforeFlash) {
        flashAtPoint(grid, x, y);
        flashes++;
      }
    }
  }

  return flashes;
}

void flashAtPoint(Grid grid, int x, int y) {
  grid.setValueAt(x, y, 0);

  for (int neighbourY = y - 1; neighbourY <= y + 1; ++neighbourY) {
    for (int neighbourX = x - 1; neighbourX <= x + 1; ++neighbourX) {
      if (grid.isOutsideGrid(neighbourX, neighbourY)) continue;
      if (neighbourX == x && neighbourY == y) continue;
      if (grid.getValueAt(neighbourX, neighbourY) == 0) continue;

      grid.addValueAt(neighbourX, neighbourY, 1);
    }
  }
}

bool doesAnyPointWantToFlash(Grid grid) =>
    grid.anyValueMatchesTest((e) => e > MaxValueBeforeFlash);
