import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/display_page.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final latController = TextEditingController();
  final longController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DisplayPage()));
      }),
      body: SafeArea(
          child: Column(
        children: [
          TextField(
            controller: latController,
            decoration: InputDecoration(label: Text("Lat")),
          ),
          TextField(
            controller: longController,
            decoration: InputDecoration(label: Text("Long")),
          ),
          ElevatedButton(
              onPressed: () {
                Map<String, String> user = {
                  'lat': latController.text,
                  'long': longController.text
                };
                dbRef.push().set(user);
              },
              child: Text("Insert"))
        ],
      )),
    );
  }
}
