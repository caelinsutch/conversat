import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      child: Center(
        child: RaisedButton(
          child: Text('Signup'),
          onPressed: () => {
            Navigator.pushNamed(context, '/signup')
          },
        ),
      ),
    ),
  );
}}
