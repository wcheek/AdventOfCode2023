import 'package:day_1/day_1.dart';
import 'package:test/test.dart';

void main() {
  test('Input and output lengths are equal', () {
    final contents = getFileContents("lib/testInput.txt");
    final codedInts = getCodedInts(contents);
    expect(codedInts.length, contents.length);
  }, skip: false);

  test("Handling overlapping OK", () {
    final contents = ["zoneight234"];
    final codedInts = getMatches(contents[0]);
    expect(codedInts, ["one", "eight", "2", "3", "4"]);
  });
}
