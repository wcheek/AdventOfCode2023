import 'dart:io';

List<String> getFileContents(String path) {
  File input = File(path);
  List<String> contents = input.readAsLinesSync();
  return contents;
}

class NumberInfo {
  int? number;
  List<int>? numIndices;
  bool? adjacentToSymbol;

  NumberInfo(int inputNumber, List<int> indexRange) {
    number = inputNumber;
    numIndices = indexRange;
    adjacentToSymbol = false;
  }
}

class LineInfo {
  int? lineNum;
  List<NumberInfo>? numsInLineInfo;
  List<(String, int)>? symsInLineInfo;
  Set<int>? symPositions;

  RegExp numRegex = RegExp(r"(\d+)");
  RegExp symsRegex = RegExp(r"[^\w\d\.]");

  LineInfo(String line, int? lineNumber) {
    lineNum = lineNumber;
    numsInLineInfo = getNumsInLine(line);
    symsInLineInfo = getSymsInLine(line);
    symPositions = symsInLineInfo!.map((symInfo) => symInfo.$2).toSet();
  }

  @override
  String toString() {
    String stringifiedObj = numsInLineInfo!.map((el) {
      return "${el.number}: ${el.numIndices![0]}";
    }).toString();
    if (lineNum != null) {
      return "Line #$lineNum contains $stringifiedObj";
    } else {
      return "Empty line";
    }
  }

  List<NumberInfo> getNumsInLine(String line) {
    var matches = numRegex.allMatches(line);
    List<NumberInfo>? returnList = [];
    for (var match in matches) {
      int num = int.parse(match.group(0)!);
      List<int> pos = [for (var i = match.start; i < match.end; i += 1) i];
      returnList.add(NumberInfo(num, pos));
    }

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
      currentLine.numsInLineInfo!.map((numberInfo) {
        List<int> positions = numberInfo.numIndices!;
        for (int pos in positions) {
          if (prevLine.symPositions!.contains(pos) |
              nextLine.symPositions!.contains(pos)) {
            // Normal above below case
            numberInfo.adjacentToSymbol = true;
          }
        }
      });
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
