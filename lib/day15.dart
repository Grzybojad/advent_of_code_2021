import 'dart:collection';
import 'dart:math';

import 'input_reader.dart';
import 'grid.dart';

const int inf = 99999999999;

int part1() {
  var lines = readLines('input/day15_input.txt');

  var grid = Grid.linesToGrid(lines);

  var minCost =
      aStar(grid, Point(0, 0), Point(grid.width() - 1, grid.height() - 1));

  return minCost;
}

int getPathCost(
    Grid grid, HashMap<Point<int>, Point<int>> cameFrom, Point<int> current) {
  int pathCost = 0;
  while (cameFrom.containsKey(current)) {
    pathCost += grid.getValueAtPoint(current);
    current = cameFrom[current]!;
  }
  return pathCost;
}

int aStar(Grid grid, Point<int> start, Point<int> goal) {
  HashSet<Point<int>> openSet = HashSet();
  HashMap<Point<int>, Point<int>> cameFrom = HashMap();
  HashMap<Point<int>, int> gScore = HashMap();
  HashMap<Point<int>, int> fScore = HashMap();

  openSet.add(start);
  gScore[start] = 0;
  fScore[start] = distanceToEndNode(grid, start, goal);

  while (openSet.isNotEmpty) {
    var current = openSet.reduce(
      (e1, e2) => (fScore[e1] ?? inf) <= (fScore[e2] ?? inf) ? e1 : e2,
    );

    if (current == goal) {
      return getPathCost(grid, cameFrom, current);
    }

    openSet.remove(current);

    for (var neighbour in grid.neighbourPositions(current)) {
      var tentativeGScore =
          (gScore[current] ?? inf) + grid.getValueAtPoint(neighbour);

      if (tentativeGScore < (gScore[neighbour] ?? inf)) {
        cameFrom[neighbour] = current;
        gScore[neighbour] = tentativeGScore;
        fScore[neighbour] =
            tentativeGScore + distanceToEndNode(grid, neighbour, goal);

        if (!openSet.contains(neighbour)) {
          openSet.add(neighbour);
        }
      }
    }
  }

  return -1;
}

int distanceToEndNode(Grid grid, Point<int> n, Point<int> end) {
  return (n - end).magnitude.round();
}
