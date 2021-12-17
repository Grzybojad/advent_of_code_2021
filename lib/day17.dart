import 'input_reader.dart';

int part1() {
  var input = readAsString('input/day17_input.txt');

  Bounds target = Bounds.fromInput(input);

  int velX = 0;

  for (int i = 1; i <= 10000; i++) {
    int sumOfI = sumOfN(i);
    if (sumOfI >= target.minX) {
      if (sumOfI > target.maxX) {
        print("FAILED TO FIND VEL X");
      } else {
        velX = i;
      }
      break;
    }
  }

  int velY = -1;

  for (int i = velX; i <= 10000; i++) {
    if (willProbeHitTarget(target, velX, i)) {
      velY = i;
    }
  }

  print("vel: $velX, $velY");

  return maxHeightOfShot(velY);
}

bool willProbeHitTarget(Bounds target, int velX, int velY) {
  int x = 0;
  int y = 0;

  while (velY > 0 || y > target.minY) {
    x += velX;
    y += velY;
    if (velX != 0) velX += velX > 0 ? -1 : 1;
    velY--;

    if (target.containsPoint(x, y)) {
      return true;
    }
  }

  return false;
}

int maxHeightOfShot(int velY) {
  int y = 0;

  while (velY > 0) {
    y += velY;
    velY--;
  }

  return y;
}

class Bounds {
  int minX = 0;
  int maxX = 0;
  int minY = 0;
  int maxY = 0;

  Bounds(this.minX, this.maxX, this.minY, this.maxY);

  Bounds.fromInput(String input) {
    var data = input.split(": ")[1];
    var splitData = data.split(", ");
    var xData = splitData[0].split("=")[1].split("..");
    var yData = splitData[1].split("=")[1].split("..");

    minX = int.parse(xData[0]);
    maxX = int.parse(xData[1]);
    minY = int.parse(yData[0]);
    maxY = int.parse(yData[1]);
  }

  bool containsPoint(int x, int y) {
    return x <= maxX && x >= minX && y <= maxY && y >= minY;
  }

  void printBounds() {
    print("x: $minX..$maxX");
    print("y: $minY..$maxY");
  }
}

int sumOfN(int n) {
  return (n + 1) * n ~/ 2;
}
