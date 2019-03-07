import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/BLoc/UserBloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
class FireStoreBloc{
  Firestore fireStore;
  CollectionReference visitor;
  FireStoreBloc(){
    visitor = Firestore.instance.collection("Visitor");
  }

  Query getPerson(){
    return visitor.where("phoneNumber",isEqualTo:userBloc.phoneNumber.value);
  }


}


class StorageOperations{

  hey(){
  }

}