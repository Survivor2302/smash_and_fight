import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/viewmodel/RobotViewModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FightWidget extends StatefulWidget {
  FightWidget();

  @override
  _FightWidgetState createState() => _FightWidgetState();
}

class _FightWidgetState extends State<FightWidget> {
  late RobotViewModel robotViewModel;

  @override
  void initState() {
    super.initState();
    robotViewModel = Provider.of<RobotViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80.0),
      ),
      child: TextButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
              const Size(400, 80),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white,
            ),
            side: MaterialStateProperty.all<BorderSide>(
              const BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
          ),
          onPressed: () {
            if (robotViewModel.opponent == null) {
              Fluttertoast.showToast(
                msg: "Please select an opponent",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey,
                textColor: Colors.white,
                fontSize: 16.0,
              );

              debugPrint('no opponent selected');
              return;
            }
            var isUserWinner = robotViewModel.fight();
            if (isUserWinner) {
              //TODO: show popup win
              debugPrint('user win');
            } else {
              //TODO: show popup loose
              debugPrint('user loose');
            }
          },
          child: Image.asset('assets/images/fight.png')),
    );
  }
}
