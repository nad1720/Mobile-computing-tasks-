import 'package:flutter/material.dart';

void main() {
  runApp(BirthdayCardApp());
}

class BirthdayCardApp extends StatelessWidget {
  const BirthdayCardApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Card',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Birthday Card'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Happy Birthday !!',
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Image.asset(
                'images/birth.png',
                height: 300.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
