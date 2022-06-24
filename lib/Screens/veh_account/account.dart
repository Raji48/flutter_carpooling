
import 'dart:io';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/profile/profile.dart';
import 'package:carpooling/Screens/profile/vehicledetails.dart';
import 'package:carpooling/Services/ApiTypes.dart';
import 'package:carpooling/Services/Apiconstant.dart';
import 'package:carpooling/Services/index.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:shared_preferences/shared_preferences.dart';
class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
bool img=true;

File _displayImage;
String tokenvalue;

@override
  Future<void> initState()  {
  _download();
  super.initState();
 }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(account, style: TextStyle(fontFamily: 'ProximaNova-Medium',
          color:black,fontSize: 20,
          )),
        automaticallyImplyLeading: false,),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.all(17),
                      child: Column(
                          children: <Widget>[
                            SizedBox(height: 20,),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (
                                      context) => Profile()));

                                  print(userid);
                                },
                                child: Container(
                                  color: white,
                                  child: Row(
                                      children: <Widget>[
                                        new Flexible(
                                            child: Column(
                                                children: <Widget>[
                                                  Align(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child:
                                                       CircleAvatar(
                                                          child: ClipOval(
                                                            child:  _displayImage != null ? Image.file(_displayImage) : Image(image: NetworkImage("https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg"),)
                                                             ),
                                                           radius: 20.0,

                                                           )) ,

                                                  Align(
                                                      alignment: Alignment
                                                          .topLeft,
                                                      child:
                                                      Text(myprofile,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily: 'ProximaNova-Regular',
                                                            color: black),))
                                                ])),
                                        new Flexible(
                                            child: Align(
                                                alignment: Alignment.topRight,
                                                child: Icon(Icons
                                                    .arrow_forward_ios_sharp,color: grey,))),
                                      ]),
                                )),
                            SizedBox(height: 40,),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (
                                      context) => Vehicledetails()));
                                },
                                child: Container(
                                    child: Row(
                                        children: <Widget>[
                                          new Flexible(
                                              child: Column(
                                                  children: <Widget>[
                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child:Image(image: blackcar,width: 38,height: 30,)
                                                    ),

                                                    Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text(
                                                        vehicledetails,
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily: 'ProximaNova-Regular',
                                                            color: black),),)
                                                  ])),
                                          new Flexible(
                                              child: Align(
                                                  alignment: Alignment.topRight,
                                                  child: Icon(Icons
                                                      .arrow_forward_ios_sharp,color: grey,))),
                                        ])
                                )),
                          ]
                      ))))),



    );
  }


Future<File> _download() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key ) ;
  print(value);
  var url = Uri.parse(PROFILE_PICTURE);
  final response = await http.get(url,
    headers: {
      'Authorization': 'jwt $value'
    },
  );

  if (response.statusCode == 200) {
    print(response.statusCode);
    final imageName = path.basename(PROFILE_PICTURE);
    final appDir = await pathProvider.getApplicationDocumentsDirectory();

    // This is the saved image path
    // You can use it to display the saved image later.
    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

    setState(() {
    _displayImage = imageFile;
    });

  }else{
    _displayImage =null;
  }
}


}
