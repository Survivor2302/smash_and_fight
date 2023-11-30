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
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late String name; // Declare the name variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(widget.title),
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
                buildProposition(),
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

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(50),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
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
          return CachedNetworkImage(
            imageUrl: snapshot.data!.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: MediaQuery.of(context).size.width / 1.1,
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
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
    return TextButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(8.0),
          fixedSize: MaterialStateProperty.all<Size>(
            Size(100, 100), // Adjust the width and height as needed
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white
          ),
        ),
        onPressed: () {
          // Add your onPressed logic here
        },
        child: accept
            ? Icon(Icons.favorite, color: Colors.pink, size: 24.0)
            : Icon(Icons.delete_forever, color: Colors.pink, size: 24.0));
  }
}
