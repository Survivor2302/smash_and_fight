import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> getPrenomAleatoire() async {
  final String response =
      await rootBundle.loadString('assets/json/liste-des-prenoms.json');
  final data = await json.decode(response);

  int randomIndex = Random().nextInt(data.length);

  debugPrint(data[randomIndex]["prenoms"]);

  return data[randomIndex]["prenoms"];
}

Future<String> getRandomSentence() async {
  final String response =
      await rootBundle.loadString('assets/json/disquettes.json');
  final data = await json.decode(response);

  int randomIndex = Random().nextInt(data.length);

  debugPrint(data[randomIndex]["txt"]);

  return data[randomIndex]["txt"];
}
