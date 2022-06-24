


import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Updateschedule extends StatefulWidget {
  @override
  _UpdatescheduleState createState() => _UpdatescheduleState();
}



class _UpdatescheduleState extends State<Updateschedule> {
  final _currentDate = DateTime.now();
  final _dateFormatter = DateFormat('d');
  final _dayFormatter = DateFormat('E');
  final _monthFormatter = DateFormat('MMM');
  final dateint =  DateFormat('yyyy-MM-dd');
  List<LatLng> latlngSegment1 = List();
  Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  GoogleMapController mapController;
  LatLng SOURCE_LOCATION = V_pic_lng!=null?LatLng(V_pic_lat,V_pic_lng):LatLng(12.848598,80.225684);
  LatLng DEST_LOCATION = V_drop_lat!=null?LatLng(V_drop_lat,V_drop_lng):LatLng(12.848598,80.235684);
  bool loader=false;
  bool alertmsg=false;
  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }
 
  @override
  Widget build(BuildContext context) {
    final dates = <Widget>[];
    final datetime=[];
    for (int i = 0; i < 7; i++) {
      DateTime intdate = _currentDate.add(Duration(days:i));
        datetime.add(dateint.format(intdate));
      final date = _currentDate.add(Duration(days: i));      
      dates.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_dayFormatter.format(date)+', '+_monthFormatter.format(date)+' '+_dateFormatter.format(date),
            style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Semiboldstyle',color: black),),
        ],
      ));
    }
    return Scaffold(
    body: Stack(
    children:[
     Column(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
     Container(
         height:getDeviceheight(context, 0.20),
         width: double.infinity,
       child:Stack(
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
                   zoom: 10,
                   target:LatLng(V_pic_lat,V_pic_lng))),


           Padding(
                    padding:  EdgeInsets.only(top: getDeviceheight(context, 0.03)),
                    child: Align(alignment: Alignment.topLeft,
                         child:RawMaterialButton(
                           onPressed: ()  {
                             Navigator.pop(context);
                           },
                           fillColor:white,
                         child:  Icon(
                             Icons.arrow_back,
                             size: 25.0,
                             color: black,
                           ),// padding: EdgeInsets.all(10.0),
                           shape: CircleBorder(
                               side: BorderSide(color: grey)
                           ),
                         )),
                  )
      ])

    ),
    Container(
        color: white,
      child:Padding(
        padding: const EdgeInsets.all(12),
        child: Center(child: Text("Your Schedule",style: TextStyle(fontFamily: 'ProximaNova-Bold',fontSize: 20,color: black),)),
      )
    ),
    Expanded(
    flex: 1,
    child: v_Selectall.isNotEmpty?Container(  //v_Selectall.isNotEmpty?
      color: white,
    width: double.infinity,
     child:  new ListView.builder
          (
            itemCount: 7,
            itemBuilder: (BuildContext ctxt, int index) {
              return new Card(
                   child: Column (
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(left: getDevicewidth(context, 0.3,),top: getDeviceheight(context, 0.01)),
                          child:TextButton(
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(image:clockicon, width: 14,height: 14,),
                              Text(time +" | ",style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Semiboldstyle'),),
                              dates[index]
                            ],
                          ),
                            onPressed: (){
                              showModalBottomSheet(
                                  context: context,
                                  shape: topBorder,
                                  isScrollControlled: true,
                                  builder: ((builder)=>
                                    ridesheet(time,dates[index])),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: getDevicewidth(context, 0.10)),
                      child:  Row(
                          children: [
                            Image(image:addressmarker, width: 44,height: 44,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                   Row(
                                      children:[
                                        Image(image:locationicon,
                                          width: 14,height: 14,),
                                        Text(V_pickup,style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                      ]),

                                SizedBox(height: getDeviceheight(context,0.02),),

                               Row(
                                  children:[
                                    Image(image:locationicon,
                                      width: 14,height: 14,),
                                    Text(V_droploc,style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                                  ]),

                              ],
                            ),
                          ],
                        )),
                        SizedBox(height: getDeviceheight(context,0.045),),
                      ]),


              );
            }
        ),
     ):Container(
      child: SingleChildScrollView(
     child: Column (
          children: [
         if(time0.isNotEmpty)update7days(time0,dates[0]),
            if(time1.isNotEmpty)update7days(time1,dates[1]),
          if(time2.isNotEmpty)update7days(time2, dates[2]),
            if(time3.isNotEmpty)update7days(time3, dates[3]),
            if(time4.isNotEmpty)update7days(time4, dates[4]),
            if(time5.isNotEmpty)update7days(time5, dates[5]),
            if(time6.isNotEmpty)update7days(time6, dates[6]),


          ])),
    )
    )
        ]),
      Container(
          child: Positioned(
              bottom: 20,
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
                    color: tealaccent,
                    onPressed: ()  async {
                      print(datetime);
                      print(datetime[2]);
                      var data=
                      {
                        "startLocation" : {
                          "lat" :V_pic_lat,
                          "lng" : V_pic_lng,
                          "address" : V_pickup
                        },
                        "endLocation" : {
                          "lat" : V_drop_lat,
                          "lng" : V_drop_lng ,
                          "address" : V_droploc
                        },
                        "viaPoints" :
                        [
                       if(via1loc.isNotEmpty)   {
                            "lat" :via1_lat,
                            "lng" :via1_lng ,
                           "address" : via1loc,
                          },
                        if(via2loc.isNotEmpty)  {
                            "lat" : via2_lat,
                            "lng" : via2_lng,
                          "address" : via2loc,
                          },
                        if(via3loc.isNotEmpty)  {
                            "lat" : via3_lat,
                            "lng" : via3_lng,
                          "address" : via3loc,
                          },
                        ],
                        if(v_Selectall.isNotEmpty)  "slotDetails" : [
                          {
                            "date":datetime[0],
                            "slot": v_slotId
                          },
                          {
                            "date":datetime[1],
                            "slot": v_slotId
                          },
                          {
                            "date":datetime[2],
                            "slot": v_slotId
                          },
                          {
                            "date":datetime[3],
                            "slot": v_slotId
                          },
                          {
                            "date":datetime[4],
                            "slot": v_slotId
                          },
                          {
                            "date":datetime[5],
                            "slot": v_slotId
                          },
                          {
                            "date":datetime[6],
                            "slot": v_slotId
                          }
                          ],
                    if(v_Selectall.isEmpty)  "slotDetails": [
                      if(time0.isNotEmpty)    {
                      "date" : datetime[0],
                      "slot" : s0
                      },

                      if(time1.isNotEmpty)  {
                      "date": datetime[1],
                      "slot": s1
                      },
                      if(time2.isNotEmpty)  {
                      "date": datetime[2],
                      "slot": s2
                      },
                      if(time3.isNotEmpty)   {
                      "date": datetime[3],
                      "slot": s3
                      },
                      if(time4.isNotEmpty)   {
                      "date":datetime[4],
                      "slot": s4
                      },
                      if(time5.isNotEmpty)   {
                      "date":datetime[5],
                      "slot": s5
                      },
                      if(time6.isNotEmpty)   {
                      "date":datetime[6],
                      "slot": s6
                      }
                      ]
                      };

                      print(data);
                      setState(() {
                        loader=true;
                      });
                          try {
                            var url = BASE_URL + VEH_OWNER_SHEDULERIDE;
                            final prefs = await SharedPreferences.getInstance();
                            final key = 'token';
                            final value = prefs.get(key ) ?? 0;
                            print(value);
                            var response = await dio.post(url, data: data,
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

                              setState(() {
                                loader=false;
                              });
                              Navigator.pop(context);
                              Navigator.popAndPushNamed(context, '/home');
                            }else{
                              setState(() {
                                loader=false;
                                alertmsg=true;
                              });

                              print(response.data);
                            }
                          }catch(e){
                            print(e);
                            loader=false;
                          }
                    },
                    child: Text('UPDATE SCHEDULE NOW',style: TextStyle(
                      fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black
                    )),
                  ))
          )),
      loader?Container(
          width:MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black26,
          child:Align(
              alignment: Alignment.center,
              child:Container(
                child: CircularProgressIndicator(),
              )
          )
      ):Container(),
      if(alertmsg)  Container(
          child: Positioned(
              top: 20,
              left: 0,
              right: 0,
              child:Container(
                  color: red,
                  padding: EdgeInsets.all(6),
                  child: Row(
                      children: <Widget>[
                        SizedBox(width: getDevicewidth(context, 0.02),),
                        Text("Ride already exist",
                          style:TextStyle(color: white,fontFamily:'ProximaNova-Medium',fontSize: 16),),
                        new Flexible(
                            child: Align(alignment: Alignment.topRight,

                                child: IconButton(
                                    icon: Icon(Icons.close_rounded,color: white,),
                                    onPressed: (){
                                      setState(() {
                                        alertmsg=!alertmsg;
                                      });
                                    }))),
                      ])))),
    ]));
  }

  update7days(String time,Widget dat) {
    return Container(
      color: white,
      child: Card(
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.only(left: getDevicewidth(context, 0.3,),top: getDeviceheight(context, 0.01)),
      child:TextButton(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(image:clockicon,
                    width: 14,height: 14,),
                  Text(time +" | ",style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Semiboldstyle'),),
                  //dates[index]
                 dat
                ],
              ),
        onPressed: (){
          showModalBottomSheet(
            context: context,
            shape: topBorder,
            isScrollControlled: true,
            builder: ((builder)=>
                ridesheet(time,dat)),
          );
        },
      ),
            ),
            SizedBox(height: getDeviceheight(context,0.02),),
        Padding(
        padding: EdgeInsets.only(left: getDevicewidth(context, 0.10)),
          child:  Row(
              children: [
                Image(image:addressmarker, width: 44,height: 44,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                       Row(
                          children:[
                            Image(image:locationicon,
                              width: 14,height: 14,),
                            Text(V_pickup,style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                          ]),
                    SizedBox(height: getDeviceheight(context,0.02),),
              Row(
                  children:[
                    Image(image:locationicon,
                      width: 14,height: 14,),
                    Text(V_droploc,style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                  ]),

                  ],
                ),
              ],
            )),
            SizedBox(height: getDeviceheight(context,0.045),),
          ],
        ),
      ),
    );
  }

   ridesheet(String time, Widget dat) {
     return  Container(
          height: getDeviceheight(context, 0.4),
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
                                  Text(V_pickup,
                                    style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') ,)
                                ]),


                            SizedBox(height: getDeviceheight(context, 0.02),),
                            Row(
                                children:[
                                  Image(image:locationicon, width: 14,height: 14,),
                                  Text(V_droploc,
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
                          Text(time+' | ',
                            style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Semiboldstyle'),),
                       dat
                        ],
                      ),
                    ),
                    SizedBox(height: getDeviceheight(context, 0.025),),
                    Text("Via Points",style: TextStyle(color: grey,fontFamily: 'ProximaNova-Medium',fontSize: 16),),
                    Container(
                      child:Padding(
                              padding: EdgeInsets.only(left: getDevicewidth(context,0.10),top:getDeviceheight(context, 0.01)),
                              child: Container(
                                  child: Column(
                                    children: [
                                      if(via1loc.isNotEmpty)Row(
                                        children: [
                                          Text("1."),
                                          Image(image:locationicon, width: 14,height: 14,),
                                          Text(via1loc,style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: black),),
                                        ],
                                      ),
                                      SizedBox(height: getDeviceheight(context, 0.01),),
                                      if(via2loc.isNotEmpty)Row(
                                        children: [
                                          Text("2."),
                                          Image(image:locationicon, width: 14,height: 14,),
                                          Text(via2loc,style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: black),),
                                        ],
                                      ),
                                      SizedBox(height: getDeviceheight(context, 0.01),),
                                      if(via3loc.isNotEmpty)Row(
                                        children: [
                                          Text("3."),
                                          Image(image:locationicon, width: 14,height: 14,),
                                          Text(via3loc,style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: black),),
                                        ],
                                      ),
                                    ],
                                  )
                              ),
                            )

                    )


       ])));



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
    // source pin
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
