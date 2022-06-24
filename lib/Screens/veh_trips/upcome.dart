
import 'package:carpooling/Actions/veh_upcom_ride_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/veh_upcomingride/veh_upcomingride_model.dart';
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

class Upcome extends StatefulWidget {
  @override
  _UpcomeState createState() => _UpcomeState();
}

class _UpcomeState extends State<Upcome> {
  bool loader=false;
  String currenttime = "";
  bool cancelreq=false;
  Future<void> _launched;
  String _phone ;
  int viaint=1;
  // @override
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
  void handleInitialBuild(UpcomeProps props) {
    var addDT=currenttime;
    var  data = {
      "currentTime" :addDT ,
      "onlyAcceptedRequest":true
    };
    props.vehupcomerideapi(data);

  }
  Widget build(BuildContext context) {

    return StoreConnector<AppState, UpcomeProps>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),

        builder: (context, props) {
          Widget body;
          if (props.loading) {
            print("loading");
            body = Center(
              child: CircularProgressIndicator(),
            );
            //loader=true;
          }
          else
          if(props.vehupcomeride!=null) {
            loader=false;
            print("upcomeridesuccesss");
            body =
                Container(
                    child:  ListView.builder(
                        itemCount: props.vehupcomeride.upcomingRides.length,
                        itemBuilder: (context, index )
                        {

                          return Card(
                              child: Padding(
                                padding: EdgeInsets.all(17),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(props.vehupcomeride.upcomingRides[index].date,
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
                                                      Text(props.vehupcomeride.upcomingRides[index].startLocation.address,
                                                        style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                    ]),


                                      SizedBox(height: getDeviceheight(context, 0.02),),

                                             Row(
                                                children:[
                                                  Image(image:locationicon, width: 14,height: 14,),
                                                  Text(props.vehupcomeride.upcomingRides[index].endLocation.address,
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
                                              props.vehupcomeride.upcomingRides[index].timeSlotDetails.slotTime+" | "+
                                                  props.vehupcomeride.upcomingRides[index].date
                                              ,style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular'),),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: getDeviceheight(context, 0.02),),
                                      Padding(
                                        padding:EdgeInsets.only(left: getDevicewidth(context, 0.02,),right: getDevicewidth(context, 0.02)),
                                        child: Row(
                                          children: [
                                            Stack(
                                              children: [
                                                if(props.vehupcomeride.upcomingRides[index].commutersDetails.length>0)
                                                  CircleAvatar(
                                                      backgroundImage: NetworkImage("https://cultivatedculture.com/wp-content/uploads/2019/12/LinkedIn-Profile-Picture-Example-Madeline-Mann.jpeg"),
                                                      radius: getDevicewidth(context, 0.04)//25.0,
                                                  ),
                                                Padding(
                                                    padding: EdgeInsets.only(left:getDevicewidth(context, 0.035)),
                                                    child:props.vehupcomeride.upcomingRides[index].commutersDetails.length>1? CircleAvatar(
                                                        backgroundImage: NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                        radius: getDevicewidth(context, 0.04)//25.0,
                                                    ):null
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(left:getDevicewidth(context, 0.07)),
                                                    child: props.vehupcomeride.upcomingRides[index].commutersDetails.length>2 ? CircleAvatar(
                                                        backgroundImage: NetworkImage("http://www.goodmorningimageshddownload.com/wp-content/uploads/2020/03/Cute-Whatsapp-DP-7.jpg"),
                                                        radius: getDevicewidth(context, 0.04)//25.0,
                                                    ):null
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(left:getDevicewidth(context, 0.105)),
                                                    child: props.vehupcomeride.upcomingRides[index].commutersDetails.length>3 ? CircleAvatar(
                                                        backgroundImage: NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                        radius: getDevicewidth(context, 0.04)//25.0,
                                                    ):null
                                                ),
                                                Padding(
                                                    padding: EdgeInsets.only(left:getDevicewidth(context, 0.140)),
                                                    child:props.vehupcomeride.upcomingRides[index].commutersDetails.length>4? CircleAvatar(
                                                        backgroundImage: NetworkImage("https://www.finetoshine.com/wp-content/uploads/2020/07/Top-30-Attitude-DP-For-Girls-Cute-profile-Pics-for.jpg"),
                                                        radius: getDevicewidth(context, 0.04)//25.0,
                                                    ):null
                                                ),

                                              ],
                                            ),
                                            TextButton(
                                                onPressed: (){
                                                  int indx;
                                                  print(props.vehupcomeride.upcomingRides[indx=index].commutersDetails.length);
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
                                                                                Text(props.vehupcomeride.upcomingRides[index].startLocation.address,
                                                                                  style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                                              ]),

                                                                        SizedBox(height: getDeviceheight(context, 0.02),),

                                                                                   Row(
                                                                                      children:[
                                                                                        Image(image:locationicon, width: 14,height: 14,),
                                                                                        Text(props.vehupcomeride.upcomingRides[index].endLocation.address,
                                                                                            style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                                                                                      ]),
                                                                                 ],
                                                                               ),
                                                                             ],
                                                                           ),


                                                                        SizedBox(height: getDeviceheight(context, 0.02),),
                                                                  Padding(
                                                                  padding: EdgeInsets.only(left: getDevicewidth(context, 0.10)),
                                                                        child:  Row(
                                                                                children: [
                                                                                  Image(image:clockicon, width: 14,height: 14,),
                                                                                  Text(props.vehupcomeride.upcomingRides[index].timeSlotDetails.slotTime+' | '+
                                                                                      props.vehupcomeride.upcomingRides[index].date,
                                                                                    style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular'),),
                                                                                ],
                                                                          )),
                                                                        SizedBox(height: getDeviceheight(context, 0.025),),
                                                                        Text("Via Points",style: TextStyle(color: grey,fontFamily: 'ProximaNova-Medium',fontSize: 16),),
                                                                        Container(
                                                                          height:props.vehupcomeride.upcomingRides[index].viaPointsDetails.length==3?getDeviceheight(context,0.15):props.vehupcomeride.upcomingRides[index].viaPointsDetails.length==3?getDeviceheight(context,0.075):getDeviceheight(context,0.042),
                                                                          child: ListView.builder(
                                                                              itemCount: props.vehupcomeride.upcomingRides[index].viaPointsDetails.length,
                                                                              itemBuilder: (context, index) {
                                                                                return Padding(
                                                                                  padding: EdgeInsets.only(left: getDevicewidth(context,0.10),top:getDeviceheight(context, 0.01)),
                                                                                  child: Container(
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text((index+viaint).toString()+'.'),
                                                                                          Image(image:locationicon, width: 14,height: 14,),
                                                                                          Text(props.vehupcomeride.upcomingRides[indx].viaPointsDetails[index].address,
                                                                                            style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: black),),
                                                                                        ],
                                                                                      )
                                                                                  ),
                                                                                );
                                                                              }),
                                                                        ),

                                                                        Text("Passengers", style: TextStyle(color: grey, fontFamily: 'ProximaNova-Medium', fontSize: 16),),
                                                                       Container(
                                                                            height:props.vehupcomeride.upcomingRides[index].viaPointsDetails.length==3?getDeviceheight(context, 0.2):props.vehupcomeride.upcomingRides[index].viaPointsDetails.length==2?getDeviceheight(context, 0.25):getDeviceheight(context, 0.27),
                                                                            child:props.vehupcomeride.upcomingRides[index].commutersDetails.length==0
                                                                                ? Center(child: Text("Passengers not found ", style: TextStyle(color:black))):
                                                                            ListView.builder(
                                                                                itemCount:props.vehupcomeride.upcomingRides[index].commutersDetails.length,
                                                                                itemBuilder: (context, index) {
                                                                                  return Column(
                                                                                    children: [
                                                                                      Container(

                                                                                        child: Padding(
                                                                                          padding: EdgeInsets.only(left: getDevicewidth(context, 0.04),top: getDeviceheight(context, 0.025) ),
                                                                                          child: Row(
                                                                                              children: [
                                                                                                CircleAvatar(
                                                                                                    backgroundImage: NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                                                                    radius: getDevicewidth(context, 0.07) //25.0,

                                                                                                ),
                                                                                                Column(
                                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                    children: [
                                                                                                      Text(props.vehupcomeride.upcomingRides[indx].commutersDetails[index].firstName+" "+
                                                                                                          props.vehupcomeride.upcomingRides[indx].commutersDetails[index].lastName,
                                                                                                        style: TextStyle(fontSize: 14, color: black, fontFamily: 'ProximaNova-Medium'),),
                                                                                                      Row(
                                                                                                          children: [
                                                                                                            Image(image: locblackicon, width: 14, height: 14,),
                                                                                                            TextButton(
                                                                                                                onPressed: () {
                                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Mapapp(
                                                                                                                    loclat:props.vehupcomeride.upcomingRides[indx].commutersDetails[index].requestDetails.startLocation.lat,
                                                                                                                    loclng:props.vehupcomeride.upcomingRides[indx].commutersDetails[index].requestDetails.startLocation.lng,
                                                                                                                      locadd:props.vehupcomeride.upcomingRides[indx].commutersDetails[index].requestDetails.startLocation.address,
                                                                                                                      locuserfname: props.vehupcomeride.upcomingRides[indx].commutersDetails[index].firstName,
                                                                                                                      locuserlname:  props.vehupcomeride.upcomingRides[indx].commutersDetails[index].lastName,
                                                                                                                      loctime:props.vehupcomeride.upcomingRides[indx].timeSlotDetails.slotTime,
                                                                                                                      locdate:props.vehupcomeride.upcomingRides[indx].date
                                                                                                                  )));
                                                                                                                },
                                                                                                                child: Text(
                                                                                                                  viewlocation,
                                                                                                                  style: TextStyle(decoration: TextDecoration.underline, color: grey, fontSize: 12, fontFamily: 'ProximaNova-Medium'),)),
                                                                                                            Image(
                                                                                                              image: callicon,
                                                                                                              width: 14,
                                                                                                              height: 14,),
                                                                                                            TextButton(
                                                                                                                onPressed: () => setState(() {
                                                                                                                  _phone =props.vehupcomeride.upcomingRides[indx].commutersDetails[index].phoneNumber;
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
                                                                                        //])
                                                                                      ),
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
                                                child:props.vehupcomeride.upcomingRides[index].commutersDetails.length>5?
                                                Text(" 5+ Passengers",style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: grey),):
                                                Text(props.vehupcomeride.upcomingRides[index].commutersDetails.length.toString()+ " Passengers",
                                                  style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color:grey),)),
                                            Flexible(child: Align(
                                                alignment: Alignment.topRight,
                                                child: ButtonTheme(

                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),),
                                                    child:props.vehupcomeride.upcomingRides[index].isCancelled==true?
                                                    FlatButton.icon(
                                                        color: red,
                                                        onPressed:(){},
                                                      icon:Image(image:blockcancelicon,width: 14,height: 14,),
                                                      label: Text("Ride Cancelled",style: TextStyle(color:white, fontFamily: 'ProximaNova-Regular', fontSize: 12),)
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
                                                                                    icon:Image(image:blockcancelicon,width: 20,height: 20,),
                                                                                    label: Text(
                                                                                      "Cancel Ride", style: TextStyle(color: red,fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 16),),)),
                                                                              SizedBox(height: getDeviceheight(context, 0.005)),
                                                                              Text("Are you sure you want to cancel this ride?",style: TextStyle(color:black,fontFamily: 'ProximaNova-Regular',fontSize: 16),),
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
                                                                                            "rideId" : props.vehupcomeride.upcomingRides[index].id
                                                                                          };
                                                                                          try {
                                                                                            var url = BASE_URL + VEH_OWNER_CANCEL_RIDE;
                                                                                            final prefs = await SharedPreferences.getInstance();
                                                                                            final key = 'token';
                                                                                            final value = prefs.get(key) ?? 0;
                                                                                            print(value);
                                                                                            var response = await dio.put(url, data: data,
                                                                                                options:Options(
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
                                                                                                "currentTime" :  addDT,
                                                                                                "onlyAcceptedRequest":true
                                                                                              };
                                                                                              props.vehupcomerideapi(data);
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

                                                        Text("cancel Ride",style: TextStyle(color: red, fontFamily: 'ProximaNova-Regular', fontSize: 12),)
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
           // loader = false;
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

class UpcomeProps {
  final bool loading;
  final dynamic error;
  final Veh_owner_upcomingride_modal vehupcomeride ;
  final Function vehupcomerideapi;
  final Function clearprops;

  UpcomeProps({
    this.loading,
    this.error,
    this.vehupcomeride,
    this.vehupcomerideapi,
    this.clearprops,
  });
}
UpcomeProps mapStateToProps(Store<AppState> store) {
  return  UpcomeProps(
    loading: store.state.vehupcomride.loading,
    error: store.state.vehupcomride.error,
    vehupcomeride: store.state.vehupcomride.vehupcomride,
    vehupcomerideapi: (data)=>store.dispatch(vehupcomride(data)),
    //clearprops: (data)=>store.dispatch(clearpropsupcomride(data)),
  );

}

