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
      FirebaseDatabase.instance.ref().child('user'); //ตำแหน่งที่เก็บข้อมูล
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FirebaseAnimatedList(
        query: refQ,
        itemBuilder: (context, snapshot, animation, index) {
          String userString = snapshot.value as String;
          return Text(userString);
        },
      )),
    );
  }
}
