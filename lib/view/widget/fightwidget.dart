import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

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
          //TODO BDD
        },
        child: const Image(image: AssetImage('images/fight.png')),
      ),
    );
  }
}
