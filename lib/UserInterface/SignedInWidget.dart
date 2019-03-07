import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/BLoc/FirebaseOperations.dart';
import 'package:firebase_storage_image/firebase_storage_image.dart';

class SignedInWidget extends StatefulWidget {
  @override
  _SignedInWidgetState createState() => _SignedInWidgetState();
}

class _SignedInWidgetState extends State<SignedInWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fireBaseOperations = FireBaseOperations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TestApp"),
        actions: <Widget>[
          FlatButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: fireBaseOperations.checkIfNew(),
            builder: (ctx, snapShot) {
              int visitCount;
              String url;
              if (snapShot.hasData) {
                if (snapShot.data.documents.isNotEmpty) {
                  visitCount = snapShot.data?.documents[0]["visit_count"];
                }
                return Center(
                  child: snapShot.data.documents.isEmpty
                      ? CircularProgressIndicator()
                      : Text(
                          visitCount == 1
                              ? "You Came First Time"
                              : "You Visited $visitCount times",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 20.0),
                        ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
