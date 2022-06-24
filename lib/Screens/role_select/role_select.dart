import 'dart:io';
import 'package:carpooling/Actions/profile_action.dart';
import 'package:carpooling/Actions/veh_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/profiledetail/profiledetail_model.dart';
import 'package:carpooling/Model/vehicledetail/vehicledetail_model.dart';
import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/home_commuter/homecommuter.dart';
import 'package:carpooling/Screens/home_vehicle/home.dart';
import 'package:carpooling/Screens/veh_dashboard/dashboard.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Role extends StatefulWidget {
  @override
  _RoleState createState() => _RoleState();
}

class _RoleState extends State<Role> {
  bool x = true;
  bool issave = false;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VehicleProps>(
        converter: (store) => mapStateeToProps(store),
        builder: (context, props) {
          if (props.loading) {
            issave = true;
          }

          if (props.loading_user) {
            issave = true;
          } else if (props.error_user != null) {
            issave = false;
            print("user not exist");
            print(props.error_user);
          } else if (props.userdata_user != null) {
            issave = false;
            username = props.userdata_user.user.firstName.toString() +
                "\t" +
                props.userdata_user.user.lastName.toString();
          }

          return WillPopScope(
              onWillPop: () {
                exit(0);
              },
              child: Scaffold(
                  backgroundColor: Colors.white,
                  resizeToAvoidBottomInset: true,
                  body: Stack(children: [
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: SafeArea(
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: getDeviceheight(context, 0.04),
                                    left: 15,
                                    right: 15,
                                    bottom: getDeviceheight(context, 0.09)),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        selectrole,
                                        style: TextStyle(
                                            fontFamily:
                                                'ProximaNova-Semiboldstyle',
                                            fontSize: 24,
                                            color: black),
                                      ),
                                      SizedBox(
                                          height:
                                              getDeviceheight(context, 0.01)),
                                      Text(
                                        howusecarpooling,
                                        style: kSubtitlestyle,
                                      ),
                                      SizedBox(
                                          height:
                                              getDeviceheight(context, 0.01)),
                                      GestureDetector(
                                          onTap: () {
                                            if (!x) {
                                              setState(() {
                                                x = !x;
                                              });
                                            }

                                          },
                                          child: Container(
                                              child: Stack(children: <Widget>[
                                            Container(
                                              width: double.infinity,
                                              height: getDeviceheight(
                                                  context, 0.30),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: x
                                                      ? greenlight
                                                      : greyborder,
                                                  width: 3,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)),
                                              ),

                                              child: Row(children: <Widget>[
                                                new Flexible(
                                                  child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[
                                                        Center(
                                                            child: Text(
                                                          'As a',
                                                          style: TextStyle(fontSize: 14, color: grey, fontWeight: FontWeight.bold,
                                                              fontFamily: 'ProximaNova-Regular'),
                                                        )),
                                                        Center(
                                                            child: Text(
                                                                'Commuter',style: TextStyle(color: black, fontSize: 20, fontFamily: 'ProximaNova-Bold',))),
                                                      ]),
                                                ),
                                                new Flexible(
                                                    child: Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Container(
                                                          width: getDevicewidth(context, 12),
                                                          child: Image(
                                                            image: comuter,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ))),
                                              ]),
                                            ),

                                            if (x) tick(), //clr()
                                          ]))),
                                      SizedBox(
                                          height:
                                              getDeviceheight(context, 0.01)),
                                      GestureDetector(
                                        onTap: () {
                                          props.profileapi_user();
                                          if (x) {
                                            setState(() {
                                              x = !x;
                                            });
                                          }
                                        },
                                        child: Container(
                                            child: Stack(children: <Widget>[
                                          Container(
                                            width: double.infinity,
                                            height: getDeviceheight(context, 0.30),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: !x
                                                      ? greenlight
                                                      : greyborder,
                                                  width: 3),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),

                                            child: Row(children: <Widget>[
                                              new Flexible(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Center(
                                                          child: Text(
                                                        'As a',
                                                        style: TextStyle(fontSize: 14, color: grey, fontWeight: FontWeight.bold,
                                                            fontFamily: 'ProximaNova-Regular'),
                                                      )),
                                                      // Center(
                                                      Text('Vehicle Owner',
                                                          style: TextStyle(
                                                            color: black,
                                                            fontSize: 20,
                                                            fontFamily:
                                                                'ProximaNova-Bold',
                                                          )),
                                                    ]),
                                              ),
                                              new Flexible(
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        width: getDevicewidth(
                                                            context, 12),
                                                        child: Image(
                                                          image: veh_owner,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ))),
                                            ]),
                                          ),
                                          if (!x) tick(),
                                        ])),
                                      ),
                                      SizedBox(
                                          height:
                                              getDeviceheight(context, 0.01)),
                                      new Flexible(
                                          child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height:
                                                getDeviceheight(context, 0.07),
                                            shape: CircleBorder(),
                                            child: RaisedButton(
                                                color: tealaccent,
                                                onPressed: () async {
                                                  final prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  final key = 'token';
                                                  final value =
                                                      prefs.get(key) ?? 0;
                                                  print(value);
                                                  if (!x) {
                                                    try {
                                                      setState(
                                                          () => issave = true);
                                                      var url = Uri.parse(
                                                          BASE_URL +
                                                              VEHICLE_DETAIL);
                                                      var response = await http
                                                          .get(url, headers: {
                                                        'Authorization':
                                                            'jwt $value'
                                                      });
                                                      print(response.body);
                                                      if (response.statusCode ==
                                                              200 ||
                                                          response.statusCode ==
                                                              201) {
                                                        setState(() =>
                                                            issave = false);
                                                        print("successful");
                                                        print(response.body);
                                                        print(response
                                                            .statusCode);
                                                        //  Navigator.pop(context);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Home()));
                                                      } else if (response
                                                              .statusCode >
                                                          200) {
                                                        setState(() =>
                                                            issave = false);
                                                        print(response
                                                            .statusCode);
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Dashboard()));
                                                      }
                                                    } catch (e) {
                                                      issave = false;
                                                    }
                                                  }

                                                  if (x)

                                                    // Navigator.popAndPushNamed(context, '/home');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Homecommuter()),
                                                    );
                                                },
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: black,
                                                ))),
                                      )),
                                    ])))),
                    issave
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            color: Colors.black26,
                            child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: CircularProgressIndicator(),
                                )))
                        : Container(),
                  ])));
        });
  }

  tick() {
    return Positioned(
        bottom: 45,
        left: 88,
        child: Image(image: tickicon, width: 25, height: 25));
  }
}

class VehicleProps {
  final bool loading;
  final dynamic error;
  final Vehicledetail posts;
  final Function vehicleapi;

  final bool loading_user;
  final dynamic error_user;
  final Profiledetails userdata_user;
  final Function profileapi_user;

  VehicleProps(
      {this.loading,
      this.error,
      this.posts,
      this.vehicleapi,
      this.loading_user,
      this.error_user,
      this.userdata_user,
      this.profileapi_user});
}

VehicleProps mapStateeToProps(Store<AppState> store) {
  return VehicleProps(
    loading: store.state.postsState.loading,
    error: store.state.postsState.error,
    posts: store.state.postsState.posts,
    vehicleapi: () => store.dispatch(vehicledata()),
    loading_user: store.state.profdetails.loading,
    error_user: store.state.profdetails.error,
    userdata_user: store.state.profdetails.userdata,
    profileapi_user: () => store.dispatch(profiledata()),
  );
}

