import 'dart:async';

import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/updateschedule.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Timeslot extends StatefulWidget {
  @override
  _TimeslotState createState() => _TimeslotState();
}

enum SingingCharacter {next7day,all}
class _TimeslotState extends State<Timeslot> {
  String groupValue='';
  bool x=false;
  bool y=false;
  bool z=false;
  bool timecolor=true;
  bool selectdate=true;
  bool selectdateall=false;
  bool saveas=false;
 bool saveasoffice=false;
 bool saveashome=false;
 bool saveascolor=false;
 bool chooseloc=false;
  final _currentDate = DateTime.now();
  final _dateFormatter = DateFormat('d');
  final _dayFormatter = DateFormat('E');
  final _monthFormatter = DateFormat('MMM');
  List<LatLng> latlngSegment1 = List();
  Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  GoogleMapController mapController;
  LatLng SOURCE_LOCATION = V_pic_lng!=null?LatLng(V_pic_lat,V_pic_lng):LatLng(12.848598,80.225684);
  LatLng DEST_LOCATION = V_drop_lat!=null?LatLng(V_drop_lat,V_drop_lng):LatLng(12.848598,80.235684);
  bool border=false;
  bool border1=false;
  bool border2=false;
  bool border3=false;
  bool border4=false;
  bool border5=false;
  bool border6=false;
  bool closecontainer=false;
  bool closecontainer1=false;
  bool closecontainer2=false;
  bool closecontainer3=false;
  bool closecontainer4=false;
  bool closecontainer5=false;
  bool closecontainer6=false;
  SingingCharacter _character = SingingCharacter.next7day;
  bool changetextcolor=true;
  @override
  void initState() {
    super.initState();
    setState(() {
      v_Selectall="";
      time0="";
     time1="";
     time2="";
      time3="";
       time4="";
       time5="";
     time6="";
    });
    setCustomMapPin();
  }
  @override
  Widget build(BuildContext context) {
    final dates = <Widget>[];
    for (int i = 0; i < 7; i++) {
      final date = _currentDate.add(Duration(days: i));
      dateall.add(DateFormat.MMMEd().format(date));
      dates.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_dayFormatter.format(date)+', '+_monthFormatter.format(date)+' '+_dateFormatter.format(date),
            style: TextStyle(fontSize: 12,fontFamily: 'ProximaNova-Medium',color: black),),
        ],
      ));
    }
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: blacklight),
          backgroundColor: Colors.white,
          title: Text("Schedule Ride", style: TextStyle(fontSize: 18,fontFamily: 'ProximaNova-Medium',color: black)),
        ),
        body: Stack(
            children:[
                     Container(
                         height:MediaQuery.of(context).size.height / 3.5,
                         child: Stack(
                             children: [
                             GoogleMap(
                                 onMapCreated: (
                                     GoogleMapController googleMapController) {
                                   setMapPins();
                                   setpolyline();
                                   setState(() {
                                     mapController = googleMapController;
                                   });
                                 },
                             mapType: MapType.normal,
                             myLocationEnabled: true,
                                 markers:  _markers,
                                 polylines: _polyline,
                             initialCameraPosition: CameraPosition(
                               zoom: 14,
                                 target:LatLng(V_pic_lat,V_pic_lng))),

                        Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child:Column(
                                children: [
                                                Container(
                                                    height: 40,
                                                    color: white,
                                                    child:Row(
                                                        children:[
                                                          IconButton(
                                                              onPressed: () {
                                                              },
                                                              icon:Image(image:locationicon, width: 14,height: 14,)),
                                                          Text(V_pickup,style: TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 16,color:grey )),
                                                          new Flexible(child:
                                                          Align(
                                                              alignment:Alignment.topRight,
                                                              child:  IconButton(
                                                                onPressed: (){},
                                                                icon: Icon(Icons.close,color: grey,),
                                                              )
                                                          ))
                                                        ]
                                                    )
                                                ),
                                  Container(
                                        height: 40,
                                        color: white,
                                        child:Row(
                                            children:[
                                              IconButton(
                                                  onPressed: () {
                                                  },
                                                  icon:Image(image:locationicon,
                                                    width: 14,height: 14,)),
                                              Text(V_droploc,style: TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 16,color:grey )),
                                             new Flexible(child:
                                             Align(
                                               alignment:Alignment.topRight,//bottomRight,
                                            child:  Padding(
                                                padding: EdgeInsets.only(left:getDevicewidth(context, 0.01)),
                                                child: RaisedButton(
                                                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 6),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20)),
                                                  onPressed: () {
                                                    saveaslocation();
                                                  },
                                                  color:tealaccentcolor,
                                                  child: saveas?Row(
                                                      children:[
                                                    saveasoffice?Row(
                                                      children: [
                                                        Text("OFFICE",style: TextStyle(color: black,fontSize: 10,fontFamily: 'ProximaNova-Regular'),),
                                                        Image(image:officeicon,width:10,height:10,),
                                                      ],
                                                    )
                                                       : Row(
                                                         children: [
                                                           Text("HOME",style: TextStyle(color: black,fontSize: 10,fontFamily: 'ProximaNova-Regular'),),
                                                           Image(image:homeicon,width: 10,height: 10,),
                                                         ],
                                                       ),
                                                      ]):Text("Saveas",style: TextStyle(color: lightblack,fontFamily: 'ProximaNova-Regular')),

                                                )),
                                              )),
                                              new Flexible(child:
                                              Align(
                                                alignment:Alignment.topRight,
                                                    child:IconButton(
                                                      onPressed: (){},
                                                      icon: Icon(Icons.close,color: grey,),
                                                    )
                                              ))                       ]
                                        )
                                  ),

                                  Container(
                                        color: white,
                                        child:Row(
                                            children:[
                                              Text("via points:",style:TextStyle(fontFamily: 'ProximaNova-Bold',fontSize: 13),),
                                              new Flexible(child:   SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child:Padding(
                                                    padding: const EdgeInsets.only(right: 5,left: 5),
                                                    child: Container(
                                                        height: 40,
                                                        color: white,
                                                        child:Row(
                                                            children:[
                                                              Text(" 1."),Image(image:locationicon,width: 14,height: 14,),
                                                              Text(via1loc,style:TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 13)),
                                                           if(via2loc.isNotEmpty)
                                                              Text(" 2."),if(via2loc.isNotEmpty)Image(image:locationicon,width: 14,height: 14,),
                                                              Text(via2loc,style:TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 13)),
                                                              if(via3loc.isNotEmpty)
                                                              Text(" 3."), if(via3loc.isNotEmpty)Image(image:locationicon,width: 14,height: 14,),
                                                              Text(via3loc,style:TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 13)),
                                                            ]
                                                        )),
                                                  )))

                                            ] )),
                                ]),
                                      )
                         ])
                    ),

              Padding(
                  padding: EdgeInsets.only(top:getDevicewidth(context,0.6)),
                         child: Container(
                             child: Column(
                                    children: <Widget>[
                                  SizedBox(height: getDeviceheight(context, 0.01),),
                                  Text(timeslotfornextsevendays,style: TextStyle(color:black,fontSize: 20,fontFamily: 'ProximaNova-Bold'),),
                                  SizedBox(height:getDeviceheight(context, 0.01),),
                                  Padding(
                                      padding:EdgeInsets.only(left:getDevicewidth(context,0.01),right: getDevicewidth(context, 0.01)),
                                      child:Row(
                                        children: [
                                          Text(schedulefor),
                                          Radio<SingingCharacter>(
                                              value: SingingCharacter.next7day,
                                              groupValue: _character,
                                              activeColor: black,
                                              onChanged: (SingingCharacter value) {
                                                setState(() {
                                                  _character = value;
                                                  y=true;
                                                  x=false;
                                                  z=false;
                                                  selectdate=true;
                                                  selectdateall=false;
                                                  v_Selectall="";
                                                });
                                              }
                                          ),
                                          Text(next7day,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: y?black:greylight)),
                                          Radio<SingingCharacter>(
                                              value: SingingCharacter.all,
                                              groupValue: _character,
                                              activeColor: black,
                                              onChanged: (SingingCharacter value) {
                                                setState(() {
                                                  _character = value;
                                                  z=true;
                                                  x=false;
                                                  y=false;
                                                  selectdateall=true;
                                                  selectdate=false;
                                                  v_Selectall="setvalue";
                                                });
                                              }
                                          ),
                                          Text(all,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: z?black:greylight))
                                        ],
                                      )),
                                      SizedBox(height: getDeviceheight(context,0.01)),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        if(selectdate)GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                border = true;
                                                border1 = false;
                                                border2=false;
                                                border3=false;
                                                border4=false;
                                                border5=false;
                                                border6=false;
                                              });
                                            },
                                            child:
                                            !closecontainer?Container(
                                              height: getDeviceheight(context, 0.1),//40,//80 ,
                                              width: getDevicewidth(context, 0.30),
                                              decoration:  BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color:border?tealaccentlight:white,
                                                  width:2,),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),//3
                                                child: Column(
                                                    children: <Widget>[
                                                      if(time0.isEmpty) new Flexible(child:
                                                      Align(
                                                          alignment: Alignment.topRight,
                                                          child: IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                closecontainer=true;
                                                                s0="";
                                                              });
                                                            },
                                                            icon: Icon(
                                                              Icons.close,
                                                              color: grey,
                                                              size: 13,),
                                                          )
                                                      )),

                                                      SizedBox(height:getDeviceheight(context, 0.01),),
                                                      dates[0],
                                                      SizedBox(height: getDeviceheight(context, 0.013),),
                                                      if(time0.isNotEmpty)Container(
                                                        height: getDeviceheight(context, 0.022),  //25,
                                                        width:  getDevicewidth(context, 0.20),//70,
                                                        decoration: BoxDecoration(
                                                          color: border?teallight:greylight,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 1,vertical: 2
                                                        ),
                                                        child: Center(child: Text(time0,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:timecolor?black:lightgrey))),
                                                      ),

                                                    ]),
                                              ),
                                              // ),
                                            ):Container()
                                        ),
                                        SizedBox(width: 6,),

                                        if(selectdate) GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                border1 = true;
                                                border=false;
                                                border2=false;
                                                border3=false;
                                                border4=false;
                                                border5=false;
                                                border6=false;

                                              });
                                            },
                                            child:!closecontainer1?Container(
                                              height: getDeviceheight(context, 0.1),//40,//80 ,
                                              width: getDevicewidth(context, 0.30),
                                              decoration:  BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color:border1?tealaccentlight:white,
                                                  width:2,),
                                              ),
                                              //color: white,
                                              //child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),//3
                                                child: Column(
                                                    children: <Widget>[
                                                      if(time1.isEmpty) new Flexible(child:
                                                      Align(
                                                          alignment:Alignment.topRight,
                                                          child:  IconButton(
                                                            onPressed: (){
                                                              setState(() {
                                                                closecontainer1=true;
                                                                s1="";
                                                              });
                                                            },
                                                            icon: Icon(Icons.close,color: grey,size: 13,),
                                                          )
                                                      )),
                                                      SizedBox(height:getDeviceheight(context, 0.01),),
                                                      dates[1],
                                                      SizedBox(height: getDeviceheight(context, 0.013),),
                                                      if(time1.isNotEmpty) Container(
                                                        height:  getDeviceheight(context, 0.022),
                                                        width:  getDevicewidth(context, 0.20),
                                                        decoration: BoxDecoration(
                                                          color: border1?teallight:greylight,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                        child: Center(child: Text(time1,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color: border1?black:lightgrey))),
                                                      ),
                                                    ]),
                                              ),
                                            ):Container()
                                        ),
                                        if(selectdate) GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                border2 = true;
                                                border1=false;
                                                border=false;
                                                border3=false;
                                                border4=false;
                                                border5=false;
                                                border6=false;
                                              });
                                            },
                                            child:!closecontainer2?Container(
                                              height: getDeviceheight(context, 0.1),//40,//80 ,
                                              width: getDevicewidth(context, 0.30),
                                              decoration:  BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color:border2?tealaccentlight:white,
                                                  width:2,),
                                              ),

                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),//3
                                                child: Column(
                                                    children: <Widget>[
                                                      if(time2.isEmpty)new Flexible(child:
                                                      Align(
                                                          alignment:Alignment.topRight,
                                                          child:  IconButton(
                                                            onPressed: (){
                                                              setState(() {
                                                                closecontainer2=true;
                                                                s2="";
                                                              });
                                                            },
                                                            icon: Icon(Icons.close,color: grey,size: 13,),
                                                          )
                                                      )),
                                                      SizedBox(height:getDeviceheight(context, 0.01),),
                                                      dates[2],
                                                      SizedBox(height: getDeviceheight(context, 0.013),),
                                                      time2.isNotEmpty? Container(
                                                        height:getDeviceheight(context, 0.022), //25,
                                                        width:getDevicewidth(context, 0.20),
                                                        decoration: BoxDecoration(
                                                          color: border2?teallight:greylight,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                        child: Center(child: Text(time2,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:border2?black:lightgrey))),
                                                      ):Container()
                                                      //SizedBox(height: 5,),
                                                    ]),
                                              ),
                                            ):Container()
                                        ),
                                        if(selectdate) GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                border3 = true;
                                                border1=false;
                                                border2=false;
                                                border=false;
                                                border4=false;
                                                border5=false;
                                                border6=false;
                                              });
                                            },
                                            child:!closecontainer3?Container(
                                              height: getDeviceheight(context, 0.1),//40,//80 ,
                                              width: getDevicewidth(context, 0.30),
                                              decoration:  BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color:border3?tealaccentlight:white,
                                                  width:2,),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),//3
                                                child: Column(
                                                    children: <Widget>[
                                                      if(time3.isEmpty)new Flexible(child:
                                                      Align(
                                                          alignment:Alignment.topRight,
                                                          child:  IconButton(
                                                            onPressed: (){
                                                              setState(() {
                                                                closecontainer3=true;
                                                                s3="";
                                                              });
                                                            },
                                                            icon: Icon(Icons.close,color: grey,size: 13,),
                                                          )
                                                      )),
                                                      SizedBox(height:getDeviceheight(context, 0.01),),
                                                      dates[3],
                                                      SizedBox(height: getDeviceheight(context, 0.013),),
                                                      time3.isNotEmpty?Container(
                                                        height: getDeviceheight(context, 0.022),
                                                        width:getDevicewidth(context, 0.20),
                                                        decoration: BoxDecoration(
                                                          color: border3?teallight:greylight,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                        child: Center(child: Text(time3,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:border3?black:lightgrey))),
                                                      ):Container()
                                                    ]),
                                              ),
                                            ):Container()
                                        ),
                                        if(selectdate) GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                border4 = true;
                                                border1=false;
                                                border2=false;
                                                border=false;
                                                border3=false;
                                                border5=false;
                                                border6=false;
                                              });
                                            },
                                            child:!closecontainer4?Container(
                                              height: getDeviceheight(context, 0.1),//40,//80 ,
                                              width: getDevicewidth(context, 0.30),
                                              decoration:  BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color:border4?tealaccentlight:white,
                                                  width:2,),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),//3
                                                child: Column(
                                                    children: <Widget>[
                                                      if(time4.isEmpty)new Flexible(child:
                                                      Align(
                                                          alignment:Alignment.topRight,
                                                          child:  IconButton(
                                                            onPressed: (){
                                                              setState(() {
                                                                closecontainer4=true;
                                                                s4="";
                                                              });
                                                            },
                                                            icon: Icon(Icons.close,color: grey,size: 13,),
                                                          )
                                                      )),
                                                      SizedBox(height:getDeviceheight(context, 0.01),),
                                                      dates[4],
                                                      SizedBox(height: getDeviceheight(context, 0.013),),
                                                      time4.isNotEmpty?Container(
                                                        height: getDeviceheight(context, 0.022),
                                                        width:getDevicewidth(context, 0.20),
                                                        decoration: BoxDecoration(
                                                          color: border4?teallight:greylight,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                        child: Center(child: Text(time4,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:border4?black:lightgrey))),
                                                      ):Container()
                                                    ]),
                                              ),
                                            ):Container()
                                        ),
                                        if(selectdate) GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                border5 = true;
                                                border1=false;
                                                border2=false;
                                                border=false;
                                                border4=false;
                                                border3=false;
                                                border6=false;
                                              });
                                            },
                                            child:!closecontainer5?Container(
                                              height: getDeviceheight(context, 0.1),//40,//80 ,
                                              width: getDevicewidth(context, 0.30),
                                              decoration:  BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color:border5?tealaccentlight:white,
                                                  width:2,),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),//3
                                                child: Column(
                                                    children: <Widget>[
                                                      if(time5.isEmpty)new Flexible(child:
                                                      Align(
                                                          alignment:Alignment.topRight,
                                                          child:  IconButton(
                                                            onPressed: (){
                                                              setState(() {
                                                                closecontainer5=true;
                                                                s5="";
                                                              });
                                                            },
                                                            icon: Icon(Icons.close,color: grey,size: 13,),
                                                          )
                                                      )),
                                                      SizedBox(height:getDeviceheight(context, 0.01),),
                                                      dates[5],
                                                      SizedBox(height: getDeviceheight(context, 0.013),),
                                                      time5.isNotEmpty?Container(
                                                        height: getDeviceheight(context, 0.022),
                                                        width:getDevicewidth(context, 0.20),
                                                        decoration: BoxDecoration(
                                                          color: border5?teallight:greylight,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                        child: Center(child: Text(time5,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:border5?black:lightgrey))),
                                                      ):Container()
                                                    ]),
                                              ),
                                            ):Container()
                                        ),
                                        if(selectdate) GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                border6= true;
                                                border1=false;
                                                border2=false;
                                                border=false;
                                                border4=false;
                                                border3=false;
                                                border5=false;
                                              });
                                            },
                                            child:!closecontainer6?Container(
                                              height: getDeviceheight(context, 0.1),//40,//80 ,
                                              width: getDevicewidth(context, 0.30),
                                              decoration:  BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color:border6?tealaccentlight:white,
                                                  width:2,),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),//3
                                                child: Column(
                                                    children: <Widget>[
                                                      if(time6.isEmpty)new Flexible(child:
                                                      Align(
                                                          alignment:Alignment.topRight,
                                                          child:  IconButton(
                                                            onPressed: (){
                                                              setState(() {
                                                                closecontainer6=true;
                                                                s5="";
                                                              });
                                                            },
                                                            icon: Icon(Icons.close,color: grey,size: 13,),
                                                          )
                                                      )),
                                                      SizedBox(height:getDeviceheight(context, 0.01),),
                                                      dates[6],
                                                      SizedBox(height: getDeviceheight(context, 0.013),),
                                                      time6.isNotEmpty?Container(
                                                        height: getDeviceheight(context, 0.022),
                                                        width:getDevicewidth(context, 0.20),
                                                        decoration: BoxDecoration(
                                                          color: border6?teallight:greylight,
                                                          borderRadius: BorderRadius.circular(5),
                                                        ),
                                                        padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                        child: Center(child: Text(time6,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:border6?black:lightgrey))),
                                                      ):Container()
                                                    ]),
                                              ),
                                            ):Container()
                                        ),

                                        SizedBox(width: 6,),
                                        if(selectdateall)fetchtimeall(dates[0]),
                                        SizedBox(width:6),
                                        if(selectdateall) fetchtimeall(dates[1]),
                                        SizedBox(width:6),
                                        if(selectdateall)fetchtimeall(dates[2]),
                                        SizedBox(width:6),
                                        if(selectdateall)fetchtimeall(dates[3]),
                                        SizedBox(width:6),
                                        if(selectdateall) fetchtimeall(dates[4]),
                                        SizedBox(width:6),
                                        if(selectdateall)fetchtimeall(dates[5]),
                                        SizedBox(width:6),
                                        if(selectdateall) fetchtimeall(dates[6]),
                                      ],
                                    ),
                                  ),
                                      SizedBox(height: getDeviceheight(context,0.01)),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0,left: 17,right:20,bottom: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                            alignment:Alignment.topLeft,
                                            child: Text("Morning",textAlign: TextAlign.center,)),
                                        Align(
                                            alignment:Alignment.topCenter,
                                            child: Text("Afternoon")),
                                        Align(
                                            alignment:Alignment.topRight,
                                            child: Text("Evening")),
                                      ],
                                    ),
                                  )
                                ]),
                              )


                          ),
                                Padding(
                                  padding: EdgeInsets.only(top: getDevicewidth(context, 1.1),bottom: getDeviceheight(context, 0.1)),
                                  child: Align(
                                      alignment:Alignment.topLeft,
                                      child:  Container(
                                          width: 100,
                                          child: SingleChildScrollView(
                                              child:Column(children:[
                                                GridView.count(
                                                    shrinkWrap: true,
                                                    physics: ClampingScrollPhysics(),
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 1,
                                                    childAspectRatio: 100 / 30,
                                                    crossAxisCount: 1,
                                                    children: _a.map((MyButtonmodal f) {
                                                      return InkWell(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                    color: f.changeButtonColor ?
                                                                    black : white,
                                                                    borderRadius: BorderRadius.circular(
                                                                        5),
                                                                    border: Border.all(color: lightgrey)
                                                                ),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: 10, vertical: 2
                                                                ),
                                                                child: Center(
                                                                  child: Text(f.buttonText,
                                                                    style: TextStyle(fontSize: 12,
                                                                      fontFamily: 'ProximaNova-Medium',
                                                                      color:  f.changeButtonColor ? Colors
                                                                          .white : black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          onTap:() {
                                                            _a.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            _b.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            _c.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            print(f.buttonText);
                                                            setState(() {
                                                               time=f.buttonText;
                                                               v_slotId=f.slotId;
                                                         f.changeButtonColor = !f.changeButtonColor;
                                                               if(border){time0=f.buttonText;s0=v_slotId;}
                                                               if(border1){time1=f.buttonText;s1=v_slotId;}
                                                               if(border2){time2=f.buttonText;s2=v_slotId;}
                                                               if(border3){time3=f.buttonText;s3=v_slotId;}
                                                               if(border4){time4=f.buttonText;s4=v_slotId;}
                                                               if(border5){time5=f.buttonText;s5=v_slotId;}
                                                               if(border6){time6=f.buttonText;s6=v_slotId;}
                                                            });
                                                          }
                                                      );
                                                    }).toList()

                                                )
                                              ])))

                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: getDevicewidth(context, 1.1),bottom: getDeviceheight(context, 0.1)),
                                  child: Align(
                                      alignment:Alignment.topCenter,
                                      child:
                                      Container(
                                          width: 100,
                                          child: SingleChildScrollView(
                                              child:Column(children:[
                                                GridView.count(
                                                    shrinkWrap: true,
                                                    physics: ClampingScrollPhysics(),
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 1,
                                                    childAspectRatio: 100 / 30,
                                                    crossAxisCount: 1,
                                                    children: _b.map((MyButtonmodal f) {
                                                      return InkWell(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                    color: f.changeButtonColor ?
                                                                    black : white,
                                                                    borderRadius: BorderRadius.circular(
                                                                        5),
                                                                    border: Border.all(color: lightgrey)
                                                                ),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: 10, vertical: 2
                                                                ),
                                                                child: Center(
                                                                  child: Text(f.buttonText,
                                                                    style: TextStyle(fontSize: 12,
                                                                      fontFamily: 'ProximaNova-Medium',
                                                                      color:  f.changeButtonColor ? Colors
                                                                          .white : black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          onTap:() {
                                                            _b.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            _a.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            _c.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            print(f.buttonText);
                                                            setState(() {
                                                               time=f.buttonText;
                                                               v_slotId=f.slotId;
                                                              f.changeButtonColor = !f.changeButtonColor;
                                                               if(border){time0=f.buttonText;s0=v_slotId;}
                                                               if(border1){time1=f.buttonText;s1=v_slotId;}
                                                               if(border2){time2=f.buttonText;s2=v_slotId;}
                                                               if(border3){time3=f.buttonText;s3=v_slotId;}
                                                               if(border4){time4=f.buttonText;s4=v_slotId;}
                                                               if(border5){time5=f.buttonText;s5=v_slotId;}
                                                               if(border6){time6=f.buttonText;s6=v_slotId;}

                                                            });

                                                          }
                                                      );
                                                    }).toList()

                                                )
                                              ])))

                                  ),
                                ),
                                Padding(
                                  padding:EdgeInsets.only(top: getDevicewidth(context, 1.1),bottom: getDeviceheight(context, 0.1)),
                                  child: Align(
                                      alignment:Alignment.topRight,
                                      child:Container(//height: 100,
                                          width: 100,
                                          child: SingleChildScrollView(
                                              child:Column(children:[
                                                GridView.count(
                                                    shrinkWrap: true,
                                                    physics: ClampingScrollPhysics(),
                                                    mainAxisSpacing: 10,
                                                    crossAxisSpacing: 1,
                                                    childAspectRatio: 100 / 30,
                                                    crossAxisCount: 1,
                                                    children: _c.map((MyButtonmodal f) {
                                                      return InkWell(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                width: 100,
                                                                decoration: BoxDecoration(
                                                                    color: f.changeButtonColor ?
                                                                    black : white,
                                                                    borderRadius: BorderRadius.circular(
                                                                        5),
                                                                    border: Border.all(color: lightgrey)
                                                                ),
                                                                padding: EdgeInsets.symmetric(
                                                                    horizontal: 10, vertical: 2
                                                                ),
                                                                child: Center(
                                                                  child: Text(f.buttonText,
                                                                    style: TextStyle(fontSize: 12,
                                                                      fontFamily: 'ProximaNova-Medium',
                                                                      color:  f.changeButtonColor ? Colors
                                                                          .white : black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          onTap:() {
                                                            _c.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            _a.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });
                                                            _b.forEach((element) {
                                                              if(f.slotId!=element && element.changeButtonColor==true){
                                                                setState(() {
                                                                  element.changeButtonColor=false;
                                                                });
                                                              }
                                                            });

                                                            print(f.buttonText);
                                                            setState(() {
                                                               time=f.buttonText;
                                                               v_slotId=f.slotId;
                                                              f.changeButtonColor = !f.changeButtonColor;
                                                               if(border){time0=f.buttonText;s0=v_slotId;}
                                                               if(border1){time1=f.buttonText;s1=v_slotId;}
                                                               if(border2){time2=f.buttonText;s2=v_slotId;}
                                                               if(border3){time3=f.buttonText;s3=v_slotId;}
                                                               if(border4){time4=f.buttonText;s4=v_slotId;}
                                                               if(border5){time5=f.buttonText;s5=v_slotId;}
                                                               if(border6){time6=f.buttonText;s6=v_slotId;}

                                                            });
                                                          }
                                                      );
                                                    }).toList()

                                                )
                                              ])))),
                                ),

              Container(
                  child: Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: ButtonTheme(
                          minWidth: 350,
                          height: 45,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius
                                  .circular(20)),
                          child:
                          RaisedButton(
                            color:time.isNotEmpty?tealaccent:lightgrey,
                            onPressed: ()  {
                              saveas?Navigator.push(context, MaterialPageRoute(builder: (context) => Updateschedule())):localert();

                            },
                            child: Text('SELECT & PROCEED',style: TextStyle(color: time.isNotEmpty?black:greylight,fontSize: 14,fontFamily: 'ProximaNova-Medium')),
                          ))
                  )),

            ]));

  }


  saveaslocation () {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Save this location as",style: TextStyle(color:blue,fontSize: 16,fontFamily: 'ProximaNova-Semibold'),),
                      SizedBox(height: 7,),
                      Row(
                        children: [
                            Image(image:locationicon,width: 14,height: 14,),
                          new Flexible(child:Text(V_droploc, style: TextStyle(color: black,fontSize: 16,fontFamily: 'ProximaNova-Regular'),)),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ButtonTheme(
                              height: 40,
                              child: FlatButton(

                                  onPressed: () async {
                                    setState(() {
                                      saveascolor=true;
                                      chooseloc=false;
                                   });

                                    var data={
                                      "location" : {
                                        "lat" : V_drop_lat,
                                        "lng" : V_drop_lng,
                                        "address" :V_droploc
                                      },
                                      "saveAs" : "home"

                                    };
                                    print(data);
                                    try {
                                      var url = BASE_URL + SAVEAS_LOCATION;
                                      final prefs = await SharedPreferences.getInstance();
                                      final key = 'token';
                                      final value = prefs.get(key ) ?? 0;
                                      print(value);
                                      var response = await dio.put(url, data: data,
                                          options: Options(
                                              headers: {
                                                headerAuth: "jwt $value" ,
                                              },
                                              validateStatus: (status) {
                                                return status < 500;
                                              }
                                          )
                                      );
                                      print(response.statusCode);
                                      print(response.data);
                                      if(response.statusCode==200){
                                        print(response.data);
                                        setState(() {
                                          saveas=true;
                                          saveasoffice=false;
                                          saveashome=true;
                                        });
                                        Navigator.pop(context);
                                      }else{
                                        setState(() {
                                        });
                                        print(response.data);
                                      }
                                    }catch(e){
                                      print(e);
                                    }

                                  },
                                  shape: RoundedRectangleBorder(side: BorderSide(
                                      color:saveascolor?greenborder:greylight,
                                      width: 1,
                                      style: BorderStyle.solid
                                  ), borderRadius: BorderRadius.circular(20)),
                                  color: saveascolor?tealaccentcolor: white,
                                  child:Row(
                                      children:[
                                        if(saveascolor) Image(image: tickicon, width: 14, height: 10),
                                        Text("HOME",style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Medium'),),
                                        Image(image:homeicon,width: 14,height: 14,),
                                      ])
                              ),
                            ),
                            ButtonTheme(
                              height: 40,
                              child: FlatButton(
                                  onPressed: () async {
                                    setState(() {
                                      chooseloc=true;
                                      saveascolor=false;
                                    });
                                    var data={
                                      "location" : {
                                        "lat" :V_drop_lat,
                                        "lng" : V_drop_lng ,
                                        "address" :V_droploc
                                      },
                                      "saveAs" : "office"

                                    };
                                    print(data);
                                    try {
                                      var url = BASE_URL + SAVEAS_LOCATION;
                                      final prefs = await SharedPreferences.getInstance();
                                      final key = 'token';
                                      final value = prefs.get(key ) ?? 0;
                                      print(value);
                                      var response = await dio.put(url, data: data,
                                          options: Options(
                                              headers: {
                                                headerAuth: "jwt $value" ,
                                              },
                                              validateStatus: (status) {
                                                return status < 500;
                                              }
                                          )
                                      );
                                      print(response.statusCode);
                                      print(response.data);
                                      if(response.statusCode==200){
                                        print(response.data);
                                        setState(() {
                                          saveas=true;
                                          saveasoffice=true;
                                          saveashome=false;
                                        });
                                        Navigator.pop(context);
                                      }else{

                                        print(response.data);
                                      }
                                    }catch(e){
                                      print(e);
                                    }
                                  },
                                  shape: RoundedRectangleBorder(side: BorderSide(
                                      color:chooseloc?greenborder:greylight,
                                      width: 1,
                                      style: BorderStyle.solid
                                  ), borderRadius: BorderRadius.circular(20)),
                                  color: chooseloc?tealaccentcolor: white,
                                  child:Row(
                                      children:[
                                       if(chooseloc) Image(image: tickicon, width: 14, height: 10),
                                        Text("OFFICE",style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Medium'),),
                                        Image(image:officeicon,width: 14,height: 14,),
                                      ])
                              ),
                            ),

                          ]),
                    ])),
          ); //??

        }
    );
  }

  fetchtime(Widget dat) {
    return Container(
      height: getDeviceheight(context, 0.1),//40,//80 ,
      width: getDevicewidth(context, 0.30),
      decoration:  BoxDecoration(
        color: white,
        border: Border.all(
          color:border?tealaccentlight:white,
          width:2,),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),//3
        child: Column(
            children: <Widget>[
        if(time.isEmpty)  new Flexible(child:
               Align(
                  alignment:Alignment.topRight,
                  child:  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.close,color: grey,size: 13,),
                  )
              )),
             SizedBox(height:getDeviceheight(context, 0.01),),
            dat,
              SizedBox(height: getDeviceheight(context, 0.013),),
       if(time.isNotEmpty)
              Container(
                height: getDeviceheight(context, 0.023), //25,
                width: getDevicewidth(context, 0.23),//70,
                decoration: BoxDecoration(
                  color: teallight,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 1,vertical: 2
                ),
                child: Center(child: Text(time,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color: black))),
              ),


            ]),
      ),
      // ),
    );
  }
  fetchtimeall(Widget dat) {

                return Container(
                    height: getDeviceheight(context, 0.1),//40,//80 ,
                    width: getDevicewidth(context, 0.30),
                    decoration:  BoxDecoration(
                      color: white,
                      border: Border.all(
                        color:tealaccentlight,
                        width:2,),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),//3
                      child: Column(
                          children: <Widget>[
                            SizedBox(height:getDeviceheight(context, 0.01),),
                            if(time.isEmpty) SizedBox(height:getDeviceheight(context, 0.015),),
                             dat,
                            SizedBox(height: getDeviceheight(context, 0.013),),
                            if(time.isNotEmpty)  Container(
                              height: getDeviceheight(context, 0.023), // 25,
                              width: getDevicewidth(context, 0.23),//70,
                              decoration: BoxDecoration(
                                color: teallight,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 1,vertical: 2
                              ),
                              child: Center(child: Text(time,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color: black))),
                            ),
                            //SizedBox(height: 5,),

                          ]),
                    ),
                  );

  }

  localert() {

      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              backgroundColor: whitelight,
              title: Center(child: Text("please save location",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
            );
          });
    }
  Future<void> setCustomMapPin() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/loc_marker.png');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/loc_destmarker.png');
  }

  void setMapPins()async {
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: SOURCE_LOCATION,
        icon: sourceIcon
    ));

    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: DEST_LOCATION,
        icon: destinationIcon
    ));
  }
  void setpolyline() {
    latlngSegment1.add(SOURCE_LOCATION);
    latlngSegment1.add(DEST_LOCATION);
    setState(() {
      _polyline.add(Polyline(
        polylineId: PolylineId('line1'),
        visible: true,
        points: latlngSegment1,
        width: 2,
        color: black,
      ));
    });
  }
}








class Timeslotmodal{
  final String dateText;
  final String timeSlot;
  bool borderColor;
  bool removecon;



  Timeslotmodal({this.dateText,this.timeSlot,this.borderColor=false,this.removecon=false});
}
List<Timeslotmodal>_T=[
  Timeslotmodal(dateText:dateall[0]),
  Timeslotmodal(dateText:dateall[1]),
  Timeslotmodal(dateText:dateall[2]),
  Timeslotmodal(dateText:dateall[3]),
  Timeslotmodal(dateText:dateall[4]),
  Timeslotmodal(dateText:dateall[5]),
  Timeslotmodal(dateText:dateall[6]),
];



class MyButtonmodal{
  final String buttonText;
  bool changeButtonColor;
  final String slotId;


  MyButtonmodal({this.buttonText,this.slotId,this.changeButtonColor=false});
}

List<MyButtonmodal>_a=[
  MyButtonmodal(buttonText:"8-8.30am",slotId: '1'),
  MyButtonmodal(buttonText:"8.30-9am",slotId: '2'),
  MyButtonmodal(buttonText:"9-9.30am",slotId: '3'),
  MyButtonmodal(buttonText:"9.30-10am",slotId: '4'),
  MyButtonmodal(buttonText:"10-10.30am",slotId: '5'),
  MyButtonmodal(buttonText:"10.30-11am",slotId: '6'),
  MyButtonmodal(buttonText:"11-11.30am",slotId: '7'),
  MyButtonmodal(buttonText:"11.30-12pm",slotId: '8'),
];

List<MyButtonmodal>_b=[
  MyButtonmodal(buttonText:"12-12.30pm",slotId: '9'),
  MyButtonmodal(buttonText:"12.30-1pm",slotId: '10'),
  MyButtonmodal(buttonText:"1-1.30pm",slotId: '11'),
  MyButtonmodal(buttonText:"1.30-2pm",slotId: '12'),
  MyButtonmodal(buttonText:"2-2.30pm",slotId: '13'),
  MyButtonmodal(buttonText:"2.30-3pm",slotId: '14'),
  MyButtonmodal(buttonText:"3-3.30pm",slotId: '15'),
  MyButtonmodal(buttonText:"3.30-4pm",slotId: '16'),
];

List<MyButtonmodal>_c=[
  MyButtonmodal(buttonText:"4-4.30pm",slotId: '17'),
  MyButtonmodal(buttonText:"4.30-5pm",slotId: '18'),
  MyButtonmodal(buttonText:"5-5.30pm",slotId: '19'),
  MyButtonmodal(buttonText:"5.30-6pm",slotId: '20'),
  MyButtonmodal(buttonText:"6-6.30pm",slotId: '21'),
  MyButtonmodal(buttonText:"6.30-7pm",slotId: '22'),
  MyButtonmodal(buttonText:"7-7.30pm",slotId: '23'),
  MyButtonmodal(buttonText:"7.30-8pm",slotId: '24'),
];




