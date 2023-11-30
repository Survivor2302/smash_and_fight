import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:smash_and_fight/model/robot.dart';

import 'utils.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(title: 'Smash&Fight'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Center(
            child: Image.asset('images/Logo.png', height: 50.0),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSelectedBot('text1'),
                buildSelectedBot('text2'),
                buildSelectedBot('text3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Draggable(
                    child: buildProposition(), feedback: buildProposition())
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildSwipeWidget(false),
                buildSwipeWidget(true),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedBot(String text) {
    String imageUrl = 'https://robohash.org/$text';

    return Material(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
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

  Widget buildProposition() {
    return FutureBuilder<Robot>(
      future: getRandomRobot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No data available');
        } else {
          final randomColor = Color(Random().nextInt(0xffffffff));

          return CachedNetworkImage(
            imageUrl: snapshot.data!.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                color: randomColor,
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Widget buildSwipeWidget(bool accept) {
    return Material(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(80.0),
      ),
      child: TextButton(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
            Size(80, 80),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
            Colors.white,
          ),
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
        ),
        onPressed: () {
          // Add your onPressed logic here
        },
        child: accept
            ? Icon(Icons.favorite, color: Colors.pink, size: 24.0)
            : Icon(Icons.delete_forever, color: Colors.pink, size: 24.0),
      ),
    );
  }
}
