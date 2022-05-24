import 'package:carpooling/Res/images.dart';
import 'package:carpooling/Screens/signin/signin.dart';
import 'package:carpooling/Services/Apiconstant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 2),
        (() async {
         print(accesstoken);
          final prefs = await SharedPreferences.getInstance();
          final key = 'token';
          final value = prefs.get(key );
          print(value);
          if(value==null){
           Navigator.pushNamed(
              context, '/signin');
          }else{
            Navigator.pushNamed(
                context, '/Role');

         }
            })
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.tealAccent,
      body:
      Container(
        height: MediaQuery.of(context).size.height,
    padding: EdgeInsets.all(16),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: 300,),
      Text( "CarPooling",style:TextStyle(fontSize: 55,color:Colors.black,fontWeight: FontWeight.bold),),
        Expanded(
        child:
            Align(
              alignment: Alignment.bottomCenter,
              child: Image(image:optisollogo,width:170 ,),
          ))

        ]),
    ));
  }

}
