class Card {
  int? cardNum;
  List<int>? winningNumbers = [];
  List<int>? numbersIHave = [];

  RegExp numRegex = RegExp(r"(\d{1,2})");

  Card(String cardString) {
    var parsedInfo = parseCardString(cardString);
    cardNum = parsedInfo.cardNum;
    winningNumbers = parsedInfo.winningNumbers;
    numbersIHave = parsedInfo.numbersIHave;
  }

  ({int cardNum, List<int> winningNumbers, List<int> numbersIHave})
      parseCardString(String cardString) {
    List<String> splitOnColon = cardString.split(":");
    int cardNum = int.parse(splitOnColon[0].split(" ")[1]);

    List<String> splitOnBracket = splitOnColon[1].split("|");
    List<int> winningNumbers = parseNumberString(splitOnBracket[0]);
    List<int> numbersIHave = parseNumberString(splitOnBracket[1]);

    return (
      cardNum: cardNum,
      winningNumbers: winningNumbers,
      numbersIHave: numbersIHave
    );
  }

  List<int> parseNumberString(String numbersString) {
    List<int> returnInts = [];

    var matches = numRegex.allMatches(numbersString);
    for (var match in matches) {
      returnInts.add(int.parse(match.group(0)!));
    }
    return returnInts;
  }
}

