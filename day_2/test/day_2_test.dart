import 'dart:io';
import 'package:day_2/day_2.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

List<(String, int)> testDeterminer = [("red", 12), ("green", 13), ("blue", 14)];

void testClassMethods() {
  //String testString = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
  String testString2 =
      "Game 33: 6 blue, 16 red, 9 green; 5 red, 7 blue, 13 green; 1 green, 9 blue, 1 red; 4 green, 9 blue, 17 red; 2 green, 10 red, 13 blue; 9 red, 1 blue, 14 green";

  test("Game Info pieces parsed currectly", () {
    expect(
        Game.getGameInfoPieces(testString2),
        //["Game 1", "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]);
        [
          "Game 33",
          "6 blue, 16 red, 9 green; 5 red, 7 blue, 13 green; 1 green, 9 blue, 1 red; 4 green, 9 blue, 17 red; 2 green, 10 red, 13 blue; 9 red, 1 blue, 14 green"
        ]);
  });
  final game = Game(testString2, testDeterminer);
  test('Parse game input', () {
    //expect(game.game.$2, {"red": 5, "green": 4, "blue": 9});
    expect(game.game.$2, {"red": 58, "green": 43, "blue": 45});
  }, skip: false);
  test("Check ID", () {
    expect(game.id, 33);
  }, skip: false);

  test("Check if possible", () {
    expect(game.possible, false);
  });
}

void testMultipleObjects() {
  List<String> testStrings = getFileContents("lib/input.txt");
  List<Game> games = [];
  for (String testString in testStrings) {
    games.add(Game(testString, testDeterminer));
  }
  test("Game ids are unique", () {
    List<int> gameIDS = games.map((game) {
      return game.id;
    }).toList();
    expect(gameIDS, [for (var i = 1; i <= 100; i += 1) i]);
  }, skip: false);
  test("Games correctly fail", () {
    List<bool> gameFailures = games.map((game) {
      return game.possible;
    }).toList();
    expect(gameFailures, [true, true, false, false, true]);
  }, skip: true);
  test("All games have result", () {
    List<bool> gameResults = games.map((game) {
      return game.possible;
    }).toList();
    expect(gameResults.length, gameResults.whereNotNull().length);
  });
  test("Game scores correct", () {
    List<int> gameIDS = games.map((game) {
      return game.possible ? game.id : 0;
    }).toList();
    expect(gameIDS.sum, 8);
  }, skip: true);
}

void main() {
  testClassMethods();
  testMultipleObjects();
}
