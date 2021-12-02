import 'input_reader.dart';

int part1() {
  var lines = readLines('input/day02_input.txt');

  var depth = 0;
  var horizontal = 0;

  for (var line in lines) {
    var splitLine = line.split(" ");
    var direction = splitLine[0];
    var value = int.parse(splitLine[1]);

    switch (direction) {
      case "down":
        depth += value;
        break;
      case "up":
        depth -= value;
        break;
      case "forward":
        horizontal += value;
        break;
    }
  }

  return depth * horizontal;
}
