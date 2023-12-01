import 'package:flutter/material.dart';
import '../model/robot.dart';

class RobotViewModel extends ChangeNotifier {
  Robot? _currentRobot;
  Robot? _nextRobot;

  RobotViewModel._internal() {
    _currentRobot = null;
    _nextRobot = null;
  }

  static final RobotViewModel _singleton = RobotViewModel._internal();

  factory RobotViewModel() {
    return _singleton;
  }

  Robot? get currentRobot => _currentRobot;

  set currentRobot(Robot? robot) {
    _currentRobot = robot;
    //notifyListeners();
  }

  Robot? get nextRobot => _nextRobot;

  set nextRobot(Robot? robot) {
    _nextRobot = robot;
    //notifyListeners();
  }
}
