
import 'package:carpooling/Actions/com_upcome_ride_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/com_upcomingride/com_upcomingride_modal.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/map.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Upcometrips extends StatefulWidget {
  @override
  _UpcometripsState createState() => _UpcometripsState();
}

class _UpcometripsState extends State<Upcometrips> {
  bool loader=false;
  String currenttime = "";
  bool cancelreq=false;
  Future<void> _launched;
  String _phone ;
  int indx;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initState() {
    super.initState();
    var addDt = DateTime.now();
    currenttime = addDt.toString();
    print("currentime" + currenttime);
  }

  @override
  void handleInitialBuild(ComupcomeProps props) {
    var addDT=currenttime;
    var  data = {
      "fetchTime" :addDT
    };
    props.upcomerideapi(data);

  }
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ComupcomeProps>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),
        builder: (context, props) {
          Widget body;
          if (props.loading) {
            print("loading");
            body = Center(
              child: CircularProgressIndicator(),
            );
          }
          else
          if(props.comupcomeride!=null) {
            loader=false;
            print("successs");
            body =
                Container(
                    child:  ListView.builder(
                        itemCount:props.comupcomeride.upcomingRides.length,
                        itemBuilder: (context, index )
                        {
                          return Card(
                              child: Padding(
                                padding: EdgeInsets.all(17),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(props.comupcomeride.upcomingRides[index].date,
                                        style: TextStyle(fontFamily: 'ProximaNova-Semiboldstyle', color: black, fontSize: 14),),
                                      SizedBox(height: getDeviceheight(context, 0.02),),
                                        Row(
                                          children: [
                                            Image(image:addressmarker, width: 44,height: 44,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                    children:[
                                                      Image(image:locationicon, width: 14,height: 14,),
                                                      Text(props.comupcomeride.upcomingRides[index].startLocation.address,
                                                        style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                    ]),

                                      SizedBox(height: getDeviceheight(context, 0.02),),

                                         Row(
                                            children:[
                                              Image(image:locationicon, width: 14,height: 14,),
                                              Text(props.comupcomeride.upcomingRides[index].endLocation.address,
                                                  style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                                            ]),
                                              ],
                                            ),
                                          ],
                                        ),


                                      SizedBox(height: getDeviceheight(context, 0.02),),
                                      Padding(
                                        padding:EdgeInsets.only(left: getDevicewidth(context, 0.10)),
                                        child: Row(
                                          children: [
                                            Image(image:clockicon, width: 14,height: 14,),
                                            Text(
                                              props.comupcomeride.upcomingRides[index].timeSlotDetails.slotTime+" | "+
                                                  props.comupcomeride.upcomingRides[index].date
                                              ,style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular'),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: getDeviceheight(context, 0.02),),
                                      Padding(
                                        padding:EdgeInsets.only(left: getDevicewidth(context, 0.02,),right: getDevicewidth(context, 0.02)),
                                        child: Row(
                                          children: [

                                            CircleAvatar(
                                                backgroundImage:NetworkImage("http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Profile-Picture-4.jpg"),
                                                radius: getDevicewidth(context, 0.045)
                                            ),
                                            TextButton(
                                                onPressed: (){
                                                  showModalBottomSheet(
                                                      context: context,
                                                      shape: topBorder,
                                                      isScrollControlled: true,
                                                      builder: (context) {
                                                        return StatefulBuilder(
                                                            builder: (BuildContext context,
                                                                StateSetter setModalState,) {
                                                              return Container(
                                                                height: getDeviceheight(context, 0.7),
                                                                child: Padding(
                                                                  padding: EdgeInsets.only(left: getDevicewidth(context, 0.03)),
                                                                  child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: <Widget>[
                                                                        Padding(
                                                                          padding: EdgeInsets.only(top: getDeviceheight(context, 0.05),left: 15),
                                                                          child: Text("Ride Details",style: TextStyle(fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 20,color: black),),
                                                                        ),
                                                                        SizedBox(height: getDeviceheight(context, 0.03),),

                                                                          Row(
                                                                            children: [
                                                                              Image(image:addressmarker, width: 44,height: 44,),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Row(
                                                                                      children:[
                                                                                        Image(image:locationicon,
                                                                                          width: 14,height: 14,),
                                                                                        Text(props.comupcomeride.upcomingRides[index].startLocation.address,
                                                                                          style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                                                      ]),

                                                                        SizedBox(height: getDeviceheight(context, 0.02),),

                                                                              Row(
                                                                                  children:[
                                                                                    Image(image:locationicon,
                                                                                      width: 14,height: 14,),
                                                                                    Text(props.comupcomeride.upcomingRides[index].endLocation.address,
                                                                                        style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                                                                                  ])]),
                                                                            ],
                                                                          ),
                                                            SizedBox(height: getDeviceheight(context, 0.02),),
                                                                        Padding(
                                                                          padding:EdgeInsets.only(left: getDevicewidth(context, 0.10)),
                                                                          child: Row(
                                                                            children: [
                                                                              Image(image:clockicon, width: 14,height: 14,),
                                                                              Text(props.comupcomeride.upcomingRides[index].timeSlotDetails.slotTime+' |'+
                                                                                 props.comupcomeride.upcomingRides[index].date,

                                                                                style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular'),),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: getDeviceheight(context, 0.025),),
                                                                        Text("Vehicle Owner",style: TextStyle(color: grey,fontFamily: 'ProximaNova-Medium',fontSize: 16),),
                                                                        Padding(
                                                                          padding: EdgeInsets.only(left: getDevicewidth(context, 0.04),top: getDeviceheight(context, 0.025) ),
                                                                          child: Row(
                                                                              children: [
                                                                                CircleAvatar(
                                                                                    backgroundImage:NetworkImage("http://www.goodmorningimagesdownload.com/wp-content/uploads/2019/12/Profile-Picture-4.jpg"),
                                                                                    radius: getDevicewidth(context, 0.07)
                                                                                ),
                                                                                Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Text(props.comupcomeride.upcomingRides[index].ownerDetails.firstName+" "+
                                                                                          props.comupcomeride.upcomingRides[index].ownerDetails.lastName,
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            color: black,
                                                                                            fontFamily: 'ProximaNova-Medium'),),
                                                                                      Row(
                                                                                          children: [
                                                                                            Image(image: locblackicon, width: 14, height: 14,),
                                                                                            TextButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Mapapp(
                                                                                                    loclat:props.comupcomeride.upcomingRides[index].startLocation.lat,
                                                                                                    loclng:props.comupcomeride.upcomingRides[index].startLocation.lat,
                                                                                                      locadd:props.comupcomeride.upcomingRides[index].startLocation.address,
                                                                                                      locuserfname:props.comupcomeride.upcomingRides[index].ownerDetails.firstName,
                                                                                                      locuserlname:props.comupcomeride.upcomingRides[index].ownerDetails.lastName,
                                                                                                      loctime:props.comupcomeride.upcomingRides[index].timeSlotDetails.slotTime,
                                                                                                      locdate:props.comupcomeride.upcomingRides[index].date
                                                                                                  )));
                                                                                                },
                                                                                                child: Text(
                                                                                                  viewlocation,
                                                                                                  style: TextStyle(
                                                                                                      decoration: TextDecoration.underline,
                                                                                                      color: grey,
                                                                                                      fontSize: 12,
                                                                                                      fontFamily: 'ProximaNova-Medium'),)),
                                                                                            Image(
                                                                                              image: callicon,
                                                                                              width: 14,
                                                                                              height: 14,),
                                                                                            TextButton(
                                                                                                onPressed: () => setState(() {
                                                                                                  _phone = props.comupcomeride.upcomingRides[index].ownerDetails.phoneNumber;
                                                                                                  _launched = _makePhoneCall('tel:$_phone');
                                                                                                }),
                                                                                                child: Text(
                                                                                                  call,
                                                                                                  style: TextStyle(
                                                                                                      decoration: TextDecoration.underline,
                                                                                                      color: grey,
                                                                                                      fontSize: 12,
                                                                                                      fontFamily: 'ProximaNova-Medium'),)),
                                                                                          ])
                                                                                    ]
                                                                                ),
                                                                              ]),
                                                                        ),
                                                                        SizedBox(height: getDeviceheight(context, 0.025),),
                                                                        Text("Passengers", style: TextStyle(color: grey, fontFamily: 'ProximaNova-Medium', fontSize: 16),),
                                                                        Container(
                                                                            height:getDeviceheight(context, 0.2),
                                                                            child: props.comupcomeride.upcomingRides[index].commuterDetails==null
                                                                                 ? Center(child: Text("Passengers not found ", style: TextStyle(color:black))):

                                                                            ListView.builder(
                                                                                itemCount:props.comupcomeride.upcomingRides[index].commuterDetails.length,
                                                                                itemBuilder: (context, index) {
                                                                                  return Card(
                                                                                      color: white,
                                                                                      child: Padding(
                                                                                          padding: EdgeInsets.only(left: getDevicewidth(context, 0.04),top: 3,bottom: 3),
                                                                                          child: Row(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                CircleAvatar(
                                                                                                    backgroundImage:NetworkImage("https://wi.wallpapertip.com/wsimgs/1-19963_fb-wallpaper-for-girl-profile-picture-of-nature.jpg"),
                                                                                                    radius: getDevicewidth(context, 0.07)
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsets.only(top:18,left: 5),
                                                                                                  child: Text(props.comupcomeride.upcomingRides[indx].commuterDetails[index].firstName+' '+
                                                                                                      props.comupcomeride.upcomingRides[indx].commuterDetails[index].lastName,
                                                                                                    style: TextStyle(fontSize: 14, color: black, fontFamily: 'ProximaNova-Medium'),),
                                                                                                ),
                                                                                              ])));

                                                                                })
                                                                        )

                                                                      ]),
                                                                ),
                                                              );
                                                            });
                                                      });

                                                },
                                                child:Text(props.comupcomeride.upcomingRides[index].ownerDetails.firstName+' '+props.comupcomeride.upcomingRides[index].ownerDetails.lastName,
                                                  style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black),)),

                                          Flexible(child: Align(
                                                alignment: Alignment.topRight,
                                                child: ButtonTheme(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),),
                                                    child:props.comupcomeride.upcomingRides[index].isCancelled==true?
                                                    FlatButton(
                                                        color: red,
                                                        onPressed:(){},
                                                        child:  Text("Request Cancelled",style: TextStyle(color:white, fontFamily: 'ProximaNova-Regular', fontSize: 12),)
                                                    ):

                                                    OutlineButton(
                                                        onPressed: () async {
                                                          var data={
                                                           // "requestId":props.reqstdride.requestedRides[index].requestDetails.requestId

                                                          };
                                                          try {
                                                            var url = BASE_URL + COM_CANCEL_REQ;
                                                            final prefs = await SharedPreferences.getInstance();
                                                            final key = 'token';
                                                            final value = prefs.get(key) ?? 0;
                                                            print(value);
                                                            var response = await dio.put(url, data: data,
                                                                options: Options(
                                                                    headers: {
                                                                      'Authorization': 'jwt $value'
                                                                    },
                                                                    validateStatus: (status) {
                                                                      return status < 500;
                                                                    }
                                                                )
                                                            );

                                                            if (response.statusCode == 200) {
                                                              // props.clearpropsreq("true");
                                                              print(response.data);
                                                              var addDT=currenttime;
                                                              var  data = {
                                                                "fetchTime" :  addDT
                                                              };
                                                              props.upcomerideapi(data);
                                                              // props.findrideapi(findridedata);
                                                              //  props.clearpropsreq("true");
                                                            } else {
                                                              print(response.statusCode);
                                                            }
                                                          } catch (e) {
                                                            print(e);
                                                          }
                                                        },
                                                        child:
                                                        Text("cancel Request",style: TextStyle(color: red, fontFamily: 'ProximaNova-Regular', fontSize: 12),)
                                                    )
                                                )),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ]),
                              ));
                        })

                );


          } else if (props.error != null) {
            loader = false;
            body=Center(child: Text("Not Found"));
            print(props.error);
            print("error");
          }
          return Scaffold(
            body: body,
          );
        });

  }
}



class  ComupcomeProps {
  final bool loading;
  final dynamic error;
  final Com_upcomingride_modal comupcomeride;
  final Function upcomerideapi;
  final Function clearprops;

  ComupcomeProps({
    this.loading,
    this.error,
    this.comupcomeride,
    this.upcomerideapi,
    this.clearprops,
  });
}
ComupcomeProps mapStateToProps(Store<AppState> store) {
  return  ComupcomeProps(
    loading: store.state.comupcomeride.loading,
    error: store.state.comupcomeride.error,
    comupcomeride: store.state.comupcomeride.comupcomeride,
    upcomerideapi: (data)=>store.dispatch(comupcomeride(data)),
  );
}
