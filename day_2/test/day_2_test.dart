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
  String testString = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";

  test("Game Info pieces parsed currectly", () {
    expect(Game.getGameInfoPieces(testString),
        ["Game 1", "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]);
  });
  final game = Game(testString, testDeterminer);
  test('Parse game input', () {
    expect(game.game.$2, {"red": 5, "green": 4, "blue": 9});
  }, skip: false);
  test("Check ID", () {
    expect(game.id, 1);
  }, skip: false);

  test("Check not possible", () {
    expect(game.possible, true);
  });
}

void testMultipleObjects() {
  List<String> testStrings = getFileContents("lib/testInput.txt");
  List<Game> games = [];
  for (String testString in testStrings) {
    games.add(Game(testString, testDeterminer));
  }
  test("Game ids are unique", () {
    List<int> gameIDS = games.map((game) {
      return game.id;
    }).toList();
    expect(gameIDS, [1, 2, 3, 4, 5]);
  });
  test("Games correctly fail", () {
    List<bool> gameFailures = games.map((game) {
      return game.possible;
    }).toList();
    expect(gameFailures, [true, true, false, false, true]);
  });
  test("Game scores correct", () {
    List<int> gameIDS = games.map((game) {
      return game.possible ? game.id : 0;
    }).toList();
    expect(gameIDS.sum, 8);
  });
}

void main() {
  testClassMethods();
  testMultipleObjects();
}
