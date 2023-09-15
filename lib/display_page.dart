import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/update_page.dart';

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
          userMap['key'] = snapshot.key;
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userMap['lat']),
                    Text(userMap['long']),
                  ],
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => UpdatePage(data: userMap))));
                },
                icon: Icon(Icons.edit))
          ],
        ),
      ),
    );
  }
}
