import 'dart:async';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/display_page.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key, required Map this.data});
  final Map data;
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final latController = TextEditingController();
  final longController = TextEditingController();
  late DatabaseReference dbRef;
  double latVal = 0.0;
  double longVal = 0.0;
  Timer? timer;
  int count = 0;
  @override
  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('users');
    getdata();
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      getdata();
      getRealData();
      getLocation();
    });
  }

  void getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latVal = position.latitude;
    longVal = position.longitude;
    print(position.latitude);
  }

  void getdata() {
    latController.text = latVal.toString(); //ดึงข้อมูลมาโชว์
    longController.text = longVal.toString();
    //longController.text = widget.data['long'];
  }

  void getRealData() {
    Map<String, String> user = {
      'lat': latController.text,
      'long': longController.text
    };
    dbRef.child(widget.data['key']).update(user); //เข้าถึง Child ของมันไปอัพเดท
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
          Text(latVal.toString()),
          Text(longVal.toString()),
          ElevatedButton(
              onPressed: () {
                getRealData();

                // Map<String, String> user = {
                //   'lat': latController.text,
                //   'long': longController.text
                // };
                // dbRef
                //     .child(widget.data['key'])
                //     .update(user); //เข้าถึง Child ของมันไปอัพเดท
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: ((context) => DisplayPage())));
              },
              child: Text("Insert"))
        ],
      )),
    );
  }
}
