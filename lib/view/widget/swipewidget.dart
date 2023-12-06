import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/model/changenotifier/swipewidgetnotifier.dart';
import 'package:smash_and_fight/viewmodel/RobotViewModel.dart';

class SwipeWidget extends StatefulWidget {
  final bool accept;
  final SwipeWidgetNotifier swipeWidgetNotifier;

  SwipeWidget({required this.accept, required this.swipeWidgetNotifier});

  @override
  _SwipeWidgetState createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget> {
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
            const Size(80, 80),
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
          if (widget.accept) {
            setState(() {
              robotViewModel.addRobot(robotViewModel.currentRobot!);
              showCross(context, true);
            });
            widget.swipeWidgetNotifier.notifyChanges();
          }
          if (!widget.accept) {
            setState(() {
              showCross(context, false);
            });
            widget.swipeWidgetNotifier.notifyChanges();
          }
        },
        child: widget.accept
            ? const Icon(Icons.favorite, color: Colors.pink, size: 24.0)
            : const Icon(Icons.delete_forever, color: Colors.pink, size: 24.0),
      ),
    );
  }

  void showCross(BuildContext context, bool accept) {
    if (mounted) {
      Widget cross = Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: accept ? Colors.green : Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            accept
                ? const Icon(Icons.favorite, size: 100)
                : const Icon(Icons.delete_forever, size: 100),
          ],
        ),
      );

      Timer(const Duration(milliseconds: 550), () {
        if (mounted) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AnimatedContainer(
            duration: const Duration(seconds: 0),
            child: cross,
          ),
        ),
      );
    }
  }
}
