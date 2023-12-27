import 'dart:io';

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

class LineInfo {
  String? rawLine;
  List<int>? numsInLine;

  RegExp numRegex = RegExp(r"(\d+)");

  LineInfo(String line) {
    rawLine = line;
    numsInLine = getNumsInLine(line);
  }
  List<int> getNumsInLine(String line) {
    return numRegex
        .allMatches(line)
        .map((match) => int.parse(match.group(0)!))
        .toList();
  }
}

class MachineSchema {
  MachineSchema({String filePath = "lib/testInput.txt"}) {
    final fileInput = getFileContents(filePath);
    List<LineInfo> lines = [];
    for (String line in fileInput) {
      lines.add(LineInfo(line));
    }
  }
}
