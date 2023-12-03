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
    _currentRobot = robot;
  }

  Robot? get nextRobot => _nextRobot;

  set nextRobot(Robot? robot) {
    _nextRobot = robot;
  }

  User? get user => _user;

  set user(User? user) {
    _user = user;
  }

  //add robot to user
  void addRobot(Robot robot) {
    _user?.robots.add(robot);

    if (_user?.robots.length == 3) {
      debugPrint("team: ${_user?.name}");
      _user?.robots.forEach((element) {
        debugPrint("robot: ${element.name}");
      });
      //add user to box
    }
  }
}
