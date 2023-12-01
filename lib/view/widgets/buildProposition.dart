import 'package:flutter/material.dart';
import 'package:smash_and_fight/model/robot.dart';
import '../../helper/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildPropositionWidget extends StatefulWidget {
  final Robot? robot;

  const BuildPropositionWidget({Key? key, this.robot}) : super(key: key);

  @override
  State<BuildPropositionWidget> createState() => _BuildPropositionWidgetState();
}

class _BuildPropositionWidgetState extends State<BuildPropositionWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Robot>>(
      future: getTwoRobots(widget.robot),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final robot = snapshot.data!;
          return Container(
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: robot.first.imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 1.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black.withOpacity(0.6),
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
                          Colors.black.withOpacity(0.0), // transparent at the top
                          Colors.black.withOpacity(0.8), // opaque at the bottom
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
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

