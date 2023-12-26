enum WordNums {
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
}

String numeralMatch = r"(\d)";
String wordMatch = r"(one|two|three|four|five|six|seven|eight|nine)";
RegExp regex = RegExp("$numeralMatch|$wordMatch");

Map<String, String> getWordToNumeralMap() {
  Map<String, String> wordToNumeral = {};
  WordNums.values.asMap().forEach(
      (index, wordNum) => wordToNumeral[wordNum.name] = "${index + 1}");
  return wordToNumeral;
}

List<int> getCodedInts(List<String> input) {
  var wordToNumeral = getWordToNumeralMap();
  List<int> codedInts = [];
  for (String line in input) {
    final matches =
        regex.allMatches(line).map((match) => match.group(0)).toList();
    if (matches != []) {
      String first = matches[0] ?? "";
      String last = matches[matches.length - 1] ?? "";
      first = first.length > 1 ? wordToNumeral[first]! : first;
      last = last.length > 1 ? wordToNumeral[last]! : last;
      codedInts.add(int.parse(first + last));
    }
  }
  return codedInts;
}
