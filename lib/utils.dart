import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:smash_and_fight/model/robot.dart';

Future<String> getPrenomAleatoire() async {
  final String response =
      await rootBundle.loadString('assets/json/liste-des-prenoms.json');
  final data = await json.decode(response);

  int randomIndex = Random().nextInt(data.length);

  return data[randomIndex]["prenoms"];
}

Future<String> getRandomSentence() async {
  final String response =
      await rootBundle.loadString('assets/json/disquettes.json');
  final data = await json.decode(response);

  int randomIndex = Random().nextInt(data.length);

  return data[randomIndex]["txt"];
}

Future<Robot> getRandomRobot() async {
  String name = await getPrenomAleatoire();
  return Robot(
      name: name,
      sentence: await getRandomSentence(),
      attack: Random().nextInt(100),
      pv: Random().nextInt(100),
      armor: Random().nextInt(100),
      imageUrl: 'https://robohash.org/$name');
}

Future<List<Robot>> getTwoRobots(Robot? nextRobot) async {
  if (nextRobot != null) {
    final currentRobot = nextRobot;
    final newRobot = await getRandomRobot();
    return [currentRobot, newRobot];
  }

  final currentRobot = await getRandomRobot();
  final newRobot = await getRandomRobot();
  return [currentRobot, newRobot];
}
