import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/BLoc/CameraBloc.dart';
import 'package:flutter_app/BLoc/FirebaseOperations.dart';

abstract class BaseAuth {
  Future<void> signWithPhoneNumber(String phoneNumber);
  signInWithPhoneNumberAndOtp(String otp);
  Future<void> signOut();
  Future<String> currentUser();
  Future<String> phoneNumber();
}


class FireBaseAuthentication implements BaseAuth {
  static String verID;
  FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  @override
  Future<String> currentUser() async {
    FirebaseUser fireBaseUser;
    try {
      fireBaseUser = await fireBaseAuth.currentUser();
      return fireBaseUser.uid;
    }
    catch(E){
    }
    return null;
  }

  @override
  Future<void> signWithPhoneNumber(String phoneNumber) async {
    await fireBaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 120),
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout);
  }

  final phoneVerificationCompleted = (FirebaseUser fireBaseUser)=>fireBaseOperations.fireBaseCRUD(cameraBloc.compressedImage.value, fireBaseUser.phoneNumber);
  final phoneVerificationFailed = (AuthException a) => print(a.message);
  final phoneCodeSent= (String verificationID,[int forceResend]) =>verID=verificationID;
  final phoneCodeAutoRetrievalTimeout = (String verificationId) => verID = verificationId;


  @override
  Future<String> phoneNumber() async{
    FirebaseUser user =await fireBaseAuth.currentUser();
    return user.phoneNumber;
  }

  @override
  signInWithPhoneNumberAndOtp(String otp) {
    FirebaseAuth.instance.signInWithPhoneNumber(verificationId: verID, smsCode: otp);
  }

  @override
  Future<void> signOut() {

    return null;
  }

}