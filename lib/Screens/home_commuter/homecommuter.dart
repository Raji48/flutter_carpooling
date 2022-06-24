import 'dart:io';

import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/com_notification/commuternotification.dart';
import 'package:carpooling/Screens/com_ride/commuterride.dart';
import 'package:carpooling/Screens/com_trips/commutertrips.dart';
import 'package:carpooling/Screens/profile/profile.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
class Homecommuter extends StatefulWidget {
  @override
  _HomecommuterState createState() => _HomecommuterState();
}

class _HomecommuterState extends State<Homecommuter> {
  int _currentIndex =0;
  List<Widget> _children=[
    Commuterride(),
    Commutertrips(),
    Commuternotification(),
    Profile()
  ];
  void onTappedbar(int index)
  {
    setState(() {
      _currentIndex=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){
          if(_currentIndex>0){
            setState(() {
              _currentIndex=0;
            });
          }else{
            Navigator.pop(context);
          }
      },
    child:Scaffold(
      body:_children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: black,
        unselectedItemColor: grey,
       selectedLabelStyle: bottomnavstyle,
        unselectedLabelStyle:navstyle,
        type: BottomNavigationBarType.fixed,
        onTap: onTappedbar,
        currentIndex: _currentIndex,
        items:[
          BottomNavigationBarItem(
             icon:Image(image: rideicon,color: grey,width: 20,height: 20,),
              activeIcon:new Image(image:rideeicon,width: 20,height: 20,),
              title:Text(ride,)),

          BottomNavigationBarItem(
            icon:Image(image: mytripsicon,color: grey,width: 30,height: 20,),
            activeIcon:new Image(image:tealcaricon,width: 30,height: 20),
            title:Text(mytrips),),

          BottomNavigationBarItem(
              icon:Image(image: notificationicon,color: grey,width: 20,height: 20,),
              activeIcon:new Image(image:notiicon,width: 20,height: 20),

              title:Text(notifications,)),
          BottomNavigationBarItem(
              icon:Image(image: accounticon,color: grey,width: 20,height: 20,),
              activeIcon:new Image(image:accicon,width: 20,height: 20),

              title:Text(profile,)),
        ],
      ),
    ));
  }
}
