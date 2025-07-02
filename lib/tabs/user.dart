import 'package:flutter/material.dart';

class User extends StatefulWidget {
  const User({Key? key, String? title}) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0), 
      child: Text(
        'Hello World',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 50
        )
      )
    );
  }
}