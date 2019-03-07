import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/BLoc/CameraBloc.dart';
import 'package:flutter_app/BLoc/ImageOperations.dart';
import 'package:flutter_app/BLoc/RootAppBloc.dart';
import 'package:image_picker/image_picker.dart';
class CameraWidget extends StatefulWidget {
  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {

  File _image,_compressed;
  ImageOperations imageOperations;
   getImage()async{
    var image;
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    _image = image;
    if(_image!=null){
     cameraBloc.image.sink.add(_image);
      bloc.phoneNumberWidget.add(true);
    }
    }

  @override
  void initState() {
    super.initState();
    imageOperations = ImageOperations();
    cameraBloc = CameraBloc();
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            StreamBuilder<File>(
            stream:cameraBloc.compressedImage
            ,builder: (ctx,snapshot){
              if(snapshot.hasData){
                return Image.file(snapshot.data,width:200 ,height: 400.0,);
              }
              return Container(
                width: 200.0,
                  height: 400.0,
                color: Colors.black12,
                child: Center(
                  child: Icon(Icons.camera),
                ),
              );
            }),
            Container(
              child: FlatButton(
                  color: Colors.red,
                  onPressed: (){
                getImage();
              }, child: Text(_image==null?"Capture":"Capture Again",style: TextStyle(color: Colors.white),)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
