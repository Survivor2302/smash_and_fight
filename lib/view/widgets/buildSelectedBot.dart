import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smash_and_fight/model/robot.dart';

class SelectedBotWidget extends StatelessWidget {
  final Robot? robot;

  const SelectedBotWidget({Key? key, this.robot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Material(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: CachedNetworkImage(
        imageUrl: robot!.imageUrl,
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
}
