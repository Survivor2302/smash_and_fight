import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

class OpponentListWidget extends StatefulWidget {
  OpponentListWidget();

  @override
  _OpponentListWidgetState createState() => _OpponentListWidgetState();
}

class _OpponentListWidgetState extends State<OpponentListWidget> {
  late RobotViewModel robotViewModel;
  late List<Opponent> opponents = [
    Opponent('MecdsqdsMecdsqds 1', [
      'https://robohash.org/MecdsqdsMecdsqds1.png?size=100x100',
      'https://robohash.org/MecdsqdsMecdsqds2.png?size=100x100',
      'https://robohash.org/MecdsqdsMecdsqds3.png?size=100x100',
    ]),
    Opponent('Mec 2', [
      'https://robohash.org/Mec2_1.png?size=100x100',
      'https://robohash.org/Mec2_2.png?size=100x100',
      'https://robohash.org/Mec2_3.png?size=100x100',
    ]),
    Opponent('Mec 3', [
      'https://robohash.org/Mec3_1.png?size=100x100',
      'https://robohash.org/Mec3_2.png?size=100x100',
      'https://robohash.org/Mec3_3.png?size=100x100',
    ]),
  ];

  late int selectedOpponentIndex;

  @override
  void initState() {
    super.initState();
    selectedOpponentIndex = -1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    robotViewModel = Provider.of<RobotViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
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
        Container(
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 1.8,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: opponents.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedOpponentIndex = index;
                    //robotViewModel.selectedOpponent = opponents[index];
                  });
                },
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.all(8),
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: selectedOpponentIndex == index
                            ? Color.fromARGB(255, 221, 28, 173)
                            : Colors.transparent,
                        width: 6.0,
                      ),
                    ),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(8),
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            opponents[index].name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: opponents[index]
                                .robotImages
                                .map((imageUrl) => CircleAvatar(
                                      backgroundImage: NetworkImage(imageUrl),
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
          ),
        ),
      ],
    );
  }
}

class Opponent {
  final String name;
  final List<String> robotImages;

  Opponent(this.name, this.robotImages);
}
