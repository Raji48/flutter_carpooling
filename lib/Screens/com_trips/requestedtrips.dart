


import 'package:carpooling/Actions/requestedride_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/requested_ride/requested_ride_modal.dart';
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

class Requestedtrips extends StatefulWidget {
  @override
  _RequestedtripsState createState() => _RequestedtripsState();
}

class _RequestedtripsState extends State<Requestedtrips> {
  bool loader=false;
  String currenttime = "";
  bool cancelreq=false;
  Future<void> _launched;
  String _phone ;
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
  void handleInitialBuild(RequestedrideProps props) {
    var addDT=currenttime;
    var  data = {
      "fetchTime" :  addDT
    };
    props.requestedrideapi(data);

  }
  Widget build(BuildContext context) {
    return StoreConnector<AppState, RequestedrideProps>(
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
    if(props.reqstdride!=null) {
    loader=false;
    print("successs");
    body =
    Container(
        child:  ListView.builder(
            itemCount: props.reqstdride.requestedRides.length,
            itemBuilder: (context, index )
            {
              return Card(
                  child: Padding(
                    padding: EdgeInsets.all(17),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(props.reqstdride.requestedRides[index].rideDetails.date,
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
                                          Text(props.reqstdride.requestedRides[index].requestDetails.startLocation.address,style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                                        ]),


                          SizedBox(height: getDeviceheight(context, 0.02),),
                                 Row(
                                    children:[
                                      Image(image:locationicon, width: 14,height: 14,),
                                      Text(props.reqstdride.requestedRides[index].requestDetails.endLocation.address,style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
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
                                  props.reqstdride.requestedRides[index].rideDetails.timeSlotDetails.slotTime+" | "+
                                      props.reqstdride.requestedRides[index].rideDetails.date
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
                                    int indx;
                                    print(props.reqstdride.requestedRides[indx=index].commuterDetails.length);
                                    print(indx);
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
                                                    Text(props.reqstdride.requestedRides[index].rideDetails.startLocation.address,
                                                      style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                  ]),


                                    SizedBox(height: getDeviceheight(context, 0.02),),
                                      Row(
                                          children:[
                                            Image(image:locationicon,
                                              width: 14,height: 14,),
                                            Text(props.reqstdride.requestedRides[index].rideDetails.endLocation.address,
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
                                          Text(props.reqstdride.requestedRides[index].rideDetails.timeSlotDetails.slotTime+' |'+
                                              props.reqstdride.requestedRides[index].rideDetails.date,
                                           // "8-8.30am" +" | " +"Thu, Nov 12",
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
                                                  Text(props.reqstdride.requestedRides[index].ownerDetails.firstName+" "+
                                                    props.reqstdride.requestedRides[index].ownerDetails.lastName,
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
                                                                loclat:props.reqstdride.requestedRides[index].rideDetails.startLocation.lat,
                                                                loclng:props.reqstdride.requestedRides[index].rideDetails.startLocation.lng,
                                                                  locadd:props.reqstdride.requestedRides[index].rideDetails.startLocation.address,
                                                                  locuserfname:props.reqstdride.requestedRides[index].ownerDetails.firstName,
                                                                  locuserlname:props.reqstdride.requestedRides[index].ownerDetails.lastName,
                                                                  loctime:props.reqstdride.requestedRides[index].rideDetails.timeSlotDetails.slotTime,
                                                                  locdate:props.reqstdride.requestedRides[index].rideDetails.date
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
                                                              _phone = props.reqstdride.requestedRides[index].ownerDetails.phoneNumber;
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
                                      child:props.reqstdride.requestedRides[index].commuterDetails.length==0
                                       ? Center(child: Text("Passengers not found ", style: TextStyle(color:black))):
                                  ListView.builder(
                                  itemCount: props.reqstdride.requestedRides[indx].commuterDetails.length,
                                 itemBuilder: (context, index) {
                                 return Column(
                                   children: [
                                     Container(
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
                                                        child: Text(props.reqstdride.requestedRides[indx].commuterDetails[index].firstName+' '+
                                                            props.reqstdride.requestedRides[indx].commuterDetails[index].lastName,
                                                          style: TextStyle(fontSize: 14, color: black, fontFamily: 'ProximaNova-Medium'),),
                                                      ),
                                                    ]))),
                                     Divider(color:grey,height: 10,thickness: 0.1,),

                                   ],
                                 );

                                          }))

                                  ]),
                            ),
                          );
                        });
                  });

                                  },
                                    child:Text(props.reqstdride.requestedRides[index].ownerDetails.firstName+' '+props.reqstdride.requestedRides[index].ownerDetails.lastName,
                                  style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black),)),

                                  Flexible(child: Align(
                                      alignment: Alignment.topRight,
                                      child: ButtonTheme(

                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),),
                                          child:props.reqstdride.requestedRides[index].requestDetails.isCancelled==true?
                                          FlatButton.icon(
                                            color: red,
                                              onPressed:(){},
                                            icon:Image(image:blockcancelicon,width: 14,height: 14,),
                                            label:
                                               Text("Request Cancelled",style: TextStyle(color:white, fontFamily: 'ProximaNova-Regular', fontSize: 12),)
                                          ):

                                          OutlineButton(
                                            onPressed: () async {
                                               showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                                      content: Container(
                                                          width: getDevicewidth(context, 0.5),
                                                          child: Column(

                                                             crossAxisAlignment: CrossAxisAlignment.stretch,
                                                             mainAxisSize: MainAxisSize.min,
                                                              children: <Widget>[
                                                                Align(
                                                                    alignment: Alignment.topLeft,
                                                                    child: FlatButton.icon(
                                                                      icon:Image(image:carreqcancelicon,width: 20,height: 20,),
                                                                      label: Text(
                                                                      "Cancel Ride Request", style: TextStyle(color: red,fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 16),),)),
                                                                SizedBox(height: getDeviceheight(context, 0.005)),
                                                                Text("Are you sure you want to cancel the Request of this ride?",style: TextStyle(color:black,fontFamily: 'ProximaNova-Regular',fontSize: 16),),
                                                                SizedBox(height: getDeviceheight(context, 0.02)),
                                                                Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      FlatButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(false);
                                                                        },
                                                                        color: lightgrey,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(20)),
                                                                        child: Text(no,style: TextStyle(color: lightblack,fontSize: 14,fontFamily: 'ProximaNova-Medium'),),
                                                                      ),
                                                                      FlatButton(
                                                                        onPressed: () async {
                                                                          var data={
                                                                            "requestId":props.reqstdride.requestedRides[index].requestDetails.requestId

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
                                                                              Navigator.of(context).pop(false);

                                                                              print(response.data);
                                                                              var addDT=currenttime;
                                                                              var  data = {
                                                                                "fetchTime" :  addDT
                                                                              };
                                                                              props.requestedrideapi(data);

                                                                            } else {
                                                                              print(response.statusCode);
                                                                            }
                                                                          } catch (e) {
                                                                            print(e);
                                                                          }


                                                                        },
                                                                        color: tealaccent,
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(20)),
                                                                        child: Text(yes,style: TextStyle(color:black,fontSize: 14,fontFamily: 'ProximaNova-Medium'),)
                                                                      ),
                                                                    ]),
                                                              ])));
                                                  }
                                              );


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



class  RequestedrideProps {
  final bool loading;
  final dynamic error;
  final Requested_ride_modal reqstdride ;
  final Function requestedrideapi;
  final Function clearprops;

  RequestedrideProps({
    this.loading,
    this.error,
    this.reqstdride,
    this.requestedrideapi,
    this.clearprops,
  });
}
RequestedrideProps mapStateToProps(Store<AppState> store) {
  return  RequestedrideProps(
    loading: store.state.reqstdride.loading,
    error: store.state.reqstdride.error,
    reqstdride: store.state.reqstdride.reqstdride,
    requestedrideapi: (data)=>store.dispatch(requestedride(data)),
  );
}
