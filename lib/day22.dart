import 'dart:collection';
import 'dart:math';
import 'input_reader.dart';

int part1() {
  var input = readLines('input/day22_input.txt');

  var steps = input.map((e) => RebootStep.fromString(e));

  HashSet<Point3D> turnedOnCubes = HashSet();

  Cuboid region = Cuboid.fromString("x=-50..50,y=-50..50,z=-50..50");

  for (var step in steps) {
    if (!region.intersectsCuboid(step.cuboid)) continue;

    var cubesInStep = step.cuboid.getPointsInside();
    if (step.on) {
      turnedOnCubes.addAll(cubesInStep);
    } else {
      turnedOnCubes.removeAll(cubesInStep);
    }
  }

  return turnedOnCubes.length;
}

int part2() {
  var input = readLines('input/day22_input.txt');
  var steps = input.map((e) => RebootStep.fromString(e));

  List<Cuboid> positiveSections = [];
  List<Cuboid> negativeSections = [];

  for (var step in steps) {
    bool isPositiveIntersection =
        positiveSections.any((c) => step.cuboid.intersectsCuboid(c));
    bool isNegativeIntersection =
        negativeSections.any((c) => step.cuboid.intersectsCuboid(c));

    Iterable<Cuboid> negativeToAdd = [];

    if (isPositiveIntersection) {
      var intersections = positiveSections
          .where((c) => step.cuboid.intersectsCuboid(c))
          .map((e) => step.cuboid.intersectionCuboid(e))
          .toList();

      print("Added ${intersections.length} negative");
      intersections.forEach(print);
      negativeToAdd = intersections;
    }

    if (step.on) {
      positiveSections.add(step.cuboid);

      if (isNegativeIntersection) {
        var intersections = negativeSections
            .where((c) => step.cuboid.intersectsCuboid(c))
            .map((e) => step.cuboid.intersectionCuboid(e))
            .toList();

        print("Added ${intersections.length} positive");
        intersections.forEach(print);
        positiveSections.addAll(intersections);
      }
    }

    negativeSections.addAll(negativeToAdd);
  }

  negativeSections.map((e) => e.volume()).forEach(print);

  int positiveVolume = positiveSections.isEmpty
      ? 0
      : positiveSections.map((c) => c.volume()).reduce((a, b) => a + b);
  int negativeVolume = negativeSections.isEmpty
      ? 0
      : negativeSections.map((c) => c.volume()).reduce((a, b) => a + b);

  print("positive volume $positiveVolume");
  print("negative volume $negativeVolume");

  return positiveVolume - negativeVolume;
}

class RebootStep {
  bool on = false;
  late Cuboid cuboid;

  RebootStep.fromString(String input) {
    var splitInput = input.split(" ");
    on = splitInput[0] == "on";
    cuboid = Cuboid.fromString(splitInput[1]);
  }
}

class Cuboid {
  int _minX = 0;
  int _maxX = 0;
  int _minY = 0;
  int _maxY = 0;
  int _minZ = 0;
  int _maxZ = 0;

  Cuboid(
      this._minX, this._maxX, this._minY, this._maxY, this._minZ, this._maxZ);

  Cuboid.fromString(String input) {
    var splitInput = input.split(",");
    var xRange = splitInput[0].split("=")[1].split("..");
    var yRange = splitInput[1].split("=")[1].split("..");
    var zRange = splitInput[2].split("=")[1].split("..");

    _minX = int.parse(xRange[0]);
    _maxX = int.parse(xRange[1]);
    _minY = int.parse(yRange[0]);
    _maxY = int.parse(yRange[1]);
    _minZ = int.parse(zRange[0]);
    _maxZ = int.parse(zRange[1]);
  }

  int volume() =>
      (_minX - _maxX).abs() * (_minY - _maxY).abs() * (_minZ - _maxZ).abs();

  bool contains(Point3D point) {
    return point.x >= _minX &&
        point.x <= _maxX &&
        point.y >= _minY &&
        point.y <= _maxY &&
        point.z >= _minZ &&
        point.z <= _maxZ;
  }

  Iterable<Point3D> getPointsInside() {
    List<Point3D> points = [];
    for (int z = _minZ; z <= _maxZ; z++) {
      for (int y = _minY; y <= _maxY; y++) {
        for (int x = _minX; x <= _maxX; x++) {
          points.add(Point3D(x, y, z));
        }
      }
    }
    return points;
  }

  Iterable<Point3D> corners() {
    return [
      Point3D(_minX, _minY, _minZ),
      Point3D(_minX, _minY, _maxZ),
      Point3D(_minX, _maxY, _minZ),
      Point3D(_minX, _maxY, _maxZ),
      Point3D(_maxX, _minY, _minZ),
      Point3D(_maxX, _minY, _maxZ),
      Point3D(_maxX, _maxY, _minZ),
      Point3D(_maxX, _maxY, _maxZ),
    ];
  }

  bool intersectsCuboid(Cuboid other) {
    return other.corners().any((corner) => contains(corner)) ||
        corners().any((corner) => other.contains(corner));
  }

  Cuboid intersectionCuboid(Cuboid other) {
    return Cuboid(
        max(_minX, other._minX),
        min(_maxX, other._maxX),
        max(_minY, other._minY),
        min(_maxY, other._maxY),
        max(_minZ, other._minZ),
        min(_maxZ, other._maxZ));
  }

  @override
  String toString() {
    return "x=$_minX..$_maxX, y=$_minY..$_maxY, z=$_minZ..$_maxZ";
  }
}

class Point3D {
  int x = 0;
  int y = 0;
  int z = 0;

  Point3D(this.x, this.y, this.z);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Point3D && other.x == x && other.y == y && other.z == z;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + x;
    result = 37 * result + y;
    result = 37 * result + z;
    return result;
  }
}
