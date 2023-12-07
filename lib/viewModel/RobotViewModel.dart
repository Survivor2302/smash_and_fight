import 'package:flutter/material.dart';
import 'package:smash_and_fight/helper/boxes.dart';
import 'package:smash_and_fight/helper/utils.dart';
import 'package:smash_and_fight/model/user.dart';
import '../model/robot.dart';

class RobotViewModel extends ChangeNotifier {
  Robot? _currentRobot;
  Robot? _nextRobot;
  User? _user;
  User? _opponent;
  List<User> _opponents = <User>[];

  RobotViewModel._internal() {
    _currentRobot = null;
    _nextRobot = null;
    _user = null;
    _opponent = null;
    _opponents = <User>[];
  }

  static final RobotViewModel _singleton = RobotViewModel._internal();

  factory RobotViewModel() {
    return _singleton;
  }

  Robot? get currentRobot => _currentRobot;

  set currentRobot(Robot? robot) {
    _currentRobot = robot;
    //debugPrint("current robot: ${_currentRobot?.name}");
  }

  Robot? get nextRobot => _nextRobot;

  set nextRobot(Robot? robot) {
    _nextRobot = robot;
    //debugPrint("next robots: ${_nextRobot?.name}");
  }

  User? get user => _user;

  set user(User? user) {
    _user = user;
  }

  User? get opponent => _opponent;

  set opponent(User? opponent) {
    _opponent = opponent;
  }

  List<User> get opponents => _opponents;

  set opponents(List<User> opponents) {
    _opponents = opponents;
  }

  //add robot to user
  Future<void> addRobot(Robot robot) async {
    _user?.robots.add(robot);

    if (_user?.robots.length == 3) {
      //debugPrint("team: ${_user?.name}");
      boxUser.add(_user!);
      //print box content
      boxUser.values.forEach((element) {
        //debugPrint("user: ${element.name}");
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

  bool fight() {
    if (_user != null && _opponent != null) {
      // debugPrint("fighting...");
      int userRobotIndex = 0;
      int opponentRobotIndex = 0;

      while (userRobotIndex < _user!.robots.length &&
          opponentRobotIndex < _opponent!.robots.length) {
        int userRobotPv = _user!.robots[userRobotIndex].pv;
        int opponentRobotPv = _opponent!.robots[opponentRobotIndex].pv;

        while (userRobotPv > 0 && opponentRobotPv > 0) {
          if (_user!.robots[userRobotIndex].speed >
              _opponent!.robots[opponentRobotIndex].speed) {
            opponentRobotPv -= _user!.robots[userRobotIndex].attack;
            if (opponentRobotPv <= 0) {
              // debugPrint("user's robot win the fight");
              opponentRobotIndex++;
              if (opponentRobotIndex >= _opponent!.robots.length) break;
              opponentRobotPv = _opponent!.robots[opponentRobotIndex]
                  .pv; // reset opponent's robot pv for next fight
            } else {
              userRobotPv -= _opponent!.robots[opponentRobotIndex].attack;
              if (userRobotPv <= 0) {
                // debugPrint("opponent's robot win the fight");
                userRobotIndex++;
                if (userRobotIndex >= _user!.robots.length) break;
                userRobotPv = _user!.robots[userRobotIndex]
                    .pv; // reset user's robot pv for next fight
              }
            }
          } else {
            userRobotPv -= _opponent!.robots[opponentRobotIndex].attack;
            if (userRobotPv <= 0) {
              // debugPrint("opponent's robot win the fight");
              userRobotIndex++;
              if (userRobotIndex >= _user!.robots.length) break;
              userRobotPv = _user!.robots[userRobotIndex]
                  .pv; // reset user's robot pv for next fight
            } else {
              opponentRobotPv -= _user!.robots[userRobotIndex].attack;
              if (opponentRobotPv <= 0) {
                // debugPrint("user's robot win the fight");
                opponentRobotIndex++;
                if (opponentRobotIndex >= _opponent!.robots.length) break;
                opponentRobotPv = _opponent!.robots[opponentRobotIndex]
                    .pv; // reset opponent's robot pv for next fight
              }
            }
          }
        }
      }

      if (userRobotIndex < _user!.robots.length) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
