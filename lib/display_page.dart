import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  Query refQ =
      FirebaseDatabase.instance.ref().child('users'); //ตำแหน่งที่เก็บข้อมูล
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FirebaseAnimatedList(
        query: refQ,
        itemBuilder: (context, snapshot, animation, index) {
          Map userMap = snapshot.value as Map;
          return ShowDisplay(userMap: userMap);
        },
      )),
    );
  }
}

class ShowDisplay extends StatelessWidget {
  const ShowDisplay({
    super.key,
    required this.userMap,
  });

  final Map userMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(userMap['name']),
        Text(userMap['age']),
      ],
    );
  }
}
