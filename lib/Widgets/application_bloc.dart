

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseAlertDialog  {

  static showLoginAlert(iconName, alertMsg){

    //  set up the buttons
    Widget loginButton = FlatButton(
      child: Text("Login"),
      onPressed:  () {
        // removePrefer();
        // removeConstant();
        // Future.delayed(const Duration(milliseconds: 100), (){
        //   navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => route.isFirst);
        // });
      },
    );

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed:  () {
        // Future.delayed(const Duration(milliseconds: 100), (){
        //   navigatorKey.currentState.pop();
        // });
      },
    );

    Widget installButton = FlatButton(
      child: Text("install"),
      onPressed:  () {
        //   OpenAppstore.launch(androidAppId: "com.usa.albert", iOSAppId: "1502198563");
      },
    );

    // set up the AlertDialog
    // CupertinoAlertDialog alert = CupertinoAlertDialog(
    //   title: Icon(iconName, color: red, size: 45,),
    //   content: Text(alertMsg, style: TextStyle(fontFamily: 'MavenBold',fontSize: 20, color: black),),
    //   actions: [
    //     alertMsg == versionForceMsg ? installButton : alertMsg == invalidTokenMsg ? loginButton : okButton,
    //   ],
    // );

    // showDialog(
    //   context: navigatorKey.currentState.overlay.context,
    //   builder: (BuildContext context) {
    //     return WillPopScope(
    //       onWillPop: (){
    //         return;
    //       },
    //       child: alert,
    //     );
    //   },
    //   barrierDismissible: false,
    // );
  }

}
/*import 'package:carpooling/Widgets/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Applicationbloc with ChangeNotifier {

  final geoLocatorService = GeolocatorService();

  //variables
  Position currentLocation;

  Applicationbloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();
  }
}*/