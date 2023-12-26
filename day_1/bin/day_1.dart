import 'package:day_1/day_1.dart' as day_1;
import 'package:collection/collection.dart';

void main() {
  final contents = day_1.getFileContents("lib/input.txt");
  final codedInts = day_1.getCodedInts(contents);
  print(codedInts.sum);
}
