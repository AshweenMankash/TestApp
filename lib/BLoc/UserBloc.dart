import 'dart:async';
import 'dart:io';

import 'package:flutter_app/BLoc/BLoc.dart';
import 'package:flutter_app/BLoc/Validator.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc implements BLoc {
  BehaviorSubject<String> phoneNumber = BehaviorSubject<String>();
  BehaviorSubject<String> phoneNumberError = BehaviorSubject<String>();
  BehaviorSubject<File> image = BehaviorSubject<File>();

  Observable<String> get phoneNumberErrorStream => phoneNumberError.stream;

  validatePhoneNumber(String phoneNumber) {
    phoneNumberError.sink.add(Validator.validateMobile(phoneNumber));
  }

  @override
  void dispose() {
    phoneNumber.close();
    phoneNumberError.close();
    image.close();
  }
}
UserBloc userBloc;