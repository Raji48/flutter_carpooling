import 'dart:io';

import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/veh_account/account.dart';
import 'package:carpooling/Screens/veh_dashboard/dashboard.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/owner_dashboard.dart';
import 'package:carpooling/Screens/veh_notification/notification.dart';
import 'package:carpooling/Screens/veh_trips/mytrips.dart';
import 'package:carpooling/Utilis/style.dart';

import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex =0;
  List<Widget> _children=[

   Ownerdashboard(),
    Mytrips(),
    Notifications(),
    Account()
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

      child: Scaffold(
      body:_children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: black,
        selectedLabelStyle: bottomnavstyle,
        unselectedLabelStyle:navstyle,
        unselectedItemColor: grey,
        type: BottomNavigationBarType.fixed,
          onTap: onTappedbar,
          currentIndex: _currentIndex,
          items:[
            BottomNavigationBarItem(
                icon:Image(image: dashboardicon,color: grey,width: 20,height: 20,),
                activeIcon:new Image(image:dashicon,width: 20,height: 20,),
                title:Text(dasboard,)),
             BottomNavigationBarItem(
               icon:Image(image: mytripsicon,color: grey,width: 30,height: 20,),
               activeIcon:new Image(image:tealcaricon,width: 30,height: 20),
              title:Text(mytrips,),),
            BottomNavigationBarItem(
                icon:Image(image: notificationicon,color: grey,width: 20,height: 20,),
                activeIcon:new Image(image:notiicon,width: 20,height: 20),
                title:Text(notifications)),
            BottomNavigationBarItem(
                icon:Image(image: accounticon,color: grey,width: 20,height: 20,),
                activeIcon:new Image(image:accicon,width: 20,height: 20),
                title:Text(account,)),
          ],
      ),
    ));
  }
}


