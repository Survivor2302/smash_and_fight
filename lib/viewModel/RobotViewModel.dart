import 'package:flutter/material.dart';
import 'package:smash_and_fight/model/user.dart';
import '../model/robot.dart';

class RobotViewModel extends ChangeNotifier {
  Robot? _currentRobot;
  Robot? _nextRobot;

  User? _user;

  RobotViewModel._internal() {
    _currentRobot = null;
    _nextRobot = null;
    _user = null;
  }

  static final RobotViewModel _singleton = RobotViewModel._internal();

  factory RobotViewModel() {
    return _singleton;
  }

  Robot? get currentRobot => _currentRobot;

  set currentRobot(Robot? robot) {
    debugPrint("currentRobot: ${robot?.name}");
    _currentRobot = robot;
    //notifyListeners();
  }

  Robot? get nextRobot => _nextRobot;

  set nextRobot(Robot? robot) {
    debugPrint("nextRobot: ${robot?.name}");
    _nextRobot = robot;
    //notifyListeners();
  }

  User? get user => _user;

  set user(User? user) {
    debugPrint("user: ${user?.name}");
    _user = user;
    //notifyListeners();
  }

  //add robot to user
  void addRobot(Robot robot) {
    debugPrint("addRobot: ${robot.name}");
    _user?.robots.add(robot);
    //notifyListeners();
  }
}
