import 'package:hive/hive.dart';

part 'adapter/robot.g.dart';

@HiveType(typeId: 1)
class Robot {
  @HiveField(0)
  String name;
  @HiveField(1)
  String sentence;
  @HiveField(2)
  int attack;
  @HiveField(3)
  int pv;
  @HiveField(4)
  int armor;
  @HiveField(5)
  late String imageUrl; // Mark the field as 'late'

  Robot(
      {required this.name,
      required this.sentence,
      required this.attack,
      required this.pv,
      required this.armor,
      required this.imageUrl}); // Add a generative constructor
}
