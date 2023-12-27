import 'dart:io';

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

class LineInfo {
  int? lineNum;
  List<(int, List<int>)>? numsInLineInfo;
  List<(String, int)>? symsInLineInfo;

  RegExp numRegex = RegExp(r"(\d+)");
  // RegExp symsRegex = RegExp(r"[\+\@\$\-\=\*\/\#\&\%]");
  RegExp symsRegex = RegExp(r"[^\w\d\.]");

  LineInfo(String line, int lineNum) {
    lineNum = lineNum;
    numsInLineInfo = getNumsInLine(line);
    symsInLineInfo = getSymsInLine(line);
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

  List<(String, int)> getSymsInLine(String line) {
    var matches = symsRegex.allMatches(line);
    var returnList = matches.map((match) {
      String sym = match.group(0)!;
      int pos = match.start;
      return (sym, pos);
    }).toList();
    return returnList;
  }
}

class MachineSchema {
  List<LineInfo>? _lines;
  MachineSchema({String filePath = "lib/testInput.txt"}) {
    final fileInput = getFileContents(filePath);
    _lines = [];
    fileInput.asMap().forEach((ind, line) {
      _lines?.add(LineInfo(line, ind));
    });
  }
  List<LineInfo> get lines => _lines!;
}
