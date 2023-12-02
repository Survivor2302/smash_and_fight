import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/helper/utils.dart';
import 'package:smash_and_fight/model/changenotifier/swipewidgetnotifier.dart';
import 'package:smash_and_fight/model/robot.dart';
import 'package:smash_and_fight/view/widget/selectedwidget.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

class TeamWidget extends StatefulWidget {
  final SwipeWidgetNotifier swipeWidgetNotifier;

  TeamWidget({required this.swipeWidgetNotifier});

  @override
  _TeamWidgetState createState() => _TeamWidgetState();
}

class _TeamWidgetState extends State<TeamWidget> {
  late RobotViewModel robotViewModel;

  @override
  void initState() {
    super.initState();
    // Move the initialization of robotViewModel to didChangeDependencies
    // to ensure that context is available
    robotViewModel = Provider.of<RobotViewModel>(context, listen: false);
    widget.swipeWidgetNotifier.addListener(_handleChanges);
  }

  void _handleChanges() {
    setState(() {
      // Trigger the rebuild of WidgetB
    });
  }

  @override
  Widget build(BuildContext context) {
    print("teamWidget is being rebuilt!"); // Add a print statement
    RobotViewModel robotViewModel = context.watch<RobotViewModel>();
    debugPrint("TEST teamWidget: ${robotViewModel.currentRobot?.name}");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SelectedWidget(robot: robotViewModel.currentRobot),
        SelectedWidget(robot: robotViewModel.currentRobot),
        SelectedWidget(robot: robotViewModel.currentRobot),
      ],
    );
  }
}
