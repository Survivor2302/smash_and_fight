import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/helper/boxes.dart';
import 'package:smash_and_fight/helper/utils.dart';
import 'package:smash_and_fight/model/robot.dart';
import 'package:smash_and_fight/model/user.dart';
import 'package:smash_and_fight/view/welcomeview.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smash_and_fight/viewmodel/RobotViewModel.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RobotAdapter());
  Hive.registerAdapter(UserAdapter());
  boxRobot = await Hive.openBox<Robot>('robotBox');
  boxUser = await Hive.openBox<User>('userBox');
  
  // boxRobot.clear();
  // boxUser.clear();
  
  // var test = Robot(
  //     name: 'robeotar',
  //     sentence: 'Some sentence',
  //     attack: 10,
  //     pv: 100,
  //     armor: 10,
  //     imageUrl: 'http://example.com/image.jpg');
  // boxRobot.add(test);
  // boxRobot.values.forEach((element) {
  //   debugPrint("robot: ${element.name}");
  // });
  
  // var user = User(name: 'user');
  
  // user.robots.add(test);
  // user.robots.add(test);
  // user.robots.add(test);
  
  // boxUser.add(user);
  // boxUser.values.forEach((element) {
  //   debugPrint("user: " + element.name);
  //   debugPrint("team  ");
  //   element.robots.forEach((robot) {
  //     debugPrint("${robot.name}");
  //   });
  // });

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
