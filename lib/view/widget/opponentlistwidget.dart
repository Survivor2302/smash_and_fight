import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

class OpponentListWidget extends StatefulWidget {
  OpponentListWidget();

  @override
  _OpponentListWidgetState createState() => _OpponentListWidgetState();
}

class _OpponentListWidgetState extends State<OpponentListWidget> {
  late RobotViewModel robotViewModel;

  @override
  void initState() {
    super.initState();
    robotViewModel = Provider.of<RobotViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Text("OpponentListWidget");
  }
}
