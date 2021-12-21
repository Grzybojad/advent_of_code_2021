import 'input_reader.dart';

int part1() {
  var input = readLines('input/day21_input.txt');

  var player1 = Player(int.parse(input[0].split(" ").last));
  var player2 = Player(int.parse(input[1].split(" ").last));

  const int pointToWin = 1000;

  bool gameOver() =>
      player1.points >= pointToWin || player2.points >= pointToWin;

  var currentPlayer = player1;
  int rollCount = 0;
  while (!gameOver()) {
    var totalRoll = (rollCount + 2) * 3;
    rollCount += 3;

    currentPlayer.moveBySpaces(totalRoll);

    currentPlayer = currentPlayer == player1 ? player2 : player1;
  }

  var loser = currentPlayer;

  print("${loser.points} * $rollCount");

  return loser.points * rollCount;
}

class Player {
  int pos = 0;
  int points = 0;

  Player(this.pos);

  void printValues() {
    print("pos: $pos, points: $points");
  }

  void moveBySpaces(int spaces) {
    pos += spaces;
    pos = (pos - 1) % 10 + 1;
    points += pos;
  }
}
