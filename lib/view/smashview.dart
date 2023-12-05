import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/model/changenotifier/swipewidgetnotifier.dart';
import 'package:smash_and_fight/view/widget/propositionwidget.dart';
import 'package:smash_and_fight/view/widget/teamwidget.dart';
import 'package:smash_and_fight/view/widget/swipeWidget.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String name;
  final SwipeWidgetNotifier swipeWidgetNotifier = SwipeWidgetNotifier();

  late RobotViewModel robotViewModel;

  @override
  void initState() {
    super.initState();
    robotViewModel = Provider.of<RobotViewModel>(context, listen: false);
    robotViewModel.addListener(_onRobotViewModelChange); // Ajout d'un écouteur
  }

  @override
  void dispose() {
    robotViewModel
        .removeListener(_onRobotViewModelChange); // Suppression de l'écouteur
    super.dispose();
  }

  void _onRobotViewModelChange() {
    setState(() {
      // Mettre à jour l'interface utilisateur en fonction des nouvelles valeurs
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
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
                if (robotViewModel.user!.robots.length < 3) ...[
                  PropositionWidget(
                    swipeWidgetNotifier: swipeWidgetNotifier,
                  ),
                ] else
                  const Text('Vous avez déjà 3 robots !')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (robotViewModel.user!.robots.length < 3) ...[
                  SwipeWidget(
                      accept: false, swipeWidgetNotifier: swipeWidgetNotifier),
                  SwipeWidget(
                      accept: true, swipeWidgetNotifier: swipeWidgetNotifier),
                ] else
                  const Text('Vous avez déjà 3 robots !')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
