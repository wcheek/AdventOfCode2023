import 'dart:io';
import 'package:day_1/day_1.dart' as day_1;
import 'package:collection/collection.dart';

void main() async {
  File input = File("lib/input.txt");
  List<String> contents = await input.readAsLines();
  final codedInts = day_1.getCodedInts(contents);
  contents.asMap().forEach((ind, val) => print("$val: ${codedInts[ind]}"));
  print(codedInts.sum);
}
