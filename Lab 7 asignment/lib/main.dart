import 'package:flutter/material.dart';
import 'home_page.dart';
import 'family_members_page.dart';

void main() {
  runApp(LanguageLearningApp());
}

class LanguageLearningApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language Learning App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/family-members': (context) => FamilyMembersPage(),
      },
    );
  }
}