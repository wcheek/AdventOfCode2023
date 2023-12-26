import 'package:collection/collection.dart';

class Game {
  (int, Map<String, List<int>>)? _gameInput;
  bool? _possible;

  Game(String gameInfo, List<(String, int)> gameDeterminer) {
    _gameInput = parseGameInfo(gameInfo);
    _possible = decideIfPossible(gameDeterminer);
  }

  int get id => _gameInput!.$1;
  bool get possible => _possible!;
  (int, Map<String, List<int>>) get game => _gameInput!;

  static (int, Map<String, List<int>>) parseGameInfo(String gameInfo) {
    /// Outputs a record of (gameID, [(color, numCubes)]
    // Eg: Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    // (1, [("red", 4), ("green", 6), ("blue", 9)])
    List<String> gameInfoPieces = getGameInfoPieces(gameInfo);
    int id = int.parse(gameInfoPieces[0].split(" ")[1]);
    Map<String, List<int>> parsedGameInfoPieces =
        parseGameInfoPieces(gameInfoPieces[1]);
    return (id, parsedGameInfoPieces);
  }

  static List<String> getGameInfoPieces(String gameInfo) {
    /// Return ["Game 1", "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]
    return gameInfo.split(":").map((el) => el.trim()).toList();
  }

  static Map<String, List<int>> parseGameInfoPieces(String gameInfoColorNums) {
    /// Input looks like "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
    // I want [("red", 4), ("green", 6), ("blue", 9)]
    List<int> redScores = [];
    List<int> greenScores = [];
    List<int> blueScores = [];
    List<String> gameSets =
        gameInfoColorNums.split(";").map((el) => el.trim()).toList();
    // ["3 blue, 4 red", "1 red, 2 green, 6 blue", "2 green"]
    for (String gameSet in gameSets) {
      gameSet
          // "3 blue, 4 red"
          .split(",")
          .map((el) => el.trim())
          // ["3 blue", "4 red"]
          .forEach((el) {
        // "3 blue"
        List<String> split = el.split(" ");
        String color = split[1];
        int score = int.parse(split[0]);
        switch (color) {
          case "red":
            redScores.add(score);
            break;
          case "green":
            greenScores.add(score);
            break;
          case "blue":
            blueScores.add(score);
            break;
        }
      });
    }
    return {"red": redScores, "green": greenScores, "blue": blueScores};
  }

  bool decideIfPossible(List<(String, int)> gameDeterminer) {
    for ((String, int) colorNum in gameDeterminer) {
      if (_gameInput!.$2[colorNum.$1]!.max > colorNum.$2) {
        return false;
      }
    }
    return true;
  }
}

