import 'dart:io';

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

class LineInfo {
  String? rawLine;
  List<(int, List<int>)>? numsInLineInfo;

  RegExp numRegex = RegExp(r"(\d+)");

  LineInfo(String line) {
    rawLine = line;
    numsInLineInfo = getNumsInLine(line);
  }
  List<(int, List<int>)> getNumsInLine(String line) {
    var matches = numRegex.allMatches(line);
    var returnList = matches.map((match) {
      int num = int.parse(match.group(0)!);
      List<int> pos = [for (var i = match.start; i < match.end; i += 1) i];
      return (num, pos);
    }).toList();
    return returnList;
  }
}

class MachineSchema {
  List<LineInfo>? _lines;
  MachineSchema({String filePath = "lib/testInput.txt"}) {
    final fileInput = getFileContents(filePath);
    _lines = [];
    for (String line in fileInput) {
      _lines?.add(LineInfo(line));
    }
  }
  List<LineInfo> get lines => _lines!;
}
