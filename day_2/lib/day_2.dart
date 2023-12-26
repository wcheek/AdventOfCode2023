class Game {
  int? _id;
  bool? _possible;
  Game(String gameInfo) {
    _id = 0;
    _possible = false;
  }
  int get id => _id!;
  bool get possible => _possible!;
  static (int, List<(String, int)>) parseGameInfo(gameInfo) {
    /// Outputs a record of (gameID, [(color, numCubes)]
    throw Error();
  }
}

