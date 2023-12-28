import 'dart:io';
import 'package:collection/collection.dart';

class NumberInfo {
  final int number;
  final List<int> numIndices;
  bool adjacentToSymbol = false;

  NumberInfo(this.number, this.numIndices);
}

class SymbolsInfo {
  final String symbol;
  final int position;
  Set<int> nearbyNums = {};

  SymbolsInfo(this.symbol, this.position);
}

class LineInfo {
  final int? lineNum;

  List<NumberInfo>? numsInLineInfo;
  List<SymbolsInfo>? symsInLineInfo;
  Set<int>? symPositions;

  RegExp numRegex = RegExp(r"(\d+)");
  RegExp symsRegex = RegExp(r"[^\w\d\.]");

  LineInfo(String line, this.lineNum) {
    numsInLineInfo = getNumsInLine(line);
    symsInLineInfo = getSymsInLine(line);
    symPositions = symsInLineInfo!.map((symInfo) => symInfo.position).toSet();
  }

  @override
  String toString() {
    String stringifiedObj = numsInLineInfo!.map((el) {
      return "${el.number}: ${el.numIndices[0]}";
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

  List<SymbolsInfo> getSymsInLine(String line) {
    var matches = symsRegex.allMatches(line);
    List<SymbolsInfo> symbolsList = [];
    // var returnList = matches.map((match) {
    for (var match in matches) {
      String sym = match.group(0)!;
      int pos = match.start;
      symbolsList.add(SymbolsInfo(sym, pos));
    }
    return symbolsList;
  }
}

class MachineSchema {
  List<LineInfo>? _lines;
  List<int>? numsAdjacent;
  List<SymbolsInfo>? symbolGearRatios;
  int? totalGearRatio;

  MachineSchema({String filePath = "lib/testInput.txt"}) {
    final fileInput = getFileContents(filePath);
    _lines = [];
    fileInput.asMap().forEach((ind, line) {
      _lines?.add(LineInfo(line, ind));
    });
    testLinesForAdjacency(_lines!);
    numsAdjacent = getNumsAdjacent(_lines!);

    symbolGearRatios = getSymbolsWithGearRatio(_lines!);
    totalGearRatio = calculateTotalGearRatio(symbolGearRatios!);
  }
  List<LineInfo> get lines => _lines!;

  void testLinesForAdjacency(List<LineInfo> lines) {
    for (LineInfo currentLine in lines) {
      var prevLine = getLineByLineNum(currentLine.lineNum! - 1);
      var nextLine = getLineByLineNum(currentLine.lineNum! + 1);

      // Current line
      var (
        shiftLeftcurrentLineSymPositions,
        shiftRightcurrentLineSymPositions
      ) = getShiftedSymPosition(currentLine.symPositions!);

      // Previous line
      var prevLineSymPositions = prevLine.symPositions!;
      var (shiftLeftPrevLineSymPositions, shiftRightPrevLineSymPositions) =
          getShiftedSymPosition(prevLineSymPositions);

      // Next line
      var nextLineSymPositions = nextLine.symPositions!;
      var (shiftLeftNextLineSymPositions, shiftRightNextLineSymPositions) =
          getShiftedSymPosition(nextLineSymPositions);

      Map<String, Function> symPosBools = {
        "aboveBelow": (pos) {
          return (prevLineSymPositions.contains(pos) |
              nextLineSymPositions.contains(pos));
        },
        "leftRightAdjacent": (pos) {
          return (shiftLeftcurrentLineSymPositions.contains(pos) |
              shiftRightcurrentLineSymPositions.contains(pos));
        },
        "leftDiagonals": (pos) {
          return (shiftLeftPrevLineSymPositions.contains(pos) |
              shiftLeftNextLineSymPositions.contains(pos));
        },
        "rightDiagonals": (pos) {
          return (shiftRightPrevLineSymPositions.contains(pos) |
              shiftRightNextLineSymPositions.contains(pos));
        }
      };

      for (NumberInfo currentNumInfo in currentLine.numsInLineInfo!) {
        for (int pos in currentNumInfo.numIndices) {
          if (symPosBools["aboveBelow"]!(pos) |
              (symPosBools["leftRightAdjacent"]!(pos)) |
              symPosBools["leftDiagonals"]!(pos) |
              symPosBools["rightDiagonals"]!(pos)) {
            // adjacent symbol is in prev or next line
            currentNumInfo.adjacentToSymbol = true;
            for (SymbolsInfo sym in prevLine.symsInLineInfo!) {
              if ((sym.position == pos - 1) |
                  (sym.position == pos + 1) |
                  (sym.position == pos)) {
                sym.nearbyNums.add(currentNumInfo.number);
              }
            }
            for (SymbolsInfo sym in currentLine.symsInLineInfo!) {
              if ((sym.position == (pos - 1)) | (sym.position == (pos + 1))) {
                sym.nearbyNums.add(currentNumInfo.number);
              }
            }
            for (SymbolsInfo sym in nextLine.symsInLineInfo!) {
              if ((sym.position == pos - 1) |
                  (sym.position == pos + 1) |
                  (sym.position == pos)) {
                sym.nearbyNums.add(currentNumInfo.number);
              }
            }
          }
        }
      }
    }
  }

  List<int> getNumsAdjacent(List<LineInfo> lines) {
    List<int> returnInts = [];
    for (LineInfo line in lines) {
      for (NumberInfo numInfo in line.numsInLineInfo!) {
        if (numInfo.adjacentToSymbol) {
          returnInts.add(numInfo.number);
        }
      }
    }
    return returnInts;
  }

  LineInfo getLineByLineNum(int lineNum) {
    try {
      return lines[lineNum];
    } on RangeError {
      return LineInfo("", null);
    }
  }

  List<SymbolsInfo> getSymbolsWithGearRatio(List<LineInfo> lines) {
    List<SymbolsInfo> returnSyms = [];
    for (LineInfo line in lines) {
      for (SymbolsInfo sym in line.symsInLineInfo!) {
        if ((sym.symbol == "*") & (sym.nearbyNums.length == 2)) {
          returnSyms.add(sym);
        }
      }
    }
    return returnSyms;
  }

  int calculateTotalGearRatio(List<SymbolsInfo> symbols) {
    return symbols.map((sym) => sym.nearbyNums.reduce((a, b) => a * b)).sum;
  }

  static Set<int?> shiftSetLeft(Set<int> origSet, int shiftValue) {
    Set<int?> returnSet = origSet
        .map((val) => val - shiftValue >= 0 ? val - shiftValue : null)
        .toSet();
    returnSet.retainWhere((val) {
      if (val == null) {
        return false;
      } else {
        return true;
      }
    });
    return returnSet;
  }

  static Set<int?> shiftSetRight(Set<int> origSet, int shiftValue) {
    Set<int?> returnSet = origSet
        .map((val) => val + shiftValue < 140 ? val + shiftValue : null)
        .toSet();
    returnSet.retainWhere((val) {
      if (val == null) {
        return false;
      } else {
        return true;
      }
    });
    return returnSet;
  }

  static (Set<int?>, Set<int?>) getShiftedSymPosition(Set<int> currentPos) {
    return (shiftSetLeft(currentPos, 1), shiftSetRight(currentPos, 1));
  }

  static List<String> getFileContents(String path) {
    File input = File(path);
    List<String> contents = input.readAsLinesSync();
    return contents;
  }
}
