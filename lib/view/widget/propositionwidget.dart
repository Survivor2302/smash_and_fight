import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/helper/utils.dart';
import 'package:smash_and_fight/model/changenotifier/swipewidgetnotifier.dart';
import 'package:smash_and_fight/model/robot.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

class PropositionWidget extends StatefulWidget {
  final SwipeWidgetNotifier swipeWidgetNotifier;
  
  PropositionWidget({required this.swipeWidgetNotifier});
  
  @override
  _PropositionWidgetState createState() => _PropositionWidgetState();
}

class _PropositionWidgetState extends State<PropositionWidget> {
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
    print("PropositionWidget is being rebuilt!"); // Add a print statement
    RobotViewModel robotViewModel = context.watch<RobotViewModel>();

    return FutureBuilder<List<Robot>>(
      future: getTwoRobots(robotViewModel.nextRobot),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Text('No data available');
        } else {
          final robot = snapshot.data!;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            robotViewModel.currentRobot = robot[0];
            robotViewModel.nextRobot = robot[1];
          });
          final randomColor = Color(Random().nextInt(0xffffffff));

          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl: robot.first.imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.height / 1.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: randomColor,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 58, 57, 57)
                            .withOpacity(0.0), // transparent at the top
                        const Color.fromARGB(255, 58, 57, 57)
                            .withOpacity(0.8), // opaque at the bottom
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          robot.first.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          robot.first.sentence,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
