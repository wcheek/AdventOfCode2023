import 'dart:io';

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

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

Map<String, String> getWordToNumeralMap() {
  Map<String, String> wordToNumeral = {};
  WordNums.values.asMap().forEach(
      (index, wordNum) => wordToNumeral[wordNum.name] = "${index + 1}");
  return wordToNumeral;
}

final wordToNumeral = getWordToNumeralMap();

List<String> getMatches(String line) {
  List<(int, String)> recordOfMatches = [];
  for (var i = 0; i < line.length; i++) {
    var matches = regex.allMatches(line, i);
    for (final Match match in matches) {
      var matchWithPos = (match.start, match.group(0)!);
      if (!recordOfMatches.contains(matchWithPos)) {
        recordOfMatches.add(matchWithPos);
      }
    }
  }
  recordOfMatches.sort((a, b) => a.$1 > b.$1 ? 1 : 0);
  return recordOfMatches.map((el) => el.$2).toList();
}

List<int> getCodedInts(List<String> input) {
  List<int> codedInts = [];
  for (String line in input) {
    final matches = getMatches(line);
    String first = matches[0];
    String last = matches[matches.length - 1];
    first = first.length > 1 ? wordToNumeral[first]! : first;
    last = last.length > 1 ? wordToNumeral[last]! : last;
    final finalInt = int.parse(first + last);
    codedInts.add(finalInt);
  }
  return codedInts;
}
