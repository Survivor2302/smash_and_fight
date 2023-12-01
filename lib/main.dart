import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smash_and_fight/helper/boxes.dart';
import 'package:smash_and_fight/model/robot.dart';
import 'helper/utils.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'viewModel/robotviewmodel.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RobotAdapter());
  boxRobot = await Hive.openBox<Robot>('robotBox');

  debugPrint('MAIN boxRobot: ${boxRobot.length}');
  boxRobot.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Smash&Fight'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String name;
  RobotViewModel robotViewModel = RobotViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Image.asset('assets/images/Logo.png', height: 50.0),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                boxRobot.length > 0
                    ? buildSelectedBot(boxRobot.getAt(0))
                    : buildSelectedBot(),
                boxRobot.length > 1
                    ? buildSelectedBot(boxRobot.getAt(1))
                    : buildSelectedBot(),
                boxRobot.length > 2
                    ? buildSelectedBot(boxRobot.getAt(2))
                    : buildSelectedBot(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable(
                    child: buildProposition(),
                    feedback: buildProposition()) //TODO A Bosser
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSwipeWidget(false),
                buildSwipeWidget(true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCross(bool accept) {
    Widget cross = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: accept ? Colors.green : Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          accept
              ? Icon(Icons.favorite, size: 100)
              : Icon(Icons.delete_forever, size: 100),
        ],
      ),
    );

    Timer timer = Timer(Duration(milliseconds: 550), () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AnimatedContainer(
          duration: Duration(seconds: 0),
          child: cross,
        ),
      ),
    );
  }

  Widget buildSelectedBot([Robot? robot]) {
    if (robot == null) {
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
          child: Center(
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
        imageUrl: robot.imageUrl,
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

  Widget buildProposition() {
    return FutureBuilder<List<Robot>>(
      future: getTwoRobots(robotViewModel.nextRobot),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          final robot = snapshot.data!;
          robotViewModel.currentRobot = robot[0];
          debugPrint(
              'currentRobotviewmodel: ${robotViewModel.currentRobot?.name}');
          robotViewModel.nextRobot = robot[1];
          debugPrint('nextRobotviewmodel: ${robotViewModel.nextRobot?.name}');
          final randomColor = Color(Random().nextInt(0xffffffff));

          return Container(
            //p-e mettre un padding ici
            child: Stack(
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
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 58, 57, 57)
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
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            robot.first.sentence,
                            style: TextStyle(
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
            ),
          );
        }
      },
    );
  }

  Widget buildSwipeWidget(bool accept) {
    return Material(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            Size(80, 80),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
        ),
        onPressed: () {
          if (accept) {
            setState(() {
              boxRobot.add(robotViewModel.currentRobot!);
              showCross(true);
              buildProposition();
            }); //TODO IL faudra sauvegarder le robot et en générer un nouveau
          }
          if (!accept) {
            setState(() {
              debugPrint(boxRobot.length.toString());
              showCross(false);
              buildProposition();
            });
          }
        },
        child: accept
            ? Icon(Icons.favorite, color: Colors.pink, size: 24.0)
            : Icon(Icons.delete_forever, color: Colors.pink, size: 24.0),
      ),
    );
  }
}
