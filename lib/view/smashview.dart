import 'package:flutter/material.dart';
import 'package:smash_and_fight/model/changenotifier/swipewidgetnotifier.dart';
import 'package:smash_and_fight/view/widget/propositionwidget.dart';
import 'package:smash_and_fight/view/widget/teamwidget.dart';
import 'package:smash_and_fight/view/widget/swipeWidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String name;
  final SwipeWidgetNotifier swipeWidgetNotifier =
      SwipeWidgetNotifier(); // Ajoutez cette ligne

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
            TeamWidget(swipeWidgetNotifier: swipeWidgetNotifier),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable(
                  feedback: PropositionWidget(
                    swipeWidgetNotifier: swipeWidgetNotifier,
                  ),
                  child: PropositionWidget(
                    swipeWidgetNotifier: swipeWidgetNotifier,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // buildSwipeWidget(false),
                // buildSwipeWidget(true),
                SwipeWidget(
                    accept: false, swipeWidgetNotifier: swipeWidgetNotifier),
                SwipeWidget(
                    accept: true, swipeWidgetNotifier: swipeWidgetNotifier),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
