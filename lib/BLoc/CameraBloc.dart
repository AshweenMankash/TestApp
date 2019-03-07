import 'dart:async';
import 'dart:io';

import 'package:flutter_app/BLoc/BLoc.dart';
import 'package:flutter_app/BLoc/ImageOperations.dart';
import 'package:rxdart/rxdart.dart';

class CameraBloc extends BLoc{

  BehaviorSubject<File> image = BehaviorSubject<File>();
  Observable<File> get imageStream => image.stream;

  BehaviorSubject<File> compressedImage = BehaviorSubject<File>();
  Observable<File> get compressedImageStream => compressedImage.stream;


  CameraBloc(){
    image.listen((image)=>compress(image));
  }

  compress(File image)async{
    compressedImage.value = await ImageOperations.compressImage(image);
  }

  @override
  void dispose() {
    image.close();
    compressedImage.close();
  }

}


CameraBloc cameraBloc ;