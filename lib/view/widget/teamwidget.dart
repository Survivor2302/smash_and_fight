import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/model/changenotifier/swipewidgetnotifier.dart';
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
    RobotViewModel robotViewModel = context.watch<RobotViewModel>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SelectedWidget(
            robot: robotViewModel.user!.robots.length > 0
                ? robotViewModel.user?.robots[0]
                : null),
        SelectedWidget(
            robot: robotViewModel.user!.robots.length > 1
                ? robotViewModel.user?.robots[1]
                : null),
        SelectedWidget(
            robot: robotViewModel.user!.robots.length > 2
                ? robotViewModel.user?.robots[2]
                : null),
      ],
    );
  }
}
