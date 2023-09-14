import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/display_page.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  late DatabaseReference dbRef;

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('user');
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
            controller: nameController,
            decoration: InputDecoration(label: Text("Name")),
          ),
          TextField(
            controller: ageController,
            decoration: InputDecoration(label: Text("Age")),
          ),
          ElevatedButton(
              onPressed: () {
                Map<String, String> user = {
                  'name': nameController.text,
                  'age': ageController.text
                };
                dbRef.push().set(user);
              },
              child: Text("Insert"))
        ],
      )),
    );
  }
}
