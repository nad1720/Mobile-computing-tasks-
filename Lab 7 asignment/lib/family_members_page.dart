import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class FamilyMembersPage extends StatefulWidget {
  @override
  _FamilyMembersPageState createState() => _FamilyMembersPageState();
}

class _FamilyMembersPageState extends State<FamilyMembersPage> {
  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Family Members'),
        backgroundColor: Colors.brown[500],
      ),
      body: Container(
        padding: EdgeInsets.all(0.0),
        child: ListView(
          children: [
            ListTile(
              tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_son.png'),
                title: Text('Musuko'),
                subtitle: Text('Son'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/son.wav');
                }
                ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_daughter.png'),
                title: Text('Musume'),
                subtitle: Text('Daughter'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/daughter.wav');
                }
            ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_older_sister.png'),
                title: Text('Ane'),
                subtitle: Text('Older sister'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/oldersister.wav');
                }
            ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_younger_brother.png'),
                title: Text('Ototo'),
                subtitle: Text('Younger brother'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/youngerbrother.wav');
                }
            ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_younger_sister.png'),
                title: Text('Imoto'),
                subtitle: Text('Younger sister'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/youngersister.wav');
                }
            ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_father.png'),
                title: Text('Chichioya'),
                subtitle: Text('Father'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/father.wav');
                }
            ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_mother.png'),
                title: Text('Hahaoya'),
                subtitle: Text('Mother'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/mother.wav');
                }
            ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_grandfather.png'),
                title: Text('Ojisan'),
                subtitle: Text('Grandfather'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/grandfather.wav');
                }
            ),
            ListTile(
                tileColor: Colors.green,
                leading: Image.asset('assets/images/family_members/family_grandmother.png'),
                title: Text('O bachan'),
                subtitle: Text('Grandmother'),
                trailing: Icon(Icons.play_arrow,color: Colors.black87,),
                onTap: () {
                  player.play('assets/sounds/family_members/grandmother.wav');
                }
            ),

          ],
        ),
      ),
    );
  }
}