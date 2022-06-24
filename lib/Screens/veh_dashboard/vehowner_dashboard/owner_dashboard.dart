




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

class Ownerdashboard extends StatefulWidget {
  @override
  _OwnerdashboardState createState() => _OwnerdashboardState();
}

class _OwnerdashboardState extends State<Ownerdashboard> {
  bool req=true;
  bool reqaccept=false;
  bool reqcancel=false;
  bool loader=false;
  bool x=true;
  bool endride=false;
  String currenttime="";
  Future<void> _launched;
  String _phone ;
  int viaint=1;


  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initState(){
    var addDt = DateTime.now();
    currenttime= addDt.toString();
    print("currentime"+currenttime);
  }
  // @override
  void handleInitialBuild(VehupcomrideProps props) {
    var addDT=currenttime;
    var  data = {
      "currentTime" :  addDT
    };
    props.vehupcomrideapi(data);

  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, VehupcomrideProps>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),

        builder: (context, props) {
          Widget body;
          if (props.loading) {
            body = Center(
              child: CircularProgressIndicator(),
            );
            //loader=true;
          }
          else
          if(props.vehupcomride!=null) {
            loader=false;
            print("successs");
            body=Stack(
                children: [
                  GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: SafeArea(
                          child: Container(
                              child: Column(
                                  children: <Widget>[
                                    topscreen(),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                          color: white,
                                          width: double.infinity,
                                          child: Stack(
                                              children: [
                                                SizedBox(height: getDeviceheight(context, 0.1),),
                                                  Padding(
                                                    padding:  EdgeInsets.only(left: getDevicewidth(context, 0.06,),top: getDeviceheight(context, 0.01),right: 1 ),
                                                    child: Text("Upcoming Rides"
                                                      ,style: TextStyle(fontFamily: 'ProximaNova-Bold',color: black,fontSize: 18),),
                                                  ),
                                                new ListView.builder
                                                  (
                                                    itemCount:props.vehupcomride.upcomingRides.length,
                                                    itemBuilder: (context, index ) {  //BuildContext ctxt, int index
                                                      return Padding(
                                                        padding: EdgeInsets.only(left: getDevicewidth(context, 0.05,),top: getDeviceheight(context, 0.03),right: 1 ),
                                                        child: new Container(
                                                            child: Card(
                                                              color: white,
                                                              child: Padding(
                                                                padding:  EdgeInsets.only(left:getDevicewidth(context,0.025)),
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                        .start,
                                                                    children: [
                                                                      SizedBox(height:getDeviceheight(context, 0.03)),
                                                                      Text(
                                                                        props.vehupcomride.upcomingRides[index].date,
                                                                        style:TextStyle(fontFamily: 'ProximaNova-Regular',color:grey,fontSize: 14)),
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          SizedBox(height: getDeviceheight(context, 0.02),),
                                                                          TextButton(onPressed:(){
                                                                            int indx;
                                                                            print(props.vehupcomride.upcomingRides[indx=index].commutersDetails.length);
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
                                                                                                          Image(image:locationicon, width: 14,height: 14,),
                                                                                                          Text(props.vehupcomride.upcomingRides[index].startLocation.address,
                                                                                                            style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                                                                                        ]),

                                                                                                  SizedBox(height: getDeviceheight(context, 0.02),),
                                                                                                          Row(
                                                                                                              children:[
                                                                                                                Image(image:locationicon, width: 14,height: 14,),
                                                                                                                Text(props.vehupcomride.upcomingRides[index].endLocation.address,
                                                                                                                    style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                                                                                                              ]),
                                                                                                      ],),
                                                                                                      ],),


                                                                                                          SizedBox(height: getDeviceheight(context, 0.02),),
                                                                                        Padding(
                                                                                           padding: EdgeInsets.only(left: getDevicewidth(context, 0.10)),
                                                                                                        child:  Row(
                                                                                                            children: [
                                                                                                              Image(image:clockicon, width: 14,height: 14,),
                                                                                                              Text(props.vehupcomride.upcomingRides[index].timeSlotDetails.slotTime+' | '+
                                                                                                                  props.vehupcomride.upcomingRides[index].date,
                                                                                                                style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular'),),
                                                                                                            ],
                                                                                                          )),


                                                                                                  SizedBox(height: getDeviceheight(context, 0.025),),
                                                                                                  Text("Via Points",style: TextStyle(color: grey,fontFamily: 'ProximaNova-Medium',fontSize: 16),),
                                                                                                  Container(
                                                                                                    height:props.vehupcomride.upcomingRides[index].viaPointsDetails.length==3?getDeviceheight(context,0.12):props.vehupcomride.upcomingRides[index].viaPointsDetails.length==3?getDeviceheight(context,0.072):getDeviceheight(context,0.045),
                                                                                                    child: ListView.builder(
                                                                                                        itemCount: props.vehupcomride.upcomingRides[index].viaPointsDetails.length,
                                                                                                        itemBuilder: (context, index) {
                                                                                                          return Padding(
                                                                                                            padding: EdgeInsets.only(left: getDevicewidth(context,0.10),top:getDeviceheight(context, 0.01)),
                                                                                                            child: Container(
                                                                                                                child: Row(
                                                                                                                  children: [
                                                                                                                    Text((index+viaint).toString()+'.'),
                                                                                                                    Image(image:locationicon, width: 14,height: 14,),
                                                                                                                    Text(props.vehupcomride.upcomingRides[indx].viaPointsDetails[index].address,
                                                                                                                      style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: black),),
                                                                                                                  ],
                                                                                                                )
                                                                                                            ),
                                                                                                          );
                                                                                                        }),
                                                                                                  ),
                                                                                                  Text("Passengers", style: TextStyle(color: grey, fontFamily: 'ProximaNova-Medium', fontSize: 16),),
                                                                                                  Container(
                                                                                                      height:props.vehupcomride.upcomingRides[index].viaPointsDetails.length==3?getDeviceheight(context, 0.2):props.vehupcomride.upcomingRides[index].viaPointsDetails.length==2?getDeviceheight(context, 0.25):getDeviceheight(context, 0.27),
                                                                                                      child:props.vehupcomride.upcomingRides[index].commutersDetails.length==0
                                                                                                          ? Center(child: Text("Passengers not found ", style: TextStyle(color:black))):
                                                                                                      ListView.builder(
                                                                                                          itemCount:props.vehupcomride.upcomingRides[index].commutersDetails.length,
                                                                                                          itemBuilder: (context, index) {
                                                                                                            return  Column(
                                                                                                              children: [
                                                                                                                Container(
                                                                                                                  child: Padding(
                                                                                                                    padding: EdgeInsets.only(left: getDevicewidth(context, 0.04),top: getDeviceheight(context, 0.025)),
                                                                                                                    child:Row(
                                                                                                                        children: [
                                                                                                                          CircleAvatar(
                                                                                                                             backgroundImage:NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                                                                                              radius: getDevicewidth(context, 0.07) //25.0,
                                                                                                                          ),

                                                                                                                          Column(
                                                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                              children: [
                                                                                                                                Text(props.vehupcomride.upcomingRides[indx].commutersDetails[index].firstName+" "+
                                                                                                                                    props.vehupcomride.upcomingRides[indx].commutersDetails[index].lastName,
                                                                                                                                  style: TextStyle(fontSize: 14, color: black, fontFamily: 'ProximaNova-Medium'),),
                                                                                                                                Row(
                                                                                                                                    children: [
                                                                                                                                      Image(image: locblackicon, width: 14, height: 14,),
                                                                                                                                      TextButton(
                                                                                                                                          onPressed: () {
                                                                                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Mapapp(
                                                                                                                                                loclat:props.vehupcomride.upcomingRides[indx].commutersDetails[index].requestDetails.startLocation.lat,
                                                                                                                                                loclng:props.vehupcomride.upcomingRides[indx].commutersDetails[index].requestDetails.startLocation.lng,
                                                                                                                                                locadd:props.vehupcomride.upcomingRides[indx].commutersDetails[index].requestDetails.startLocation.address,
                                                                                                                                                locuserfname: props.vehupcomride.upcomingRides[indx].commutersDetails[index].firstName,
                                                                                                                                                locuserlname:  props.vehupcomride.upcomingRides[indx].commutersDetails[index].lastName,
                                                                                                                                                loctime:props.vehupcomride.upcomingRides[indx].timeSlotDetails.slotTime,
                                                                                                                                                locdate:props.vehupcomride.upcomingRides[indx].date
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
                                                                                                                                            _phone =props.vehupcomride.upcomingRides[indx].commutersDetails[index].phoneNumber;
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
                                                                                                                        ])
                                                                                                                  ),
                                                                                                                  //])
                                                                                                                ),
                                                                                                                Divider(color:grey,height: 10,thickness: 0.1,),
                                                                                                              ],
                                                                                                            );

                                                                                                          })),


                                                                                                ]),
                                                                                          ),
                                                                                        );
                                                                                      });
                                                                                });
                                                                          },
                                                                              child: offloclng==props.vehupcomride.upcomingRides[index].endLocation.lng?
                                                                              Text("Ride to Office", style: TextStyle(fontSize: 16, fontFamily: 'ProximaNova-Medium', color: black,)):
                                                                          Text("Ride to Home", style: TextStyle(fontSize: 16, fontFamily: 'ProximaNova-Medium', color: black,))),
                                                                          SizedBox(height: getDeviceheight(context, 0.01),),
                                                                          //  new Flexible(child:
                                                                          Row(
                                                                              children: [
                                                                                new Flexible(
                                                                                    child:
                                                                                    Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          Text(totalseats,style: TextStyle(fontFamily: 'ProximaNova-Medium',color:grey,fontSize: 12),),
                                                                                          SizedBox(height: getDeviceheight(context, 0.01),),
                                                                                          Center(
                                                                                              child: Text(props.vehupcomride.upcomingRides[index].totalSeats.toString(),
                                                                                                style: TextStyle(
                                                                                                    fontSize: 16,fontFamily: 'ProximaNova-Medium',color: bluenum),))
                                                                                        ]
                                                                                    )),
                                                                                //  SizedBox(width: 20,),
                                                                                new Flexible(
                                                                                    child:
                                                                                    Column(
                                                                                        children: [
                                                                                          Text(seatsfilled,style: TextStyle(fontFamily: 'ProximaNova-Medium',color:grey,fontSize: 12),),
                                                                                          SizedBox(height: getDeviceheight(context, 0.01),),
                                                                                          Center(
                                                                                              child: Text(
                                                                                                props.vehupcomride.upcomingRides[index].seatsFilled.toString(),
                                                                                                style: TextStyle(
                                                                                                    fontSize: 16,fontFamily: 'ProximaNova-Medium', color: green),))
                                                                                        ]
                                                                                    )),
                                                                                //  SizedBox(width: 20,),
                                                                                new Flexible(
                                                                                    child:
                                                                                    Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                                        children: [
                                                                                          Stack(
                                                                                            children: [
                                                                                              ButtonTheme(
                                                                                                  minWidth: 30,
                                                                                                  height: getDeviceheight(context,0.035),
                                                                                                  shape: RoundedRectangleBorder(
                                                                                                      borderRadius: BorderRadius.circular(10)),
                                                                                                  child: FlatButton(
                                                                                                      color:bluelight, //tealaccentlight,
                                                                                                      onPressed: () {
                                                                                                        int indexx;
                                                                                                        print(props.vehupcomride.upcomingRides[indexx=index].commutersDetails.length);
                                                                                                        print(indexx);
                                                                                                        print(accesstoken);
                                                                                                        showModalBottomSheet(
                                                                                                            context: context,
                                                                                                            shape: topBorder,
                                                                                                            isScrollControlled: true,
                                                                                                            builder: (context) {
                                                                                                              return StatefulBuilder(
                                                                                                                  builder: (
                                                                                                                      BuildContext context,
                                                                                                                      StateSetter setModalState,) {
                                                                                                                    //   return riderequests();
                                                                                                                    return Container(
                                                                                                                        height: getDeviceheight(context, 0.65),
                                                                                                                        child: Stack(
                                                                                                                            children: [
                                                                                                                              Padding(
                                                                                                                                padding: EdgeInsets.only(top: getDeviceheight(context, 0.05), left: 20),
                                                                                                                                child: Text(ridereq,
                                                                                                                                  style: TextStyle(fontSize: 20,color:black, fontFamily: 'ProximaNova-Semiboldstyle',),),
                                                                                                                              ),

                                                                                                                              Padding(
                                                                                                                                padding: EdgeInsets.only(top: getDevicewidth(context, 0.2),left:getDevicewidth(context, 0.01)),
                                                                                                                                child:props.vehupcomride.upcomingRides[index].commutersDetails.length == 0
                                                                                                                                    ? Center(child: Text("No Request ", style: TextStyle(color:black))):
                                                                                                                               new ListView.builder(
                                                                                                                                    itemCount:props.vehupcomride.upcomingRides[indexx].commutersDetails.length,
                                                                                                                                   itemBuilder: (context,index) { //BuildContext ctxt, int index
                                                                                                                                      return  Column(
                                                                                                                                        children: [

                                                                                                                                          Container(
                                                                                                                                              child: Padding(
                                                                                                                                                padding: EdgeInsets.only(left: getDevicewidth(context,0.01),bottom:getDeviceheight(context,0.003)),
                                                                                                                                                child: Row(
                                                                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                                    children: [
                                                                                                                                                      CircleAvatar(
                                                                                                                                                        backgroundImage:NetworkImage("https://miro.medium.com/max/2048/0*0fClPmIScV5pTLoE.jpg"),
                                                                                                                                                          radius: getDevicewidth(context, 0.07) //25.0,
                                                                                                                                                      ),
                                                                                                                                                      Column(
                                                                                                                                                          crossAxisAlignment: CrossAxisAlignment
                                                                                                                                                              .start,
                                                                                                                                                          children: [
                                                                                                                                                            Text(
                                                                                                                                                              props.vehupcomride.upcomingRides[indexx].commutersDetails[index].firstName + '\t' + props.vehupcomride.upcomingRides[indexx].commutersDetails[index].lastName,
                                                                                                                                                              style: TextStyle(
                                                                                                                                                                  fontSize: 18,
                                                                                                                                                                  color: grey,
                                                                                                                                                                  fontFamily: 'ProximaNova-Medium'),),
                                                                                                                                                            Row(
                                                                                                                                                                children: [
                                                                                                                                                                  Image(
                                                                                                                                                                    image: locblackicon,
                                                                                                                                                                    width: 14,
                                                                                                                                                                    height: 14,),
                                                                                                                                                                  TextButton(
                                                                                                                                                                      onPressed: () {
                                                                                                                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Mapapp(
                                                                                                                                                                         loclat:props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.startLocation.lat,
                                                                                                                                                                         loclng:props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.startLocation.lng,
                                                                                                                                                                            locadd:props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.startLocation.address,
                                                                                                                                                                            locuserfname:props.vehupcomride.upcomingRides[indexx].commutersDetails[index].firstName,
                                                                                                                                                                            locuserlname:props.vehupcomride.upcomingRides[indexx].commutersDetails[index].lastName,
                                                                                                                                                                            loctime:props.vehupcomride.upcomingRides[indexx].timeSlotDetails.slotTime,
                                                                                                                                                                            locdate:props.vehupcomride.upcomingRides[indexx].date
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
                                                                                                                                                                          _phone = props.vehupcomride.upcomingRides[indexx].commutersDetails[index].phoneNumber;
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
                                                                                                                                                      if(props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isRejected==false && props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isAccepted==false && props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isCancelled==false)
                                                                                                                                                        new Flexible(
                                                                                                                                                          child:
                                                                                                                                                          Row(
                                                                                                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                                                                                              children: [
                                                                                                                                                                SizedBox(width: 1,),
                                                                                                                                                                Container(
                                                                                                                                                                    child: Container(
                                                                                                                                                                      decoration: BoxDecoration(
                                                                                                                                                                        color: white,
                                                                                                                                                                        border: Border.all(color: grey), shape: BoxShape.circle,
                                                                                                                                                                      ),
                                                                                                                                                                      height: 40.0,
                                                                                                                                                                      width: 40.0,
                                                                                                                                                                      child: Center(
                                                                                                                                                                        child: IconButton(
                                                                                                                                                                          icon: Icon(
                                                                                                                                                                            Icons.close, color: red,),
                                                                                                                                                                          onPressed: () async {
                                                                                                                                                                            final prefs = await SharedPreferences
                                                                                                                                                                                .getInstance();
                                                                                                                                                                            final key = 'token';
                                                                                                                                                                            final value = prefs
                                                                                                                                                                                .get(
                                                                                                                                                                                key) ??
                                                                                                                                                                                0;
                                                                                                                                                                            print(
                                                                                                                                                                                value);
                                                                                                                                                                            var data = {
                                                                                                                                                                              "requestId": props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.requestId
                                                                                                                                                                            };
                                                                                                                                                                            var url = BASE_URL +
                                                                                                                                                                                VEH_OWNER_REJECT_REQ;
                                                                                                                                                                            try {
                                                                                                                                                                              var response = await dio
                                                                                                                                                                                  .put(
                                                                                                                                                                                  url,
                                                                                                                                                                                  data: data,
                                                                                                                                                                                  options: Options(
                                                                                                                                                                                      headers: {
                                                                                                                                                                                        //  headerAuth: headerAuthToken,
                                                                                                                                                                                        headerAuth: "jwt $value",
                                                                                                                                                                                      },
                                                                                                                                                                                      validateStatus: (
                                                                                                                                                                                          status) {
                                                                                                                                                                                        return status <
                                                                                                                                                                                            500;
                                                                                                                                                                                      }
                                                                                                                                                                                  )
                                                                                                                                                                              );
                                                                                                                                                                              print(response.data);
                                                                                                                                                                              if (response.statusCode == 200) {
                                                                                                                                                                                print(response.data);
                                                                                                                                                                                // var addDT=currenttime;
                                                                                                                                                                                // var  data = {
                                                                                                                                                                                //   "currentTime" :  addDT
                                                                                                                                                                                // };
                                                                                                                                                                                // props.vehupcomrideapi(data);

                                                                                                                                                                                setModalState(() {
                                                                                                                                                                                //  req = false;
                                                                                                                                                                             //     reqcancel = true;
                                                                                                                                                                                  props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isAccepted=false;
                                                                                                                                                                                  props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isCancelled=false;
                                                                                                                                                                                  props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isRejected=true;
                                                                                                                                                                                });
                                                                                                                                                                              } else
                                                                                                                                                                              if (response.statusCode > 200) {
                                                                                                                                                                                print(response.statusCode);
                                                                                                                                                                              }
                                                                                                                                                                              else {

                                                                                                                                                                              }
                                                                                                                                                                            } catch (e) {

                                                                                                                                                                            }
                                                                                                                                                                          },
                                                                                                                                                                        ),
                                                                                                                                                                      ),
                                                                                                                                                                    )),

                                                                                                                                                                Container(
                                                                                                                                                                  child: Container(
                                                                                                                                                                    decoration: BoxDecoration(
                                                                                                                                                                      color: white,
                                                                                                                                                                      border: Border.all(color: grey),
                                                                                                                                                                      shape: BoxShape.circle,),
                                                                                                                                                                    height: 40.0,
                                                                                                                                                                    width: 40.0,
                                                                                                                                                                    child: Center(
                                                                                                                                                                        child: IconButton(
                                                                                                                                                                          icon: Icon(
                                                                                                                                                                            Icons.done,
                                                                                                                                                                            color: green,),
                                                                                                                                                                          onPressed: () async {
                                                                                                                                                                            final prefs = await SharedPreferences
                                                                                                                                                                                .getInstance();
                                                                                                                                                                            final key = 'token';
                                                                                                                                                                            final value = prefs.get(key) ?? 0;
                                                                                                                                                                            print(value);
                                                                                                                                                                            var data = {
                                                                                                                                                                              "requestId": props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.requestId
                                                                                                                                                                            };
                                                                                                                                                                            var url = BASE_URL + VEH_OWNER_ACCEPT_REQ;
                                                                                                                                                                            print(url);
                                                                                                                                                                            print(data);
                                                                                                                                                                            try {
                                                                                                                                                                              var response = await dio.put(url, data: data,
                                                                                                                                                                                  options: Options(
                                                                                                                                                                                      headers: {
                                                                                                                                                                                        headerAuth: "jwt $value",
                                                                                                                                                                                      },
                                                                                                                                                                                      validateStatus: (status) {
                                                                                                                                                                                        return status < 500;
                                                                                                                                                                                      }
                                                                                                                                                                                  )
                                                                                                                                                                              );
                                                                                                                                                                              print(response.data);
                                                                                                                                                                              if (response.statusCode == 200) {
                                                                                                                                                                                print(response.data);
                                                                                                                                                                                setModalState(() {
                                                                                                                                                                                  props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isAccepted=true;
                                                                                                                                                                                  props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isCancelled=false;
                                                                                                                                                                                  props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isRejected=false;
                                                                                                                                                                                });
                                                                                                                                                                              } else
                                                                                                                                                                              if (response
                                                                                                                                                                                  .statusCode >
                                                                                                                                                                                  200) {
                                                                                                                                                                                print(
                                                                                                                                                                                    response
                                                                                                                                                                                        .statusCode);
                                                                                                                                                                              }
                                                                                                                                                                              else {

                                                                                                                                                                              }
                                                                                                                                                                            } catch (e) {

                                                                                                                                                                            }
                                                                                                                                                                          },
                                                                                                                                                                          // Your Widget
                                                                                                                                                                        )),
                                                                                                                                                                  ),
                                                                                                                                                                ),

                                                                                                                                                              ])),
                                                                                                                                                      if(props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isRejected==true)
                                                                                                                                                       Column(
                                                                                                                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                                                                        children: [
                                                                                                                                                          TextButton.icon(
                                                                                                                                                              icon: Image(
                                                                                                                                                                  image: bluetickicon,
                                                                                                                                                                  width: 14,
                                                                                                                                                                  height: 10),
                                                                                                                                                              label: Text(
                                                                                                                                                                "Request Rejected",
                                                                                                                                                                style: TextStyle(
                                                                                                                                                                    color: blue,
                                                                                                                                                                    fontFamily: 'ProximaNova-Regular',
                                                                                                                                                                    fontSize: 10),)),
                                                                                                                                                          ButtonTheme(
                                                                                                                                                              shape: RoundedRectangleBorder(
                                                                                                                                                                  borderRadius: BorderRadius.circular(10)),
                                                                                                                                                              child: OutlineButton(
                                                                                                                                                                  onPressed: () async {
                                                                                                                                                                     final prefs = await SharedPreferences.getInstance();
                                                                                                                                                                      final key = 'token';
                                                                                                                                                                      final value = prefs.get(key ) ?? 0;
                                                                                                                                                                      print(value);
                                                                                                                                                                      var data={
                                                                                                                                                                        "requestId" : props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.requestId
                                                                                                                                                                      };
                                                                                                                                                                      var url = BASE_URL+VEH_OWNER_RESET_REQ;
                                                                                                                                                                      try{
                                                                                                                                                                        var response = await dio.put(url, data: data,
                                                                                                                                                                            options: Options(
                                                                                                                                                                                headers: {
                                                                                                                                                                                  headerAuth: "jwt $value",
                                                                                                                                                                                },
                                                                                                                                                                                validateStatus: (status) { return status < 500; }
                                                                                                                                                                            )
                                                                                                                                                                        );
                                                                                                                                                                        print(response.data);
                                                                                                                                                                        if (response.statusCode == 200){
                                                                                                                                                                          print(response.data);
                                                                                                                                                                          setModalState(() {
                                                                                                                                                                            props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isRejected=false;
                                                                                                                                                                            props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isAccepted=false;
                                                                                                                                                                            props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isCancelled=false;
                                                                                                                                                                          });

                                                                                                                                                                        } else if(response.statusCode>200){
                                                                                                                                                                          print(response.statusCode);
                                                                                                                                                                        }
                                                                                                                                                                        else {

                                                                                                                                                                        }
                                                                                                                                                                      }catch(e){

                                                                                                                                                                      }
                                                                                                                                                                  },
                                                                                                                                                                  child: Text("cancel",
                                                                                                                                                                    style: TextStyle(color: red, fontFamily: 'ProximaNova-Regular', fontSize: 12),)
                                                                                                                                                              )),
                                                                                                                                                        ],
                                                                                                                                                      ),
                                                                                                                                                      if(props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isAccepted==true)
                                                                                                                                                        Column(
                                                                                                                                                        children: [
                                                                                                                                                          TextButton.icon(
                                                                                                                                                              icon: Image(
                                                                                                                                                                  image: bluetickicon,
                                                                                                                                                                  width: 14,
                                                                                                                                                                  height: 10),
                                                                                                                                                              label:
                                                                                                                                                              Text(
                                                                                                                                                                  "Request Accepted",
                                                                                                                                                                  style: TextStyle(
                                                                                                                                                                      color: blue,
                                                                                                                                                                      fontFamily: 'ProximaNova-Regular',
                                                                                                                                                                      fontSize: 10))),
                                                                                                                                                          ButtonTheme(
                                                                                                                                                              shape: RoundedRectangleBorder(
                                                                                                                                                                  borderRadius: BorderRadius.circular(10)),
                                                                                                                                                              child: OutlineButton(
                                                                                                                                                                  onPressed: () async {
                                                                                                                                                                       final prefs = await SharedPreferences.getInstance();
                                                                                                                                                                    final key = 'token';
                                                                                                                                                                    final value = prefs.get(key ) ?? 0;
                                                                                                                                                                    print(value);
                                                                                                                                                                    var data={
                                                                                                                                                                      "requestId" : props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.requestId
                                                                                                                                                                    };
                                                                                                                                                                    var url = BASE_URL+VEH_OWNER_RESET_REQ;
                                                                                                                                                                    try{
                                                                                                                                                                      var response = await dio.put(url, data: data,
                                                                                                                                                                          options: Options(
                                                                                                                                                                              headers: {
                                                                                                                                                                                headerAuth: "jwt $value",
                                                                                                                                                                              },
                                                                                                                                                                              validateStatus: (status) { return status < 500; }
                                                                                                                                                                          )
                                                                                                                                                                      );
                                                                                                                                                                      print(response.data);
                                                                                                                                                                      if (response.statusCode == 200){
                                                                                                                                                                        print(response.data);
                                                                                                                                                                        setModalState(() {
                                                                                                                                                                          props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isRejected=false;
                                                                                                                                                                          props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isAccepted=false;
                                                                                                                                                                          props.vehupcomride.upcomingRides[indexx].commutersDetails[index].requestDetails.isCancelled=false;
                                                                                                                                                                        });

                                                                                                                                                                      } else if(response.statusCode>200){
                                                                                                                                                                        print(response.statusCode);

                                                                                                                                                                      }
                                                                                                                                                                      else {

                                                                                                                                                                      }
                                                                                                                                                                    }catch(e){

                                                                                                                                                                    }
                                                                                                                                                                  },
                                                                                                                                                                  child: Text("cancel",style: TextStyle(color: red, fontFamily: 'ProximaNova-Regular', fontSize: 12),)
                                                                                                                                                              )),
                                                                                                                                                        ],
                                                                                                                                                      ),

                                                                                                                                                    ]
                                                                                                                                                ),
                                                                                                                                              ),



                                                                                                                                          ),
                                                                                                                                          Divider(color:grey,height: 10,thickness: 0.1,),
                                                                                                                                        ],
                                                                                                                                      );

                                                                                                                                    }
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                            ])
                                                                                                                    );

                                                                                                                  }
                                                                                                              );
                                                                                                            });
                                                                                                      },
                                                                                                      child: Text(viewrequests,style: TextStyle(fontSize: 12,fontFamily: 'ProximaNova-Medium',color: black),)
                                                                                                  )),
                                                                                              Padding(padding:EdgeInsets.only(left: 100),
                                                                                                  child:props.vehupcomride.upcomingRides[index].commutersDetails.length>0?
                                                                                                  Container(
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: red,
                                                                                                        shape: BoxShape.circle,),
                                                                                                      height: 20.0,
                                                                                                      width: 20,
                                                                                                      child:Center(child: Text(props.vehupcomride.upcomingRides[index].commutersDetails.length.toString(),
                                                                                                        style: TextStyle(fontFamily: 'ProximaNova-Medium',color: white,fontSize: 10),)
                                                                                                      )):Container())
                                                                                            ],
                                                                                          ),
                                                                                          if(props.vehupcomride.upcomingRides[index].isStarted==false)
                                                                                          ButtonTheme(
                                                                                              minWidth: 50,
                                                                                              height:getDeviceheight(context,0.04),
                                                                                              shape: RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.circular(10)),
                                                                                              child: FlatButton(
                                                                                                  color: black,
                                                                                                  onPressed: () async {
                                                                                                    print("rideidis");
                                                                                                    print( props.vehupcomride.upcomingRides[index].id);
                                                                                                    var data=
                                                                                                      {
                                                                                                        "rideId" : props.vehupcomride.upcomingRides[index].id
                                                                                                      };
                                                                                                    final prefs = await SharedPreferences.getInstance();
                                                                                                    final key = 'token';
                                                                                                    final value = prefs.get(key ) ?? 0;
                                                                                                    print(value);
                                                                                                    var url = BASE_URL+VEH_OWNER_START_RIDE;
                                                                                                    try{
                                                                                                      var response = await dio.put(url, data: data,
                                                                                                          options: Options(
                                                                                                              headers: {
                                                                                                                headerAuth: "jwt $value",
                                                                                                              },
                                                                                                              validateStatus: (status) { return status < 500; }
                                                                                                          )
                                                                                                      );
                                                                                                      print(response.data);
                                                                                                      if (response.statusCode == 200){
                                                                                                        print(response.data);
                                                                                                        var addDT=currenttime;
                                                                                                        var  data = {
                                                                                                          "currentTime" :  addDT
                                                                                                        };
                                                                                                        props.vehupcomrideapi(data);



                                                                                                      } else if(response.statusCode>200){
                                                                                                        print(response.statusCode);

                                                                                                      }
                                                                                                      else {

                                                                                                      }
                                                                                                    }catch(e){

                                                                                                    }

                                                                                                  },
                                                                                                  child: Text(startride,
                                                                                                    style: TextStyle(color: white,fontFamily: 'ProximaNova-Medium',fontSize: 12),)
                                                                                              )),
                                                                                          if(props.vehupcomride.upcomingRides[index].isStarted==true &&props.vehupcomride.upcomingRides[index].isCompleted==false)
                                                                                          ButtonTheme(
                                                                                              minWidth: 50,
                                                                                              height:getDeviceheight(context,0.04),
                                                                                              shape: RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.circular(10)),
                                                                                              child: RaisedButton(
                                                                                                  color: red,
                                                                                                  onPressed: () async {
                                                                                                    print( props.vehupcomride.upcomingRides[index].id);
                                                                                                    var data=
                                                                                                    {
                                                                                                      "rideId" : props.vehupcomride.upcomingRides[index].id
                                                                                                    };
                                                                                                    final prefs = await SharedPreferences.getInstance();
                                                                                                    final key = 'token';
                                                                                                    final value = prefs.get(key ) ?? 0;
                                                                                                    print(value);
                                                                                                    var url = BASE_URL+VEH_OWNER_COMPLETE_RIDE;
                                                                                                    try{
                                                                                                      var response = await dio.put(url, data: data,
                                                                                                          options: Options(
                                                                                                              headers: {
                                                                                                                headerAuth: "jwt $value",
                                                                                                              },
                                                                                                              validateStatus: (status) { return status < 500; }
                                                                                                          )
                                                                                                      );
                                                                                                      print(response.data);
                                                                                                      if (response.statusCode == 200){
                                                                                                        print(response.data);
                                                                                                        var addDT=currenttime;
                                                                                                        var  data = {
                                                                                                          "currentTime" :  addDT
                                                                                                        };
                                                                                                        props.vehupcomrideapi(data);



                                                                                                      } else if(response.statusCode>200){
                                                                                                        print(response.statusCode);

                                                                                                      }
                                                                                                      else {

                                                                                                      }
                                                                                                    }catch(e){

                                                                                                    }

                                                                                                  },
                                                                                                  child:Text("End Ride",
                                                                                                    style: TextStyle(color: white,fontFamily: 'ProximaNova-Medium',fontSize: 12),)
                                                                                              )),
                                                                                          if(props.vehupcomride.upcomingRides[index].isStarted==true && props.vehupcomride.upcomingRides[index].isCompleted==true)
                                                                                            ButtonTheme(
                                                                                                minWidth: 50,
                                                                                                height:getDeviceheight(context,0.04),
                                                                                                shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius.circular(10)),
                                                                                                child: RaisedButton(
                                                                                                    color: whitelight,
                                                                                                    onPressed: () async {

                                                                                                    },
                                                                                                    child:Text("Ride complete",
                                                                                                      style: TextStyle(color: greylight,fontFamily: 'ProximaNova-Medium',fontSize: 12),)
                                                                                                )),
                                                                                        ]
                                                                                    )),
                                                                              ]
                                                                          )

                                                                        ],
                                                                      )
                                                                    ]),
                                                              ),
                                                            )),
                                                      );
                                                    })

                                              ])

                                      ),
                                    ),

                                  ])))),
                  loader ? Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height,
                      color: Colors.black26,
                      child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: CircularProgressIndicator(),
                          )
                      )
                  ) : Container(),
                ]);
          }


          else if (props.error != null) {
            loader = false;
            x=false;
            print(props.error);
            print("error");
            body= Stack(
                children: [
                  Center(child:  Text("No upcoming Rides founds.Please schedule your Ride ",style: TextStyle(color: black),)),
                  GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: SafeArea(
                        //  child: SingleChildScrollView(
                        //child: Form(
                        //  key: formkey,
                          child: Container(
                            // padding: EdgeInsets.all(16),
                              child: Column(
                                //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    topscreen()
                                  ])
                          )))]);
          }
          return WillPopScope(
              onWillPop:(){
                Navigator.pushNamed(
                    context, '/Role');
              },
              child:
              Scaffold(
                backgroundColor: Colors.white12,
                resizeToAvoidBottomInset: true,
                body: body,
              ));
        });
  }

  topscreen() {
    return Container(
        height: getDeviceheight(context, 0.34),
        width: double.infinity,
        color: whitegrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: 10,),
            Text("Hello, " + username + "!",
                style: TextStyle(fontSize: 18, fontFamily: 'ProximaNova-Bold', color: black,)),
            Padding(
                padding: EdgeInsets.only(left: 15, right: 10,bottom: 1),
                child: Container(
                  height: getDeviceheight(context, 0.12),
                  width: getDevicewidth(context, 1),
                  decoration: BoxDecoration(color:white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image:NetworkImage("https://thumbs.dreamstime.com/b/compact-red-car-white-background-32767906.jpg"))  ,//image: carimage, fit: BoxFit.cover),
                      new Flexible(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("SKODA RAPID",style: TextStyle(fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 18,color: black),),
                          Text("TB 20 AD 1234",style: TextStyle(fontSize: 12,fontFamily: 'ProximaNova-Medium',color: grey),)
                        ],
                      ))
                    ],
                  ),

                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius
                        .circular(20),),
                  child: RaisedButton(
                      color: tealaccentlight,
                      onPressed: () {
                        Navigator.pushNamed(context, '/scheduleridevehicleowner');

                      },
                      child: Text(shcedulerides)
                  )),
            )
          ],
        )
    );
  }




  }

class VehupcomrideProps {
  final bool loading;
  final dynamic error;
  final Veh_owner_upcomingride_modal vehupcomride ;
  final Function vehupcomrideapi;
  final Function clearprops;

  VehupcomrideProps({
    this.loading,
    this.error,
    this.vehupcomride,
    this.vehupcomrideapi,
    this.clearprops,
  });
}
VehupcomrideProps mapStateToProps(Store<AppState> store) {
  return VehupcomrideProps(
    loading: store.state.vehupcomride.loading,
    error: store.state.vehupcomride.error,
    vehupcomride: store.state.vehupcomride.vehupcomride,
    vehupcomrideapi:(data)=>store.dispatch(vehupcomride(data)),
    clearprops: (data)=>store.dispatch(clearpropsupcomride(data)),
  );
}