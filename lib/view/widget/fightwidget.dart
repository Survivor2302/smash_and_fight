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
    return Text("FightWidget");
  }
}
