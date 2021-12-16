import 'input_reader.dart';
import 'dart:math';

const int literalValueId = 4;
int index = 0;
String binary = "";
int totalVersion = 0;

int part1() {
  var input = readAsString('input/day16_input.txt');
  binary = hexToBinaryString(input);
  index = 0;

  while (index < binary.length - 7) {
    exectuteInstuction();
  }

  return totalVersion;
}

int part2() {
  var input = readAsString('input/day16_input.txt');
  binary = hexToBinaryString(input);
  index = 0;

  int result = exectuteInstuction();

  return result;
}

int exectuteInstuction() {
  int verStart = index;
  int verEnd = verStart + 3;
  int typeStart = verEnd;
  int typeEnd = typeStart + 3;
  var version = int.parse(binary.substring(verStart, verEnd), radix: 2);
  var typeId = int.parse(binary.substring(typeStart, typeEnd), radix: 2);
  totalVersion += version;

  index = typeEnd;
  if (typeId == literalValueId) {
    return readLiteralValue();
  } else {
    return executeOperatorInstruction(typeId);
  }
}

int executeOperatorInstruction(int typeId) {
  var lengthTypeId = binary[index];
  List<int> results = [];

  if (lengthTypeId == '0') {
    int groupStart = index + 1;
    int groupEnd = groupStart + 15;
    int totalLength =
        int.parse(binary.substring(groupStart, groupEnd), radix: 2);

    index = groupEnd;
    while (index < groupEnd + totalLength) {
      results.add(exectuteInstuction());
    }
  } else {
    int groupStart = index + 1;
    int groupEnd = groupStart + 11;
    int subPackets =
        int.parse(binary.substring(groupStart, groupEnd), radix: 2);

    index = groupEnd;
    for (int i = 0; i < subPackets; i++) {
      results.add(exectuteInstuction());
    }
  }

  switch (typeId) {
    case 0:
      return results.reduce((a, b) => a + b);
    case 1:
      return results.reduce((a, b) => a * b);
    case 2:
      return results.reduce(min);
    case 3:
      return results.reduce(max);
    case 5:
      return results.reduce((a, b) => a > b ? 1 : 0);
    case 6:
      return results.reduce((a, b) => a < b ? 1 : 0);
    case 7:
      return results.reduce((a, b) => a == b ? 1 : 0);
  }

  return -1;
}

int readLiteralValue() {
  var valueString = "";

  int lastGroupPrefix = -1;
  do {
    int groupPrefix = index;
    int groupStart = groupPrefix + 1;
    int groupEnd = groupStart + 4;
    valueString += binary.substring(groupStart, groupEnd);

    index = groupEnd;
    lastGroupPrefix = groupPrefix;
  } while (binary[lastGroupPrefix] != '0');

  int literalValue = int.parse(valueString, radix: 2);

  return literalValue;
}

String hexToBinaryString(String hexString) {
  return hexString
      .split('')
      .map((e) => int.parse(e, radix: 16).toRadixString(2).padLeft(4, '0'))
      .join();
}
