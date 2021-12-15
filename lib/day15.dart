import 'dart:collection';
import 'dart:math';
import 'input_reader.dart';
import 'grid.dart';

int part1() {
  var lines = readLines('input/day15_input.txt');

  var grid = Grid.linesToGrid(lines);

  var dist = Grid.filledGrid(grid.width(), grid.height(), 9999999);
  // dist.printGrid();
  var prevX = Grid.filledGrid(grid.width(), grid.height(), -1);
  var prevY = Grid.filledGrid(grid.width(), grid.height(), -1);

  Queue<Point> queue = Queue();

  for (int y = 0; y < grid.height(); y++) {
    for (int x = 0; x < grid.width(); x++) {
      queue.addLast(Point(x, y));
    }
  }

  dist.setValueAt(0, 0, 0);

  while (queue.isNotEmpty) {
    var u = queue.removeFirst();

    for (var v in grid.neighbourPositions(u).where((e) => queue.contains(e))) {
      var dv = dist.getValueAtPoint(v);
      var du = dist.getValueAtPoint(u);
      var alt = du + grid.getValueAtPoint(v);
      // print(dv);
      // print(alt);
      if (alt < dv) {
        dist.setValueAtPoint(v, alt);
        prevX.setValueAtPoint(v, u.x.floor());
        prevY.setValueAtPoint(v, u.y.floor());
      }
    }
  }

  dist.printGrid();

  return 0;
}
