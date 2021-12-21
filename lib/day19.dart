import 'input_reader.dart';
import 'package:vector_math/vector_math.dart';

int part1() {
  var input = readAsString('input/day19_input.txt');

  var scanners = inputToScanners(input);

  List<Vector3> knownBeaconPositions = scanners[0];

  // take the first point of each set, calc their offset
  // check if at least 12 points match
  // if not try all the other possible rotations

  var scannerToMatch = scanners[1];
  for (var knownBeacon in knownBeaconPositions) {
    for (var beaconToMatch in scannerToMatch) {
      var offset = knownBeacon - beaconToMatch;
      print(offset);
      if (offset.x.abs() > 2000 || offset.y.abs() > 2000) continue;

      int matches = 0;
      for (var beacon in scannerToMatch) {
        if (knownBeacon - beacon == offset) {
          matches++;

          if (matches == 12) {
            print("Found match! $beacon");
            break;
          }
        }
      }

      if (matches == 12) {
        print("Found 12 matches!");
      }
    }
  }

  return 0;
}

List<List<Vector3>> inputToScanners(String input) {
  return inputToScannersLines(input)
      .map((e) => e.map((e2) => lineToVector3(e2)).toList())
      .toList();
}

Vector3 lineToVector3(String line) {
  var a = line.split(",");
  return Vector3(double.parse(a[0]), double.parse(a[1]), double.parse(a[2]));
}

List<List<String>> inputToScannersLines(String input) {
  return input
      .split("\r\n\r\n")
      .map((e) => e.split("\r\n").skip(1).toList())
      .toList();
}

void printScanners(List<List<Vector3>> scanners) {
  for (int i = 0; i < scanners.length; ++i) {
    print("\nScanner $i:");
    scanners[i].forEach(print);
  }
}
