

import 'package:carpooling/Actions/com_pastride_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/com_pastride/com_pastride_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/map.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class Compastride extends StatefulWidget {
  @override
  _CompastrideState createState() => _CompastrideState();
}

class _CompastrideState extends State<Compastride> {
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
  void handleInitialBuild(CompastrideProps props) {
    var addDT=currenttime;
    var  data = {
      "fetchTime" :addDT
    };
    props.compastrideapi(data);

  }
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CompastrideProps>(
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
          if(props.compastride!=null) {
            loader=false;
            print("successs");
            body =
                Container(
                    child:  ListView.builder(
                        itemCount:props.compastride.pastRides.length,
                        itemBuilder: (context, index )
                        {
                          return Card(
                              child: Padding(
                                padding: EdgeInsets.all(17),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(props.compastride.pastRides[index].date,
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
                                                      Text(props.compastride.pastRides[index].startLocation.address,
                                                        style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                    ]),

                                      SizedBox(height: getDeviceheight(context, 0.02),),
                                         Row(
                                            children:[
                                              Image(image:locationicon, width: 14,height: 14,),
                                              Text(props.compastride.pastRides[index].endLocation.address,
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
                                          //  props.compastride.pastRides[index].slot+" | "+
                                              props.compastride.pastRides[index].date
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
                                                radius: getDevicewidth(context, 0.045) //25.0,

                                            ),
                                            TextButton(
                                                onPressed: (){
                                                    int indx;
                                                  print(props.compastride.pastRides[indx=index].date);
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
                                                                                        Text(props.compastride.pastRides[index].startLocation.address,
                                                                                          style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                                                      ]),


                                                                        SizedBox(height: getDeviceheight(context, 0.02),),

                                                                               Row(
                                                                                  children:[
                                                                                    Image(image:locationicon,
                                                                                      width: 14,height: 14,),
                                                                                    Text(props.compastride.pastRides[index].endLocation.address,
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
                                                                              Text(//props.comupcomeride.upcomingRides[index].timeSlotDetails.slotTime+' |'+
                                                                                  props.compastride.pastRides[index].date,
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
                                                                                      Text(props.compastride.pastRides[index].ownerDetails.firstName+" "+
                                                                                          props.compastride.pastRides[index].ownerDetails.lastName,
                                                                                        style: TextStyle(
                                                                                            fontSize: 14,
                                                                                            color: black,
                                                                                            fontFamily: 'ProximaNova-Medium'),),
                                                                                      Row(
                                                                                          children: [
                                                                                            // Icon(Icons.location_pin),
                                                                                            Image(image: locblackicon, width: 14, height: 14,),
                                                                                            TextButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Mapapp(
                                                                                                    loclat:props.compastride.pastRides[index].startLocation.lat,
                                                                                                    loclng:props.compastride.pastRides[index].startLocation.lng,
                                                                                                      locadd:props.compastride.pastRides[index].startLocation.address,
                                                                                                      locuserfname:props.compastride.pastRides[index].ownerDetails.firstName,
                                                                                                      locuserlname:props.compastride.pastRides[index].ownerDetails.lastName,
                                                                                                      loctime:"8-8.30 am",
                                                                                                      locdate:props.compastride.pastRides[index].date
                                                                                                  )));
                                                                                                },
                                                                                                child: Text(
                                                                                                  viewlocation,
                                                                                                  style: TextStyle(
                                                                                                      decoration: TextDecoration.underline,
                                                                                                      color: grey,
                                                                                                      fontSize: 12,
                                                                                                      fontFamily: 'ProximaNova-Medium'),)),
                                                                                            // Icon(Icons.call),
                                                                                            Image(
                                                                                              image: callicon,
                                                                                              width: 14,
                                                                                              height: 14,),
                                                                                            TextButton(
                                                                                                onPressed: () => setState(() {
                                                                                                  _phone = props.compastride.pastRides[index].ownerDetails.phoneNumber;
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
                                                                            child: props.compastride.pastRides[index].commuterDetails.length==0
                                                                                ? Center(child: Text("Passengers not found ", style: TextStyle(color:black))):
                                                                            ListView.builder(
                                                                                itemCount:props.compastride.pastRides[index].commuterDetails.length,
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
                                                                                                     backgroundImage:NetworkImage("https://expertphotography.com/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg"),
                                                                                                        radius: getDevicewidth(context, 0.07) //25.0,
                                                                                                    ),
                                                                                                    Padding(
                                                                                                      padding: EdgeInsets.only(top:18,left: 5),
                                                                                                      child: Text(props.compastride.pastRides[indx].commuterDetails[index].firstName+' '+
                                                                                                          props.compastride.pastRides[indx].commuterDetails[index].lastName,
                                                                                                        style: TextStyle(fontSize: 14, color: black, fontFamily: 'ProximaNova-Medium'),),
                                                                                                    ),
                                                                                                  ]))),
                                                                                      Divider(color:grey,height: 10,thickness: 0.1,),
                                                                                    ],
                                                                                  );

                                                                                })
                                                                        )

                                                                      ]),
                                                                ),
                                                              );
                                                            });
                                                      });

                                                },
                                                child:Text(props.compastride.pastRides[index].ownerDetails.firstName+' '+props.compastride.pastRides[index].ownerDetails.lastName,
                                                  style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black),)),


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



class  CompastrideProps {
  final bool loading;
  final dynamic error;
  final Com_pastride_modal compastride;
  final Function compastrideapi;
  final Function clearprops;

  CompastrideProps({
    this.loading,
    this.error,
    this.compastride,
    this.compastrideapi,
    this.clearprops,
  });
}
CompastrideProps mapStateToProps(Store<AppState> store) {
  return  CompastrideProps(
    loading: store.state.compastride.loading,
    error: store.state.compastride.error,
    compastride: store.state.compastride.compastride,
    compastrideapi: (data)=>store.dispatch(compastride(data)),
    //clearprops: (data)=>store.dispatch(clearpropsupcomride(data)),
  );
}
