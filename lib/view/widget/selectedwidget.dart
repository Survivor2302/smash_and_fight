import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/helper/utils.dart';
import 'package:smash_and_fight/model/changenotifier/swipewidgetnotifier.dart';
import 'package:smash_and_fight/model/robot.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

class SelectedWidget extends StatefulWidget {
  Robot? robot;

  SelectedWidget({required this.robot});

  @override
  _SelectedWidgetState createState() => _SelectedWidgetState();
}

class _SelectedWidgetState extends State<SelectedWidget> {
  @override
  void initState() {
    super.initState();
    // Move the initialization of robotViewModel to didChangeDependencies
    // to ensure that context is available
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    debugPrint("selected is being rebuilt!");
    print("robot: ${widget.robot?.name}");
    if (widget.robot == null) {
      return Material(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey,
          ),
          child: const Center(
            child: Text(
              '?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    //debugPrint('buildSelectedBot: ${robot.name}');
    return Material(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.robot?.imageUrl ?? '',
        imageBuilder: (context, imageProvider) => Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
