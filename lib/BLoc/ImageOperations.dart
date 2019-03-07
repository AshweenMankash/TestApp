import 'dart:async';
import 'dart:io';
import 'package:flutter_native_image/flutter_native_image.dart';
class ImageOperations{

  static Future<File> compressImage(File image)async{
    if(image==null){
      print("No Image");
    }
    try {
     return await FlutterNativeImage.compressImage(
          image.path, quality: 50,
          percentage: 0,
          targetHeight: 500,
          targetWidth: 300);
    }catch(e){
      print("Error");
      return null;
    }
  }
}