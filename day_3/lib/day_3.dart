import 'dart:io';

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

class LineInfo {
  int? lineNum;
  List<(int pos, List<int> numsInLine, bool adjacency)>? numsInLineInfo;
  List<(String, int)>? symsInLineInfo;

  RegExp numRegex = RegExp(r"(\d+)");
  RegExp symsRegex = RegExp(r"[^\w\d\.]");

  LineInfo(String line, int? lineNumber) {
    lineNum = lineNumber;
    numsInLineInfo = getNumsInLine(line);
    symsInLineInfo = getSymsInLine(line);
  }

  @override
  String toString() {
    String stringifiedObj = numsInLineInfo!.map((el) {
      return "${el.$1}: ${el.$2[0]}";
    }).toString();
    if (lineNum != null) {
      return "Line #$lineNum contains $stringifiedObj";
    } else {
      return "Empty line";
    }
  }

  List<(int, List<int>, bool)> getNumsInLine(String line) {
    var matches = numRegex.allMatches(line);
    var returnList = matches.map((match) {
      int num = int.parse(match.group(0)!);
      List<int> pos = [for (var i = match.start; i < match.end; i += 1) i];
      return (num, pos, false);
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
    testLinesForAdjacency(_lines!);
  }
  List<LineInfo> get lines => _lines!;

  void testLinesForAdjacency(List<LineInfo> lines) {
    lines.map((currentLine) {
      var prevLine = getLineByLineNum(currentLine.lineNum! - 1);
      var nextLine = getLineByLineNum(currentLine.lineNum! + 1);
    });
  }

  LineInfo getLineByLineNum(int lineNum) {
    try {
      return lines[lineNum];
    } on RangeError {
      return LineInfo("", null);
    }
  }
}
