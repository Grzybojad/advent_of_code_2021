import 'dart:collection';
import 'input_reader.dart';

int part1() {
  var input = readLines('input/day21_input.txt');

  var player1 = Player(pos: int.parse(input[0].split(" ").last));
  var player2 = Player(pos: int.parse(input[1].split(" ").last));

  var game = Game(player1, player2);

  const int pointToWin = 1000;

  // bool firstPlayer = true;
  int rollCount = 0;
  while (!game.gameOver(pointToWin)) {
    var totalRoll = (rollCount + 2) * 3;
    rollCount += 3;

    game = game.gameAfterMove(totalRoll);

    // firstPlayer = !firstPlayer;
  }

  return game.getLoser().points * rollCount;
}

int part2() {
  var input = readLines('input/day21_input.txt');

  var player1 = Player(pos: int.parse(input[0].split(" ").last));
  var player2 = Player(pos: int.parse(input[1].split(" ").last));

  HashMap<Game, int> universes = HashMap();
  universes[Game(player1, player2)] = 1;

  const int pointsToWin = 21;

  while (universes.keys.any((game) => !game.gameOver(pointsToWin))) {
    var unfinishedGamesKeys =
        universes.keys.where((g) => !g.gameOver(pointsToWin)).toList();
    for (var game in unfinishedGamesKeys) {
      int count = universes[game]!;
      universes.remove(game);

      HashMap<Game, int> gamesAfterRolls = HashMap();
      for (int r1 = 1; r1 <= 3; r1++) {
        for (int r2 = 1; r2 <= 3; r2++) {
          for (int r3 = 1; r3 <= 3; r3++) {
            var result = game.gameAfterMove(r1 + r2 + r3);
            gamesAfterRolls[result] = (gamesAfterRolls[result] ?? 0) + 1;
          }
        }
      }

      for (var newGame in gamesAfterRolls.keys) {
        int copies = gamesAfterRolls[newGame]!;
        universes[newGame] = count * copies + (universes[newGame] ?? 0);
      }
    }
    // print("\ngames ${universes.values.reduce((a, b) => a + b)}:");
    // universes.forEach((key, value) {
    //   if (!key.gameOver(pointsToWin)) {
    //     print("$key: $value");
    //   }
    // });
  }

  var totalWins = universes.values.reduce((a, b) => a + b);

  var p1Wins = 0;
  for (var game in universes.keys.where((g) => g.isPlayer1Winning())) {
    p1Wins += universes[game]!;
  }
  var p2Wins = totalWins - p1Wins;

  print("total wins: $totalWins");
  print("p1 wins:    $p1Wins");
  print("p2 wins:    $p2Wins");

  return p1Wins > p2Wins ? p1Wins : p2Wins;
}

class Game {
  Player player1;
  Player player2;
  bool player1Turn = false;

  Game(this.player1, this.player2, {this.player1Turn = true});

  Game gameAfterMove(int spaces) {
    var currentPlayer = player1Turn ? player1 : player2;
    int pos = currentPlayer.pos;
    int points = currentPlayer.points;

    pos += spaces;
    pos = (pos - 1) % 10 + 1;
    points += pos;

    var newPlayer = Player(pos: pos, points: points);
    var newGamePlayer1 = player1Turn ? newPlayer : Player.copy(player1);
    var newGamePlayer2 = !player1Turn ? newPlayer : Player.copy(player2);

    return Game(newGamePlayer1, newGamePlayer2, player1Turn: !player1Turn);
  }

  bool gameOver(int pointToWin) =>
      player1.points >= pointToWin || player2.points >= pointToWin;

  bool isPlayer1Winning() => player1.points > player2.points;

  Player getLoser() => isPlayer1Winning() ? player2 : player1;

  @override
  String toString() {
    return "points: (${player1.points}, ${player2.points}), pos: (${player1.pos}, ${player2.pos})";
  }

  void printValues() {
    print(toString());
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Game &&
        player1 == other.player1 &&
        player2 == other.player2 &&
        player1Turn == player1Turn;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + player1.hashCode;
    result = 37 * result + player2.hashCode;
    result = 37 * result + (player1Turn ? 1 : 0);
    return result;
  }
}

class Player {
  int pos = 0;
  int points = 0;

  Player({this.pos = 0, this.points = 0});

  Player.copy(Player player) {
    pos = player.pos;
    points = player.points;
  }

  void printValues() {
    print("pos: $pos, points: $points");
  }

  void moveBySpaces(int spaces) {
    pos += spaces;
    pos = (pos - 1) % 10 + 1;
    points += pos;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is Player && pos == other.pos && points == other.points;
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + pos;
    result = 37 * result + points;
    return result;
  }
}
