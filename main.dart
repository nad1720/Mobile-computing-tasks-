import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Application',
      home: Scaffold(
        appBar: AppBar(
          title: Text('First Application'),
          backgroundColor: Colors.black,

        ),
        body: Center(
          child: Text('🖤🦋🖤Alaa Refaat Ahmed🖤🦋🖤'),
        ),
      ),
    );
  }
}