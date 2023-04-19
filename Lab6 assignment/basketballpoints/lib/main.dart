import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Basketball Points Counter',
      home: BasketballPointsCounter(),
    );
  }
}

class BasketballPointsCounter extends StatefulWidget {
  @override
  _BasketballPointsCounterState createState() =>
      _BasketballPointsCounterState();
}

class _BasketballPointsCounterState extends State<BasketballPointsCounter> {
  int teamAScore = 0;
  int teamBScore = 0;

  void incrementTeamAScore(int points) {
    setState(() {
      teamAScore += points;
    });
  }

  void incrementTeamBScore(int points) {
    setState(() {
      teamBScore += points;
    });
  }

  void resetScores() {
    setState(() {
      teamAScore = 0;
      teamBScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basketball Points Counter'),
        backgroundColor: Color.fromARGB(
            255, 2, 55, 99), // Set the background color to bluemarine
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Team A',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '$teamAScore',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => incrementTeamAScore(1),
                      child: Text('+1 POINT'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => incrementTeamAScore(2),
                      child: Text('+2 POINTS'),
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.blue, // Set the background color to blue
                        onPrimary: Colors.white, // Set the text color to white
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => incrementTeamAScore(3),
                      child: Text('+3 POINTS'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
                Divider(color: Color.fromARGB(255, 14, 13, 13)),
                Column(
                  children: [
                    Text(
                      'Team B',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '$teamBScore',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => incrementTeamBScore(1),
                      child: Text('+1 POINT'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => incrementTeamBScore(2),
                      child: Text('+2 POINTS'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => incrementTeamBScore(3),
                      child: Text('+3 POINTS'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        onPrimary: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetScores,
              child: Text('Reset Scores'),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey, // Set the background color to grey
                onPrimary: Colors.white, // Set the text color to white
              ),
            ),
          ],
        ),
      ),
    );
  }
}
