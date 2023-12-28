import 'package:day_4/day_4.dart';
import 'package:test/test.dart';

void testCardMethods() {
  String testInputCard = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53";
  late Card card;
  setUp(() {
    card = Card(testInputCard);
  });

  test("Correct parsing of numbers strings", () {
    expect(card.parseNumberString("41 48 83 86 17 "), [41, 48, 83, 86, 17]);
    expect(card.parseNumberString(testInputCard.split("|")[1]),
        [83, 86, 6, 31, 17, 9, 48, 53]);
  });

  test("Correct parsing of card input string", () {
    expect(card.cardNum, equals(1));
    expect(card.numbersOnCard, equals([41, 48, 83, 86, 17]));
    expect(card.numbersIHave, equals([83, 86, 6, 31, 17, 9, 48, 53]));
  }, skip: false);

  test("Correct winning numbers", () {
    expect(card.winningNumbers, equals([83, 86, 17, 48]));
  });

  test("Correct # points", () {
    expect(card.points, equals(8));
  });
}

void testGameMethods() {
  late Game game;
  setUp(() {
    game = Game("inputs/testInput.txt");
  });

  test("Game has correct num cards", () {
    expect(game.cards.length, equals(6));
  });

  test("Getting total points", () {
    expect(game.totalPoints, equals(13));
  });
}

void main() {
  group("part 1 cardMethods", testCardMethods);
  group("part 1 gameMethods", testGameMethods);
}
