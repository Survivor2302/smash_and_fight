import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smash_and_fight/helper/boxes.dart';
import 'package:smash_and_fight/helper/utils.dart';
import 'package:smash_and_fight/model/user.dart';
import '../model/robot.dart';

class RobotViewModel extends ChangeNotifier {
  Robot? _currentRobot;
  Robot? _nextRobot;
  User? _user;
  User? _ia;
  List<User> _opponents = <User>[];

  RobotViewModel._internal() {
    _currentRobot = null;
    _nextRobot = null;
    _user = null;
    _ia = null;
    _opponents = <User>[];
  }

  static final RobotViewModel _singleton = RobotViewModel._internal();

  factory RobotViewModel() {
    return _singleton;
  }

  Robot? get currentRobot => _currentRobot;

  set currentRobot(Robot? robot) {
    _currentRobot = robot;
    debugPrint("current robot: ${_currentRobot?.name}");
  }

  Robot? get nextRobot => _nextRobot;

  set nextRobot(Robot? robot) {
    _nextRobot = robot;
    debugPrint("next robots: ${_nextRobot?.name}");
  }

  User? get user => _user;

  set user(User? user) {
    _user = user;
  }

  User? get ia => _ia;

  set ia(User? ia) {
    _ia = ia;
  }

  List<User> get opponents => _opponents;

  set opponents(List<User> opponents) {
    _opponents = opponents;
  }

  //add robot to user
  Future<void> addRobot(Robot robot) async {
    _user?.robots.add(robot);

    if (_user?.robots.length == 3) {
      debugPrint("team: ${_user?.name}");
      boxUser.add(_user!);
      //print box content
      boxUser.values.forEach((element) {
        debugPrint("user: ${element.name}");
      });
      notifyListeners(); // Notifier les écouteurs que la condition est remplie
    }
  }

  Future<List<User>?> generateOpponents() async {
    _opponents.clear();
    _opponents.add(await generateRandomOpponent());
    boxUser.values.forEach((element) {
      if (element.name != _user?.name) {
        _opponents.add(element);
      }
    });

    return _opponents;
  }
}
