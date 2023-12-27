import 'package:day_3/day_3.dart';
import 'package:test/test.dart';

void testLineMethods() {
  String testLine =
      "...733.......289..262.....520..................161.462..........450.........................183.............................................";
  LineInfo line = LineInfo(testLine);
  test("Get nums in line", () {
    expect(line.numsInLine, [733, 289, 262, 520, 161, 462, 458, 183]);
  });
}

void main() {
  testLineMethods();
  // test('Correct part numbers', () {
  //   expect(getCorrectPartNumbers(), [467, 35, 633, 617, 592, 755, 664, 598]);
  // }, skip: true);
}
