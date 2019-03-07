import 'package:flutter/material.dart';
import 'package:flutter_app/BLoc/RootAppBloc.dart';
import 'package:flutter_app/UserInterface/CameraWidget.dart';
import 'package:flutter_app/UserInterface/phoneNumber.dart';

class SignedOutWidget extends StatefulWidget {
  @override
  _SignedOutWidgetState createState() => _SignedOutWidgetState();
}

class _SignedOutWidgetState extends State<SignedOutWidget> {
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = RootAppBloc();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("TestApp"),
      ),
      body: Stack(
        children:<Widget>[

        CameraWidget(),
        StreamBuilder(
            stream: bloc.phoneNumberWidgetStream,
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data
                    ? PhoneNumberWidget()
                    : Container();
              } else {
                return Container();
              }
            }),
        ]
      ),
    );
  }
}
