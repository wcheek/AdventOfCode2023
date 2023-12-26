import 'package:day_2/day_2.dart';
import 'package:test/test.dart';

void main() {
  String testString = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green";
  test("Game Info pieces parsed currectly", () {
    expect(Game.getGameInfoPieces(testString),
        ["Game 1", "3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"]);
  });
  final game = Game(testString);
  test('Parse game input', () {
    expect(game.game.$2, [("red", 5), ("green", 4), ("blue", 9)]);
  }, skip: false);
  test("Check ID", () {
    expect(game.id, 1);
  }, skip: false);
}
