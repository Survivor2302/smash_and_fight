import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/helper/boxes.dart';
import 'package:smash_and_fight/model/robot.dart';
import 'package:smash_and_fight/model/user.dart';
import 'package:smash_and_fight/view/welcomeview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'viewmodel/robotviewmodel.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RobotAdapter());
  boxRobot = await Hive.openBox<Robot>('robotBox');
  boxUser = await Hive.openBox<User>('userBox');

  boxRobot.clear();
  runApp(
    ChangeNotifierProvider(
      create: (context) => RobotViewModel(),
      child: const MyApp(),
    ),
  );
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
      home:
          const UsernameInputPage(), // Use the username input page as the first page
    );
  }
}
