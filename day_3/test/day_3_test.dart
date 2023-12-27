import 'package:day_3/day_3.dart';
import 'package:test/test.dart';

void testLineMethods() {
  late LineInfo line;
  setUp(() {
    String testLine =
        "...733.......289..262.....520..................161.462..........450.........................183.............................................";
    line = LineInfo(testLine);
  });

  test("Get nums in line", () {
    expect(
        line.numsInLineInfo!.map((n) => n.$1),
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
        line.numsInLineInfo!.map((n) => n.$2),
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
}

void testMachineSchemaMethods() {
  late MachineSchema machineSchema;
  setUp(() {
    machineSchema = MachineSchema(filePath: "lib/testInput.txt");
  });

  test("Num lines correct", () {
    expect(machineSchema.lines.length, equals(10));
  });
}

void main() {
  group("Test Line Methods", testLineMethods);
  group("Test machine schema methods", testMachineSchemaMethods);
  // test('Correct part numbers', () {
  //   expect(getCorrectPartNumbers(), [467, 35, 633, 617, 592, 755, 664, 598]);
  // }, skip: true);
}
