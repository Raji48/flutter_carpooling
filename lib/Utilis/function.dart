import 'dart:typed_data';

import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;


String validatename(value){
  if(value.isEmpty){
    return "Please enter firstname";
   }
   return null;
}
String validatelname(value){
  if(value.isEmpty){
    return "Please enter lastname";
  }/*if(!RegExp("[a-zA-Z]+\\.?").hasMatch(value)) {
    return "Please Enter  alphabets ";
  }*/
  return null;
}
String validatephone(value) {
  if (value.isEmpty) {
    return "Please enter phonenumber";
  }
  if (value.length == 10) {
    return null;
  } else {
    return "Please enter valid phonenumber";
  }
}
String validatephonenew(value) {
  if (value.isEmpty) {
    return "Please enter PhoneNumber";
  }
  if (value.length == 13) {
    return null;
  }else if (value.length == 10) {
    return null;
  }
  else {
    return "Please enter valid phoneNumber";
  }
}

String validateemail(value){
 if(value.isEmpty){
     return "Please enter email";
  }
  if(!RegExp("^[a-zA-Z0-9+_.-]+@optisolbusiness+.com").hasMatch(value)){
     return "Please enter valid email";
  }
  return null;
}

  String validatepass(value){
     if(value.isEmpty){
        return "Please enter password";
      } if(!RegExp( r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$').hasMatch(value)){
           return "Password length should be 6-10,at least one upper case,\nlower case,digit and Special character";
     }
     else if(value.length<6){
       return "Should be At Least 6 characters";
     }else if(value.length>10) {
       return "Should not be more than 10 characters";
     }
return null;
}


String validatepasss(value){
  if(value.isEmpty){
    return "Please enter password";
  }
  return null;
}


String validatechangepass(value){
  if(value.isEmpty){
    return "Please enter password";
  } if(!RegExp( r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$').hasMatch(value)){
    return "Please enter valid password";
  }
  else if(value.length<6){
    return "Should be At Least 6 characters";
  }else if(value.length>10) {
    return "Should not be more than 10 characters";
  }
  return null;
}

String validateotp(value) {
  if (value.isEmpty) {
    return "";
  }if(!RegExp(("^[0-9]")).hasMatch(value)){
    return"";
  }
  if (value.length != 1) {
    return "";
  }
  return null;
}


String validatefield(value){
  if(value.isEmpty){
    return "This field is Required ";
  }
  return null;
}

InputDecoration buildInputDecoration(String labeltext,) {
  return InputDecoration(
    labelText: labeltext,
    labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),
    focusedBorder:focusborder,
    border:enableborder,
    enabledBorder:enableborder
  );
}

InputDecoration buildOtpDecoration() {
  return InputDecoration(
    filled: true,
    fillColor:whitelight,
    enabledBorder: focusnumberborder,//enablenumberborder,
    focusedBorder: focusnumberborder,
    border: enablenumberborder,
  );
}

Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width, int height) async {
  final Uint8List imageData = await getBytesFromAsset(path, width,height);
  return BitmapDescriptor.fromBytes(imageData);
}

Future<Uint8List> getBytesFromAsset(String path, int width,int height) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width,targetHeight: height);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}