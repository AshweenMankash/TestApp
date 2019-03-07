import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/BLoc/BLoc.dart';
import 'package:flutter_app/BLoc/UserBloc.dart';
import 'package:flutter_app/BLoc/RootAppBloc.dart';
import 'package:flutter_app/UserInterface/CameraWidget.dart';
import 'package:flutter_app/UserInterface/SignedInWidget.dart';
import 'package:flutter_app/UserInterface/SignedOutWidget.dart';
import 'package:flutter_app/UserInterface/phoneNumber.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shyft-ppm',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RootWidget(),
    );
  }
}

class RootWidget extends StatefulWidget {
  @override
  _RootWidgetState createState() => _RootWidgetState();
}

class _RootWidgetState extends State<RootWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = RootAppBloc();
  }

  hey() {
    FirebaseAuth.instance.onAuthStateChanged.listen((Fu) {
      print("Changed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SignedInWidget();
              }
              return SignedOutWidget();
            }));
  }
}
