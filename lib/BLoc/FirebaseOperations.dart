import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class Cloud {
  Future<bool> fireBaseCRUD(File image, String phoneNumber);

  Stream<QuerySnapshot> checkIfNew();
}


class FireBaseOperations extends Cloud {
  File file;
  String phoneNumber;

  FireBaseOperations() {
    getPhoneNumber();
  }

  getPhoneNumber() async {
    phoneNumber = await FirebaseAuth.instance.currentUser().then((fu) {
      print(fu.phoneNumber.substring(3));
      return fu.phoneNumber;
    });
  }

  @override
  checkIfNew() {
    return Firestore.instance
        .collection("visitors")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .snapshots();
  }

  @override
  Future<bool> fireBaseCRUD(File image, String phoneNumber) async {


    try{

      var downloadURL = await uploadImage(image);
      print(downloadURL.toString());

      Firestore.instance
          .collection("visitors")
          .where("phoneNumber", isEqualTo: phoneNumber)
          .getDocuments()
          .then((q) {

            DocumentReference documentReference = Firestore.instance.collection("visitors").document();

        if (q.documents.isEmpty) {
          print("isZero");
          Firestore.instance.collection("visitors").document().setData({
              "phoneNumber": phoneNumber,
              "downloadURL": downloadURL.toString(),
              "visit_count":1
            });
          }

        else{
            int visitCount = q.documents[0].data["visit_count"];
            visitCount++;
            Firestore.instance.collection("visitors").document(q.documents[0].documentID).updateData({"visit_count":visitCount});
        }
      });

      return true;
    } catch (w) {
      return false;
    }
  }

  Future<String> uploadImage(File image)async{
    FirebaseStorage fireBaseStorage = FirebaseStorage.instance;
    StorageReference storageReference = fireBaseStorage.ref().child("$phoneNumber");

    try {
      StorageUploadTask upload = storageReference.putFile(image);
      return await upload.onComplete.then((s)async {
        return await storageReference.getDownloadURL();
      });

    }catch(e){
      print("Image Uploading Failed");
    }
  return null;
  }
}

FireBaseOperations fireBaseOperations;
