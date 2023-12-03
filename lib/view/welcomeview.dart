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
  TextEditingController _usernameController = TextEditingController();
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
        title: Text('Enter Your Username'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
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
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
