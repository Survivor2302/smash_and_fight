import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/model/user.dart';
import 'package:smash_and_fight/viewmodel/RobotViewModel.dart';

class OpponentListWidget extends StatefulWidget {
  OpponentListWidget();

  @override
  _OpponentListWidgetState createState() => _OpponentListWidgetState();
}

class _OpponentListWidgetState extends State<OpponentListWidget> {
  late RobotViewModel robotViewModel;

  late List<User> opponents = [];

  ValueNotifier<int> selectedOpponentIndex = ValueNotifier<int>(-1);

  @override
  void initState() {
    super.initState();
    robotViewModel = Provider.of<RobotViewModel>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>?>(
        future: robotViewModel.generateOpponents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              opponents = snapshot.data!;
              return Column(
                children: [
                  const Text(
                    'Choisis un adversaire!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: opponents.length,
                      itemBuilder: (context, index) {
                        return ValueListenableBuilder(
                          valueListenable: selectedOpponentIndex,
                          builder: (context, value, child) {
                            return GestureDetector(
                              onTap: () {
                                selectedOpponentIndex.value = index;
                                robotViewModel.opponent = opponents[index];
                                debugPrint(
                                    'Opponent selected: ${opponents[index].name}');
                              },
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: const EdgeInsets.all(8),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                      color: value == index
                                          ? const Color.fromARGB(
                                              255, 221, 28, 173)
                                          : Colors.transparent,
                                      width: 6.0,
                                    ),
                                  ),
                                  child: Container(
                                    height: 150,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.transparent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              opponents[index].name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            (opponents[index].name == 'IA')
                                                ? GestureDetector(
                                                    onTap: () {
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.replay_rounded,
                                                      color: Colors.green,
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        //TODO: delete opponent
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons
                                                          .delete, // Remplacez par l'icône que vous voulez utiliser
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: opponents[index]
                                              .robots
                                              .map((robot) => CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            robot.imageUrl),
                                                    radius: 25,
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Aucun adversaire trouvé'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
