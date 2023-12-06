import 'package:hive/hive.dart';
import 'package:smash_and_fight/model/robot.dart';

part 'adapter/user.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<Robot> robots;
  
  User({required this.name}) : robots = <Robot>[];
}
