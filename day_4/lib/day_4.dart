import 'dart:io';
import 'dart:math';

class Card {
  int? cardNum;
  List<int> numbersOnCard = [];
  List<int> numbersIHave = [];

  List<int> winningNumbers = [];
  int points = 0;

  RegExp numRegex = RegExp(r"(\d{1,2})");

  Card(String cardString) {
    parseCardString(cardString);
    getWinningNumbers();
    calculatePoints();
  }

  void parseCardString(String cardString) {
    List<String> splitOnColon = cardString.split(":");
    List<String> splitOnBracket = splitOnColon[1].split("|");

    cardNum = int.parse(splitOnColon[0].split(" ")[1]);
    numbersOnCard = parseNumberString(splitOnBracket[0]);
    numbersIHave = parseNumberString(splitOnBracket[1]);
  }

  List<int> parseNumberString(String numbersString) {
    List<int> returnInts = [];

    var matches = numRegex.allMatches(numbersString);
    for (var match in matches) {
      returnInts.add(int.parse(match.group(0)!));
    }
    return returnInts;
  }

  void getWinningNumbers() {
    for (int numIHave in numbersIHave) {
      if (numbersOnCard.contains(numIHave)) {
        winningNumbers.add(numIHave);
      }
    }
  }

  void calculatePoints() {
    points = pow(2, (winningNumbers.length - 1)).toInt();
  }
}

class Game {
  List<Card> cards = [];
  int totalPoints = 0;

  Game(String filePath) {
    final fileInput = getFileContents(filePath);
    getCards(fileInput);
    calculateTotalPoints();
  }
  void getCards(List<String> fileInput) {
    for (String card in fileInput) {
      cards.add(Card(card));
    }
  }

  void calculateTotalPoints() {
    for (Card card in cards) {
      totalPoints += card.points;
    }
  }

  static List<String> getFileContents(String path) {
    File input = File(path);
    List<String> contents = input.readAsLinesSync();
    return contents;
  }
}

