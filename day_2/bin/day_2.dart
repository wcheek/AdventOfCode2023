import 'package:day_2/day_2.dart';
import 'dart:io';
import 'package:collection/collection.dart';

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

List<(String, int)> determiner = [("red", 12), ("green", 13), ("blue", 14)];

void main() {
  List<String> strings = getFileContents("lib/input.txt");
  List<Game> games = [];
  for (String string in strings) {
    games.add(Game(string, determiner));
  }
  List<int> gameIDS = games.map((game) {
    return game.possible ? game.id : 0;
  }).toList();
  List<int> gamePowers = games.map((game) {
    return game.minCubePower;
  }).toList();
  print(gameIDS);
  print(gamePowers.sum);
}
