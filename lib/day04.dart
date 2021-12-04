import 'input_reader.dart';

int part1() {
  var input = readAsString('input/day04_input.txt');
  var splitInput = input.split("\r\n\r\n");

  var numbersToDraw = splitInput[0].split(",");
  var boardsInput = splitInput.skip(1).toList();

  var boards = boardsInput.map((boardInput) => Board(boardInput)).toList();

  Board? winningBoard;
  String lastDrawn = "";
  for (var drawnNumber in numbersToDraw) {
    lastDrawn = drawnNumber;
    for (Board board in boards) {
      bool markedNumber = board.tryToMarkNumber(drawnNumber);
      if (markedNumber && board.isBoardAWinner()) {
        winningBoard = board;
        break;
      }
    }
    if (winningBoard != null) {
      break;
    }
  }

  int lastDrawnNumber = int.parse(lastDrawn);

  return winningBoard!.sumOfUnmarkedNumbers() * lastDrawnNumber;
}

class Board {
  List<bool> completedNumbers = [];
  Map<String, int> numbersToIndexMap = {};
  List<List<String>> numberLines = [];
  String input = "";

  static const int width = 5;
  static const int height = 5;

  Board(String boardInput) {
    input = boardInput;
    var lines = boardInput.split("\n");

    var re = RegExp(r"\s+");
    numberLines = lines.map((e) => e.split(re)).toList();

    for (var numbers in numberLines) {
      numbers.removeWhere((s) => s.contains(" ") || s.isEmpty);
    }

    completedNumbers = List.filled(width * height, false, growable: false);

    for (int y = 0; y < height; ++y) {
      for (int x = 0; x < width; ++x) {
        numbersToIndexMap[numberLines[y][x]] = y * width + x;
      }
    }
  }

  bool tryToMarkNumber(String number) {
    int? index = numbersToIndexMap[number];

    if (index != null) {
      completedNumbers[index] = true;
      return true;
    }

    return false;
  }

  bool isBoardAWinner() {
    if (_amountOfCompletedNumbers() < width) return false;

    for (int rowIndex = 0; rowIndex < height; ++rowIndex) {
      if (_isRowComplete(rowIndex)) {
        return true;
      }
    }

    for (int colIndex = 0; colIndex < height; ++colIndex) {
      if (_isColumnComplete(colIndex)) {
        return true;
      }
    }

    return false;
  }

  int sumOfUnmarkedNumbers() {
    var sum = 0;

    for (int y = 0; y < height; ++y) {
      for (int x = 0; x < width; ++x) {
        int index = y * width + x;
        if (!completedNumbers[index]) {
          sum += int.parse(numberLines[y][x]);
        }
      }
    }

    return sum;
  }

  int _amountOfCompletedNumbers() => completedNumbers.where((e) => e).length;

  bool _isRowComplete(int rowIndex) {
    int lineRangeStart = rowIndex * width;
    int lineRangeEnd = (rowIndex + 1) * width;
    return !completedNumbers
        .getRange(lineRangeStart, lineRangeEnd)
        .any((e) => !e);
  }

  bool _isColumnComplete(int columnIndex) {
    for (int y = 0; y < height; ++y) {
      int index = y * width + columnIndex;
      if (!completedNumbers[index]) {
        return false;
      }
    }

    return true;
  }
}
