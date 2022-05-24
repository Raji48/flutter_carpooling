//import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:flutter/material.dart';


final kTitlestyle =  TextStyle(
  color: Colors.black87,  //0xffD50000
  fontSize: 24,
  fontFamily: 'ProximaNova-Bold',
 // fontWeight: FontWeight.bold,
);


final onboardtextstyle =  TextStyle(
  color: Colors.black87,  //0xffD50000
  fontSize: 24,
  fontFamily: 'ProximaNova-Medium',
  // fontWeight: FontWeight.bold,
);


final kSubtitlestyle = TextStyle(
  color:grey,
  fontSize: 15,
  fontFamily: 'ProximaNova-Regular'
);
final navstyle= TextStyle(color:grey);
final bottomnavstyle=TextStyle(color:black,);//fontSize: 14,fontFamily: 'ProximaNova-Bold');
final textmedium=TextStyle(fontSize: 16,fontFamily: 'ProximaNova-Medium',color: black);
final textsemibold=TextStyle(fontSize: 16,fontFamily: 'ProximaNova-Semibold',color: black);//ProximaNova-Semiboldstyle
final textstyle=TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold');
final appbartitle=TextStyle(fontFamily: 'ProximaNova-Regular',color:Colors.black87,fontWeight: FontWeight.bold,);
final topBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
));

final enableborder = OutlineInputBorder(
borderSide: BorderSide(
    color: lightgrey, width: 1.3),);

final focusborder= OutlineInputBorder(
    borderSide: BorderSide(
        color: tealaccent,width: 1.8 ));

final focusnumberborder=OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
    borderSide: BorderSide(
        color:green,width: 1.3 ));

final enablenumberborder=OutlineInputBorder(
borderRadius: BorderRadius.circular(15.0),
borderSide: BorderSide(
color: lightgrey, width: 1.0),);


