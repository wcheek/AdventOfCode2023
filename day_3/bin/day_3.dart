import 'package:day_3/day_3.dart';

void main(List<String> arguments) {
  MachineSchema machineSchema = MachineSchema(filePath: "lib/testInput.txt");
  print(machineSchema.numsAdjacent);
}
