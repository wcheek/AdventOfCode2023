import 'package:day_3/day_3.dart';
import 'package:collection/collection.dart';

void main(List<String> arguments) {
  MachineSchema machineSchema = MachineSchema(filePath: "lib/input.txt");
  print("Sum of adjacent numbers: ${machineSchema.numsAdjacent!.sum}");
  print("Total gear ratio: ${machineSchema.totalGearRatio}");
}
