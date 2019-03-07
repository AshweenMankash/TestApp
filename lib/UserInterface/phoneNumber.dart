import 'package:flutter/material.dart';
import 'package:flutter_app/BLoc/LogInBloc.dart';
import 'package:flutter_app/BLoc/UserBloc.dart';
import 'package:flutter_app/main.dart';

class PhoneNumberWidget extends StatefulWidget {
  PhoneNumberWidget({Key key}) : super(key: key);

  @override
  _PhoneNumberWidgetState createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  BaseAuth firebaseAuth;

  @override
  void initState() {
    super.initState();
    userBloc = new UserBloc();
    firebaseAuth = new FireBaseAuthentication();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: userBloc.phoneNumberErrorStream,
        builder: (context, snapShot) {
          return LayoutBuilder(builder: (context, display) {
            return Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              width: display.maxWidth,
              height: display.maxHeight,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: display.maxWidth * 0.7),
                      child: TextField(
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w100),
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        autofocus: true,
                        onChanged: (phoneNumber) {
                          userBloc.validatePhoneNumber(phoneNumber);
                          userBloc.phoneNumber.add(phoneNumber);
                        },
                        onSubmitted: (phoneNumber) {
                          if (snapShot.data == null) {
                            userBloc.phoneNumber.add(phoneNumber);
                            firebaseAuth.signWithPhoneNumber(
                                '+91' + userBloc.phoneNumber.value);
                          } else {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(snapShot.data)));
                          }
                        },
                        decoration: InputDecoration(
                            errorText: snapShot.data,
                            labelText: "Phone Number",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            prefixIcon: Icon(Icons.phone)),
                      ),
                    ),
                    FlatButton(
                      color: userBloc.phoneNumberError.value == null
                          ? Colors.green
                          : Colors.red,
                      onPressed: () {

                        if(snapShot.data==null){
                          firebaseAuth.signWithPhoneNumber('+91'+userBloc.phoneNumber.value);
                        }else{
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text(snapShot.data)));
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userBloc.dispose();
  }
}
