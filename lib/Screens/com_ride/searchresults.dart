import 'package:carpooling/Actions/com_ridereq_action.dart';
import 'package:carpooling/Actions/findride_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/com_requestride/com_requestride_model.dart';
import 'package:carpooling/Model/findride/findride_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Searchresults extends StatefulWidget {
  @override
  _SearchresultsState createState() => _SearchresultsState();
}

class _SearchresultsState extends State<Searchresults> {
  bool req = true;
  bool reqcancel = false;
  bool loader = false;
  int reqid;
  bool requestcanceled = false;

  void handleInitialBuild(FindrideeProps props) {
    props.findrideapi(findridedata);
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, FindrideeProps>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),
        builder: (context, props) {
          Widget body;
          if (props.load) {
            loader = true;
            props.clearpropsreq("true");
          } else if (props.comridereq != null) {
            loader = false;
            print("successsreq");
            props.findrideapi(findridedata);
            props.clearpropsreq("true");
          } else if (props.err != null) {
            loader = false;
            print(props.err);
            print("errorreq");
            props.clearpropsreq("true");
          } else {
            loader = false;
          }

          if (props.loading) {
            loader = true;
            body = Center(
              child: CircularProgressIndicator(),
            );
          } else if (props.rideresults != null) {
            loader = false;
            print("successs to find ride");

            body = Stack(children: [
              Container(
                child: Column(children: <Widget>[
                  Container(
                      height: getDeviceheight(context, 0.20),
                      width: double.infinity,
                      child: Stack(children: [
                        GoogleMap(
                            mapType: MapType.normal,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(13.0827, 80.2707))),
                        Padding(
                          padding: EdgeInsets.only(
                              top: getDeviceheight(context, 0.03)),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: RawMaterialButton(
                                onPressed: () {},
                                fillColor: white,
                                child: Icon(Icons.arrow_back, size: 25.0, color: black,),
                                shape:
                                    CircleBorder(side: BorderSide(color: grey)),
                              )),
                        )
                      ]))
                ]),
              ),
              Container(
                  padding: EdgeInsets.only(top: getDevicewidth(context, 0.4)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getDeviceheight(context, 0.01),
                        ),
                        Center(
                            child: Text(
                          searchresult,
                          style: TextStyle(fontSize: 20, color: black, fontFamily: 'ProximaNova-Bold'),
                        )),
                        SizedBox(
                          height: getDeviceheight(context, 0.015),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getDevicewidth(context, 0.25)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(image: clockicon, width: 14, height: 14,),
                              Text(
                                "8-8.30 am | Tue,Nov 12",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 16,
                                    fontFamily: 'ProximaNova-Medium'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getDeviceheight(context, 0.02),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: getDevicewidth(context, 0.15)),
                          child: Column(
                            children: [
                              Row(children: [
                                Image(
                                  image: locationicon,
                                  width: 14,
                                  height: 14,
                                ),
                                Text(C_pickup,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'ProximaNova-Regular',
                                        color: grey))
                              ]),
                              SizedBox(
                                height: getDeviceheight(context, 0.03),
                              ),
                              Row(children: [
                                Image(
                                  image: locationicon,
                                  width: 14,
                                  height: 14,
                                ),
                                Text(C_droploc,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'ProximaNova-Regular',
                                        color: grey))
                              ]),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getDeviceheight(context, 0.02),
                        ),
                        Text("Available cars on 8-8.30 am | Tue,Nov 12",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'ProximaNova-Semiboldstyle',
                                color: black)),
                      ])),
              Padding(
                padding: EdgeInsets.only(
                    top: getDevicewidth(context, 0.8),
                    left: getDevicewidth(context, 0.01)),
                child: new ListView.builder(
                    itemCount: props.rideresults.matchingRides[0].length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new Container(
                        // color:red,
                        padding: EdgeInsets.only(left: 5, right: 2),
                        child: Card(
                          color: white,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30.0,
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    props.rideresults.matchingRides[0][index]
                                        .ownerDetails.firstName,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'ProximaNova-Semiboldstyle',
                                        color: black),
                                  ),
                                  Text(
                                    props.rideresults.matchingRides[0][index]
                                        .vehicleDetails.vehicleName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'ProximaNova-Regular',
                                        color: grey),
                                  )
                                ],
                              ),
                              if (props.rideresults.matchingRides[0][index]
                                      .requestDetails ==
                                  null)
                                new Flexible(
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: ButtonTheme(
                                            height: 55.0,
                                            buttonColor: black,
                                            child: RaisedButton(
                                              onPressed: () async {
                                                var data = {
                                                  "startLocation": {
                                                    "lat": C_pic_lat,
                                                    "lng": C_pic_lat,
                                                    // props.rideresults.matchingRides[index][index].rideDetails.startLocation.lng //12.123456
                                                    "address": C_pickup
                                                  },
                                                  "endLocation": {
                                                    "lat": C_drop_lat,
                                                    "lng": C_drop_lng,
                                                    "address": C_droploc
                                                  },
                                                  "rideId": props
                                                      .rideresults
                                                      .matchingRides[0][index]
                                                      .rideDetails
                                                      .id,
                                                };
                                                props.comridereqapi(data);
                                              },
                                              child: Image(
                                                image: carsearchicon,
                                                width: 34,
                                                height: 34,
                                              ),
                                              shape: CircleBorder(),
                                            )))),
                              if (props.rideresults.matchingRides[0][index]
                                      .requestDetails !=
                                  null)
                                new Flexible(
                                    child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Column(
                                          children: [
                                            TextButton.icon(
                                                icon: Image(
                                                  image: tickicon,
                                                  width: 14,
                                                  height: 14,
                                                ),
                                                label: Text(
                                                  reqsend,
                                                  style: TextStyle(
                                                      color: green,
                                                      fontSize: 10,
                                                      fontFamily:
                                                          'ProximaNova-Regular'),
                                                )),
                                            ButtonTheme(
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                        color: greylight),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: RaisedButton(
                                                    color: white,
                                                    onPressed: () {
                                                      return showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20.0))),
                                                              content:
                                                                  Container(
                                                                      width:
                                                                          140.0,
                                                                      child: Column(
                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                              .stretch,
                                                                          mainAxisSize: MainAxisSize
                                                                              .min,
                                                                          children: <
                                                                              Widget>[
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Image(
                                                                                  image: tickicon,
                                                                                  width: 14,
                                                                                  height: 14,
                                                                                ),
                                                                                Text(
                                                                                  cancelridereq,
                                                                                  style: TextStyle(color: red, fontSize: 16, fontFamily: 'ProximaNova-Semibold'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 7,
                                                                            ),
                                                                            Text(surecancelride,
                                                                                style: TextStyle(color: black, fontSize: 17, fontFamily: 'ProximaNova-Regular')),
                                                                            SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                                                              RaisedButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop(context);
                                                                                },
                                                                                color: lightgrey,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                child: Text(
                                                                                  no,
                                                                                  style: TextStyle(color: lightblack),
                                                                                ),
                                                                              ),
                                                                              RaisedButton(
                                                                                onPressed: () async {
                                                                                  Navigator.of(context).pop(context);

                                                                                  var data = {
                                                                                    "requestId": props.rideresults.matchingRides[0][index].requestDetails.requestId == null ? props.comridereq.requestDetails.requestId : props.rideresults.matchingRides[0][index].requestDetails.requestId
                                                                                  };
                                                                                  try {
                                                                                    var url = BASE_URL + COM_CANCEL_REQ;
                                                                                    final prefs = await SharedPreferences.getInstance();
                                                                                    final key = 'token';
                                                                                    final value = prefs.get(key) ?? 0;
                                                                                    print(value);
                                                                                    var response = await dio.put(url,
                                                                                        data: data,
                                                                                        options: Options(
                                                                                            headers: {'Authorization': 'jwt $value'},
                                                                                            validateStatus: (status) {
                                                                                              return status < 500;
                                                                                            }));

                                                                                    if (response.statusCode == 200) {
                                                                                      print(response.data);
                                                                                      props.findrideapi(findridedata);
                                                                                      //  props.clearpropsreq("true");
                                                                                    } else {
                                                                                      print(response.statusCode);
                                                                                    }
                                                                                  } catch (e) {
                                                                                    print(e);
                                                                                  }
                                                                                },
                                                                                color: tealaccent,
                                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                child: Text(yes),
                                                                              ),
                                                                            ]),
                                                                          ])),
                                                            );
                                                          });
                                                    },
                                                    child: Text(
                                                      cancelreq,
                                                      style: TextStyle(
                                                          color: red,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'ProximaNova-Regular'),
                                                    ))),
                                          ],
                                        ))),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: getDeviceheight(context, 0.02)),
                    child: ButtonTheme(
                        minWidth: 350,
                        height: 45,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: RaisedButton(
                          color: tealaccent,
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/homecommuter');
                          },
                          child: Text(
                            done,
                            style: textstyle,
                          ),
                        )),
                  )),
              loader
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
            ]);
          } else if (props.error != null) {
            loader = false;
            print(props.error);
            print("errorto find ride");
            //   props.clearprops("true");
          }
          return WillPopScope(
              onWillPop: () {
                props.clearprops("true");
                props.clearpropsreq("true");

                Navigator.pushNamed(context, '/scheduleride');
              },
              child: Scaffold(
                body: body,
              ));
        });
  }
}

class FindrideeProps {
  final bool load;
  final dynamic err;
  final bool loading;
  final dynamic error;
  final FindrideModal rideresults;
  final Function findrideapi;
  final Commuter_req_modal comridereq;
  final Function comridereqapi;
  final Function clearprops;
  final Function clearpropsreq;

  FindrideeProps({
    this.load,
    this.err,
    this.loading,
    this.error,
    this.rideresults,
    this.findrideapi,
    this.comridereq,
    this.comridereqapi,
    this.clearprops,
    this.clearpropsreq,
  });
}

FindrideeProps mapStateToProps(Store<AppState> store) {
  return FindrideeProps(
      loading: store.state.rideresults.loading,
      error: store.state.rideresults.error,
      rideresults: store.state.rideresults.rideresult,
      load: store.state.comreqride.loading,
      err: store.state.comreqride.error,
      comridereq: store.state.comreqride.comreqride,
      comridereqapi: (data) => store.dispatch(commridereq(data)),
      findrideapi: (data) => store.dispatch(findridecommuter(data)),
      clearprops: (data) => store.dispatch(clearpropsfindride(data)),
      clearpropsreq: (data) => store.dispatch(clearpropscomreqride(data)));
}
