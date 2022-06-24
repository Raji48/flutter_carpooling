
import 'package:carpooling/Actions/veh_pastride_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/veh_pastride/veh_pastride_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/map.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

class Past extends StatefulWidget {
  @override
  _PastState createState() => _PastState();
}

class _PastState extends State<Past> {

  bool loader=false;
  String currenttime = "";
  bool cancelreq=false;
  Future<void> _launched;
  String _phone ;
  int vianum;
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
  void handleInitialBuild(PastProps props) {
    var addDT=currenttime;
    var  data = {
      "currentTime" :  addDT
    };
    props.vehpastrideapi(data);

  }
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PastProps>(
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
          if(props.vehpastride!=null) {
            loader=false;
            print("pastridesuccesss");
            body =
               Container(
                    child:  ListView.builder(
                        itemCount: props.vehpastride.pastRides.length,
                        itemBuilder: (context, index )
                        {
                          return Card(
                              child: Padding(
                                padding: EdgeInsets.all(17),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(props.vehpastride.pastRides[index].date,
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
                                                      Text(props.vehpastride.pastRides[index].startLocation.address,
                                                        style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                    ]),


                                      SizedBox(height: getDeviceheight(context, 0.02),),

                                             Row(
                                                children:[
                                                  Image(image:locationicon, width: 14,height: 14,),
                                                  Text(props.vehpastride.pastRides[index].endLocation.address,
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
                                              props.vehpastride.pastRides[index].timeSlotDetails.slotTime+" | "+
                                                props.vehpastride.pastRides[index].date
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
                                          if(props.vehpastride.pastRides[index].commutersDetails.length >0)
                                               CircleAvatar(
                                                     backgroundImage: NetworkImage("https://cultivatedculture.com/wp-content/uploads/2019/12/LinkedIn-Profile-Picture-Example-Madeline-Mann.jpeg"),
                                                     radius: getDevicewidth(context, 0.04)//25.0,
                                                 ),
                                                Padding(
                                                padding: EdgeInsets.only(left:getDevicewidth(context, 0.035)),
                                               child:props.vehpastride.pastRides[index].commutersDetails.length>1? CircleAvatar(
                                                    backgroundImage: NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                   radius: getDevicewidth(context, 0.04)//25.0,
                                                ):null
                                             ),
                                                Padding(
                                                 padding: EdgeInsets.only(left:getDevicewidth(context, 0.07)),
                                                  child: props.vehpastride.pastRides[index].commutersDetails.length>2 ? CircleAvatar(
                                                       backgroundImage: NetworkImage("http://www.goodmorningimageshddownload.com/wp-content/uploads/2020/03/Cute-Whatsapp-DP-7.jpg"),
                                                       radius: getDevicewidth(context, 0.04)//25.0,
                                                   ):null
                                                 ),
                                                Padding(
                                                  padding: EdgeInsets.only(left:getDevicewidth(context, 0.105)),
                                                  child: props.vehpastride.pastRides[index].commutersDetails.length>3 ? CircleAvatar(
                                                      backgroundImage: NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                       radius: getDevicewidth(context, 0.04)//25.0,
                                                   ):null
                                                ),
                                                 Padding(
                                                  padding: EdgeInsets.only(left:getDevicewidth(context, 0.140)),
                                                   child: props.vehpastride.pastRides[index].commutersDetails.length>4? CircleAvatar(
                                                      backgroundImage: NetworkImage("http://www.goodmorningimageshddownload.com/wp-content/uploads/2020/03/Cute-Whatsapp-DP-7.jpg"),
                                                      radius: getDevicewidth(context, 0.04)//25.0,
                                                   ):null
                                                ),

                                          ],
                                        ),
                                            TextButton(
                                                onPressed: (){
                                                  int indx;
                                                  print(props.vehpastride.pastRides[indx=index].commutersDetails.length);
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
                                                                                        Text(props.vehpastride.pastRides[index].startLocation.address,
                                                                                          style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                                                      ]),


                                                                        SizedBox(height: getDeviceheight(context, 0.02),),
                                                                               Row(
                                                                                  children:[
                                                                                    Image(image:locationicon, width: 14,height: 14,),
                                                                                    Text(props.vehpastride.pastRides[index].endLocation.address,
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
                                                                              Text(props.vehpastride.pastRides[index].timeSlotDetails.slotTime+' |'+
                                                                                  props.vehpastride.pastRides[index].date,
                                                                                style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular'),),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: getDeviceheight(context, 0.025),),
                                                                        Text("Via Points",style: TextStyle(color: grey,fontFamily: 'ProximaNova-Medium',fontSize: 16),),
                                                                  Container(
                                                                    height:props.vehpastride.pastRides[index].viaPointsDetails.length==3?getDeviceheight(context,0.15):props.vehpastride.pastRides[index].viaPointsDetails.length==2?getDeviceheight(context,0.075):getDeviceheight(context,0.042),
                                                                    child: ListView.builder(
                                                                      itemCount:props.vehpastride.pastRides[index].viaPointsDetails.length,
                                                                      itemBuilder: (context, index) {
                                                                        return Padding(
                                                                          padding: EdgeInsets.only(left: getDevicewidth(context,0.10),top:getDeviceheight(context, 0.01)),
                                                                          child: Container(
                                                                           child: Row(
                                                                              children: [
                                                                                Text((index+viaint).toString()+'.'),
                                                                                Image(image:locationicon, width: 14,height: 14,),
                                                                                Text(props.vehpastride.pastRides[indx].viaPointsDetails[index].address,
                                                                                style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: black),),
                                                                              ],
                                                                            )
                                                                          ),
                                                                        );
                                                                        }),
                                                                  ),

                                                                        Text("Passengers", style: TextStyle(color: grey, fontFamily: 'ProximaNova-Medium', fontSize: 16),),
                                                                        Container(
                                                                            height:props.vehpastride.pastRides[index].viaPointsDetails.length==3?getDeviceheight(context, 0.2):props.vehpastride.pastRides[index].viaPointsDetails.length==2?getDeviceheight(context, 0.25):getDeviceheight(context, 0.27),

                                                                            child:props.vehpastride.pastRides[index].commutersDetails.length==0
                                                                                ? Center(child: Text("Passengers not found ", style: TextStyle(color:black))):
                                                                            ListView.builder(
                                                                                itemCount:props.vehpastride.pastRides[indx].commutersDetails.length,
                                                                                itemBuilder: (context, index) {
                                                                                  return Column(
                                                                                    children: [
                                                                                      Container(
                                                                                                   child: Padding(
                                                                                                      padding: EdgeInsets.only(left: getDevicewidth(context, 0.04),top: getDeviceheight(context, 0.025) ),
                                                                                                      child: Row(
                                                                                                          children: [
                                                                                                            CircleAvatar(
                                                                                                              backgroundImage:NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                                                                                radius: getDevicewidth(context, 0.07) //25.0,

                                                                                                            ),
                                                                                                            Column(
                                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                children: [
                                                                                                                  Text(props.vehpastride.pastRides[indx].commutersDetails[index].firstName+" "+
                                                                                                                     props.vehpastride.pastRides[indx].commutersDetails[index].lastName,
                                                                                                                    style: TextStyle(fontSize: 14, color: black, fontFamily: 'ProximaNova-Medium'),),
                                                                                                                  Row(
                                                                                                                      children: [
                                                                                                                        Image(image: locblackicon, width: 14, height: 14,),
                                                                                                                        TextButton(
                                                                                                                            onPressed: () {
                                                                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Mapapp(
                                                                                                                                loclat:props.vehpastride.pastRides[indx].commutersDetails[index].requestDetails.startLocation.lat,
                                                                                                                                loclng:props.vehpastride.pastRides[indx].commutersDetails[index].requestDetails.startLocation.lng,
                                                                                                                                locadd:props.vehpastride.pastRides[indx].commutersDetails[index].requestDetails.startLocation.address,
                                                                                                                                locuserfname: props.vehpastride.pastRides[indx].commutersDetails[index].firstName,
                                                                                                                                locuserlname: props.vehpastride.pastRides[indx].commutersDetails[index].lastName,
                                                                                                                                loctime:props.vehpastride.pastRides[indx].timeSlotDetails.slotTime,
                                                                                                                                locdate:props.vehpastride.pastRides[indx].date
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
                                                                                                                              _phone =props.vehpastride.pastRides[indx].commutersDetails[index].phoneNumber;
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
                                                child:props.vehpastride.pastRides[index].commutersDetails.length>5?
                                                Text(" 5+ Passengers",style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: grey),):
                                                Text(props.vehpastride.pastRides[index].commutersDetails.length.toString()+ " Passengers",
                                                  style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: grey),)),


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

  viapointnum(int index) {
     vianum=index+1;
    print(vianum);
  }
}

class PastProps {
  final bool loading;
  final dynamic error;
  final Veh_owner_pastride_modal vehpastride ;
  final Function vehpastrideapi;
  final Function clearprops;

  PastProps({
    this.loading,
    this.error,
    this.vehpastride,
    this.vehpastrideapi,
    this.clearprops,
  });
}
PastProps mapStateToProps(Store<AppState> store) {
  return  PastProps(
    loading: store.state.vehpastride.loading,
    error: store.state.vehpastride.error,
    vehpastride: store.state.vehpastride.vehpastride,
    vehpastrideapi: (data)=>store.dispatch(vehpastride(data)),
    //clearprops: (data)=>store.dispatch(clearpropsupcomride(data)),
  );

}
