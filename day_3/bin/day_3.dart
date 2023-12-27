import 'package:day_3/day_3.dart';
import 'package:collection/collection.dart';

void main(List<String> arguments) {
  MachineSchema machineSchema = MachineSchema(filePath: "lib/input.txt");
  print(machineSchema.numsAdjacent!.sum);
}
