import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smash_and_fight/model/user.dart';
import 'package:smash_and_fight/view/smashview.dart';
import 'package:smash_and_fight/viewmodel/robotviewmodel.dart';

class UsernameInputPage extends StatefulWidget {
  const UsernameInputPage({Key? key}) : super(key: key);

  @override
  _UsernameInputPageState createState() => _UsernameInputPageState();
}

class _UsernameInputPageState extends State<UsernameInputPage> {
  final TextEditingController _usernameController = TextEditingController();
  late RobotViewModel robotViewModel;

  @override
  void initState() {
    super.initState();
    robotViewModel = Provider.of<RobotViewModel>(context, listen: false);
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Entre ton prénom ',
              style: TextStyle(
                fontSize: 30,
                color:  Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,

              ),
            ),
            SizedBox(height: 60),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Prénom...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                fillColor: Color(0xFFeaeaea),
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                robotViewModel.user = User(name: _usernameController.text);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(
                      title: 'Smash&Fight',
                    ),
                  ),
                );
              },
              child:   Text(
              'Valider',
              style: TextStyle(
                color:  Colors.black,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,

              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}