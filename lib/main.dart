
import 'dart:async';
import 'package:carpooling/Logger/logger.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Screens/signin/signin.dart';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'Reducers/app_reducer.dart';
import 'Routes/routes.dart';
import 'Screens/splash/splash.dart';
import 'Services/Apimiddleware.dart';


final navigatorKey = GlobalKey<NavigatorState>();
void main() {

  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  _MyAppState createState()=>_MyAppState();

}

class _MyAppState extends State<MyApp> {

  final store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, apiMiddleware, ],
  );
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StoreProvider(
      store: this.store,
  child: MaterialApp(
   builder: (context, child) {
      return MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0), child: child);
    },
    navigatorKey: navigatorKey,
    initialRoute: '/splash',
    onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    //  home: Splash(),
      )
    );
  }

}


