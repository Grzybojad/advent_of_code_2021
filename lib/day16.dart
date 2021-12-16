import 'input_reader.dart';

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

void exectuteInstuction() {
  int verStart = index;
  int verEnd = verStart + 3;
  int typeStart = verEnd;
  int typeEnd = typeStart + 3;
  var version = int.parse(binary.substring(verStart, verEnd), radix: 2);
  var typeId = int.parse(binary.substring(typeStart, typeEnd), radix: 2);
  totalVersion += version;

  index = typeEnd;
  if (typeId == literalValueId) {
    int literalValue = readLiteralValue();
  } else {
    executeOperatorInstruction();
  }
}

void executeOperatorInstruction() {
  var lengthTypeId = binary[index];

  if (lengthTypeId == '0') {
    int groupStart = index + 1;
    int groupEnd = groupStart + 15;
    int totalLength =
        int.parse(binary.substring(groupStart, groupEnd), radix: 2);

    index = groupEnd;
    while (index < groupEnd + totalLength) {
      exectuteInstuction();
    }
  } else {
    int groupStart = index + 1;
    int groupEnd = groupStart + 11;
    int subPackets =
        int.parse(binary.substring(groupStart, groupEnd), radix: 2);

    index = groupEnd;
    for (int i = 0; i < subPackets; i++) {
      exectuteInstuction();
    }
  }
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
