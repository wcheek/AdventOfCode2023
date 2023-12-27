import 'package:day_3/day_3.dart';
import 'package:test/test.dart';

void testLineMethods() {
  late LineInfo line;
  setUp(() {
    String testLine =
        "...733....+..289..262.....520...@...\$......-...161.462...=......450.......*.....%..../......183.....#.......&...............................";
    line = LineInfo(testLine, 0);
  });

  test("Get nums in line", () {
    expect(
        line.numsInLineInfo!.map((n) => n.number),
        equals([
          733,
          289,
          262,
          520,
          161,
          462,
          450,
          183,
        ]));
  });

  test("Get num positions in line", () {
    expect(
        line.numsInLineInfo!.map((n) => n.numIndices),
        equals([
          [3, 4, 5],
          [13, 14, 15],
          [18, 19, 20],
          [26, 27, 28],
          [47, 48, 49],
          [51, 52, 53],
          [64, 65, 66],
          [92, 93, 94]
        ]));
  });

  test("Get symbols in line", () {
    expect(line.symsInLineInfo!.map((n) => n.$1),
        equals(["+", "@", "\$", "-", "=", "*", "%", "/", "#", "&"]));
  });

  test("Get symbol positions in line", () {
    expect(line.symsInLineInfo!.map((n) => n.$2),
        equals([10, 32, 36, 43, 57, 74, 80, 85, 100, 108]));
  });

  test("Correct printing", () {
    expect(
        line.toString(),
        equals(
            "Line #0 contains (733: 3, 289: 13, 262: 18, 520: 26, 161: 47, 462: 51, 450: 64, 183: 92)"));
  });
}

void testMachineSchemaMethods() {
  late MachineSchema machineSchema;
  setUp(() {
    machineSchema = MachineSchema(filePath: "lib/testInput.txt");
  });

  test("Num lines correct", () {
    expect(machineSchema.lines.length, equals(10));
  });

  group("Line selection", () {
    test("Previous line 0 edgecase", () {
      expect(
          machineSchema
              .getLineByLineNum(machineSchema.lines[0].lineNum! - 1)
              .toString(),
          equals(LineInfo("", null).toString()));
    });

    test("Next line END edgecase", () {
      expect(
          machineSchema
              .getLineByLineNum(
                  machineSchema.lines[machineSchema.lines.length - 1].lineNum! +
                      1)
              .toString(),
          equals(LineInfo("", null).toString()));
    }, skip: false);

    test("Surrounding lines normal case", () {
      var prevLineStr = machineSchema.lines[4].toString();
      var currentLine = machineSchema.lines[5];
      var nextLineStr = machineSchema.lines[6].toString();
      expect(
          machineSchema.getLineByLineNum(currentLine.lineNum! - 1).toString(),
          equals(prevLineStr));
      expect(
          machineSchema.getLineByLineNum(currentLine.lineNum! + 1).toString(),
          equals(nextLineStr));
    });
  });

  group("Num shifting methods", () {
    late List<(Set<int>, Set<int>)> leftTestSets;
    late List<(Set<int>, Set<int>)> rightTestSets;
    setUp(() {
      leftTestSets = [
        ({1, 2, 3}, {0, 1, 2}),
        ({0, 1, 2}, {0, 1}),
        ({0, 1}, {0}),
      ];
      rightTestSets = [
        ({139, 2, 3}, {3, 4}),
        ({45, 46}, {46, 47}),
        ({0}, {1}),
      ];
    });
    test("Shift set left", () {
      for (var testSet in leftTestSets) {
        expect(MachineSchema.shiftSetLeft(testSet.$1, 1), equals(testSet.$2));
      }
    });
    test("Shift set right", () {
      for (var testSet in rightTestSets) {
        expect(MachineSchema.shiftSetRight(testSet.$1, 1), equals(testSet.$2));
      }
    });
  });
  test("Final answer with correct nums", () {
    expect(machineSchema.numsAdjacent,
        equals([467, 35, 633, 617, 592, 755, 664, 598]));
  });
}

void main() {
  group("Test Line Methods", testLineMethods);
  group("Test machine schema methods", testMachineSchemaMethods);
  // test('Correct part numbers', () {
  //   expect(getCorrectPartNumbers(), [467, 35, 633, 617, 592, 755, 664, 598]);
  // }, skip: true);
}
