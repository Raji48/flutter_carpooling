

import 'dart:async';
import 'package:carpooling/Actions/findride_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/findride/findride_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/com_ride/pickuplocationcommuter.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';



class Commuterscheduleride extends StatefulWidget {
  @override
  _CommuterschedulerideState createState() => _CommuterschedulerideState();
}


enum SingingCharacter { today,next7day,all}
class _CommuterschedulerideState extends State<Commuterscheduleride> {
  String groupValue='';
  bool x=true;
  bool y=false;
  bool z=false;
  bool border=false;
  bool border1=false;
  bool border2=false;
  bool border3=false;
  bool border4=false;
  bool border5=false;
  bool border6=false;
  bool selectdate=false;
  bool loader=false;
  bool alertbox=false;
  bool selectdateall= false;
  final _currentDate = DateTime.now();
  final _dateFormatter = DateFormat('d');
  final _dayFormatter = DateFormat('E');
  final _monthFormatter = DateFormat('MMM');
  final _dateintformat = new DateFormat('yyyy-MM-dd');



  String time="";
  String slotid="";
  String c="";
  String b="";
  String time0="";
  String time1="";
  String time2="";
  String time3="";
  String time4="";
  String time5="";
  String time6="";
  String s0,s1,s2,s3,s4,s5,s6="";
  bool closecontainer=false;
  bool closecontainer1=false;
  bool closecontainer2=false;
  bool closecontainer3=false;
  bool closecontainer4=false;
  bool closecontainer5=false;
  bool closecontainer6=false;


  @override
  void inistate(){
    super.initState();
  }


  SingingCharacter _character = SingingCharacter.today;
  @override
  Widget build(BuildContext context) {
    final dates = <Widget>[];
    List dateint =[];
    DateTime datetoday=DateTime.now();
    final todaydate= new DateFormat('yyyy-MM-dd').format(datetoday);
    print(todaydate);
    for (int i = 0; i < 7; i++) {
      DateTime intdate = _currentDate.add(Duration(days:i)); //DateTime.now();
      dateint.add(_dateintformat.format(intdate));
      final date = _currentDate.add(Duration(days: i));
      dateall.add(DateFormat.MMMEd().format(intdate));
      dates.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_dayFormatter.format(date)+', '+_monthFormatter.format(date)+' '+_dateFormatter.format(date),
            style: TextStyle(fontSize: 12,fontFamily: 'ProximaNova-Medium',color: black),),
        ],
      ));
    }

    return StoreConnector<AppState, FindrideProps>(
        converter: (store) => mapStateToProps(store),
        builder: (context, props) {
          if (props.loading) {
            loader=true;
          }
          else
          if(props.rideresults!=null) {
            loader=false;
            alertbox=false;
            print("successs to find ride");
            Timer( Duration(milliseconds: 500), (){
              Navigator.popAndPushNamed(context, '/searchresults');
            });
          }else if (props.error != null) {
            loader = false;
            alertbox=true;
            print(props.error);
            print("errorto find ride");
            props.clearprops("true");
          }
          return WillPopScope(
              onWillPop:(){
                Navigator.pop(context);
                Navigator.popAndPushNamed(context, '/droplocation');
              },
              child:
              Scaffold(
                  appBar: AppBar(
                    leading: BackButton(color: blacklight,
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(context, '/droplocation');
                      },
                    ),
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
                                    mapType: MapType.normal,
                                    myLocationEnabled: true,
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(20.5937,-78.9629))),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5,right: 5,top:0),
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
                                                        icon:Image(image:locationicon,
                                                          width: 14,height: 14,)),
                                                    Text(C_pickup,style: TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 16,color:grey ),),
                                                    new Flexible(child:
                                                    Align(
                                                        alignment:Alignment.topRight,
                                                        child: IconButton(
                                                          onPressed: (){
                                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>Picklocation()));
                                                          },
                                                          icon: Icon(Icons.close,color: greylight,),
                                                        )
                                                    ))
                                                  ]
                                              )
                                          ),
                                          SizedBox(height: getDeviceheight(context, 0.001),),
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
                                                    Text(C_droploc,style: TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 16,color:grey )),
                                                    new Flexible(child:
                                                    Align(
                                                        alignment:Alignment.topRight,
                                                        child: IconButton(
                                                          onPressed: (){
                                                            Navigator.pushNamed(context, '/droplocation');
                                                          },
                                                          icon: Icon(Icons.close,color: greylight,),
                                                        )
                                                    ))
                                                  ]
                                              )
                                          ),

                                        ]))
                              ]
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top:getDevicewidth(context,0.6)),
                          child: Container(
                              child: Column(children: <Widget>[
                                SizedBox(height: getDeviceheight(context,0.01)),
                                Text(selecttimeslot,style: TextStyle(color:black,fontSize: 20,fontFamily: 'ProximaNova-Bold'),),

                                SizedBox(height: getDeviceheight(context,0.01)),
                                Padding(
                                    padding:EdgeInsets.only(left:getDevicewidth(context,0.01),right: getDevicewidth(context, 0.01)),
                                    child:Row(
                                      children: [
                                        Text(schedulefor,style:TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 12,color: grey),),
                                        new Flexible(child: Align(
                                            alignment:Alignment.topLeft,
                                            child:Radio<SingingCharacter>(
                                              value: SingingCharacter.today,
                                              groupValue: _character,
                                              activeColor: black,
                                              onChanged: (SingingCharacter value) {
                                                setState(() {
                                                  _character = value;
                                                  x=true;
                                                  y=false;
                                                  z=false;
                                                  selectdate=false;
                                                  selectdateall=false;
                                                });
                                              },
                                            )

                                        ),
                                        ),
                                        Text(today,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: x?black:greylight)),
                                        new Flexible(child: Align(
                                            alignment:Alignment.topCenter,
                                            child:
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
                                                });
                                              },
                                            )

                                        )),
                                        Text(next7day,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: y?black:greylight)),
                                        new Flexible(child: Align(
                                            alignment:Alignment.topRight,
                                            child:
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
                                                    selectdate=false;
                                                    selectdateall=true;
                                                    //    this.groupValue=value;
                                                  });
                                                }
                                            ))),
                                        Text(all,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: z?black:greylight))
                                      ],
                                    )),

                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            //color: white,
                                            //child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
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
                                                      height: getDeviceheight(context, 0.02),
                                                      width: 70,
                                                      decoration: BoxDecoration(
                                                        color: border?teallight:greylight,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 1,vertical: 2
                                                      ),
                                                      child: Center(child: Text(time0,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:border?black:lightgrey))),
                                                    ),//border?time0=time:time0,

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
                                                      height:getDeviceheight(context, 0.02),
                                                      width:70,
                                                      decoration: BoxDecoration(
                                                        color: border1?teallight:greylight,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                      //child:slot1(),
                                                      child: Center(child: Text(time1,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color:border1?black:lightgrey))),
                                                    ),
                                                    //SizedBox(height: 5,),
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
                                                      height:getDeviceheight(context, 0.02),
                                                      width:70,
                                                      decoration: BoxDecoration(
                                                        color: border2?teallight:greylight,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                      child: Center(child: Text(time2,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color: border2?black:lightgrey))),
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
                                                      height:getDeviceheight(context, 0.02),
                                                      width:70,
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
                                                      height:getDeviceheight(context, 0.02),
                                                      width:70,
                                                      decoration: BoxDecoration(
                                                        color: border4?teallight:greylight,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      padding: EdgeInsets.symmetric(horizontal: 1,vertical: 2),
                                                      child: Center(child: Text(time4,style: TextStyle(fontSize:10,fontFamily: 'ProximaNova-Regular',color: border4?black:lightgrey))),
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
                                                      height:getDeviceheight(context, 0.02),//25,
                                                      width:70,
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
                                                              s6="";
                                                            });
                                                          },
                                                          icon: Icon(Icons.close,color: grey,size: 13,),
                                                        )
                                                    )),
                                                    SizedBox(height:getDeviceheight(context, 0.01),),
                                                    dates[6],
                                                    SizedBox(height: getDeviceheight(context, 0.013),),
                                                    time6.isNotEmpty?Container(
                                                      height:getDeviceheight(context, 0.02), //25,
                                                      width:70,
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
                                SizedBox(height: getDeviceheight(context,0.02)),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15,right:20,bottom: 0.1),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                          alignment:Alignment.topLeft,
                                          child: Text("Morning",style: TextStyle(fontFamily: 'proximaNova-Regular',color: grey,fontSize:12),textAlign: TextAlign.center,)),
                                      Align(
                                          alignment:Alignment.topCenter,
                                          child: Text("Afternoon",style: TextStyle(fontFamily: 'proximaNova-Regular',color: grey,fontSize:12))),
                                      Align(
                                          alignment:Alignment.topRight,
                                          child: Text("Evening",style: TextStyle(fontFamily: 'proximaNova-Regular',color: grey,fontSize:12))),
                                    ],
                                  ),
                                )
                              ])
                          ),
                        ),

                        Padding(
                            padding:EdgeInsets.only(top: x?getDevicewidth(context, 0.93):getDevicewidth(context, 1.1),bottom: getDeviceheight(context, 0.1)),
                            child: Align(
                                alignment:Alignment.topLeft,
                                child:  Container(//height: 100,
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
                                                            color: f.changeButtonColor ?black : white,
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
                                                              color: f.changeButtonColor ? Colors
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
                                                    print(f.slotId);
                                                    setState(() {
                                                      //  _enabled = false;
                                                      time=f.buttonText;
                                                      f.changeButtonColor = !f.changeButtonColor;
                                                      slotid=f.slotId;
                                                      if(border){time0=f.buttonText;s0=slotid;}
                                                      if(border1){time1=f.buttonText;s1=slotid;}
                                                      if(border2){time2=f.buttonText;s2=slotid;}
                                                      if(border3){time3=f.buttonText;s3=slotid;}
                                                      if(border4){time4=f.buttonText;s4=slotid;}
                                                      if(border5){time5=f.buttonText;s5=slotid;}
                                                      if(border6){time6=f.buttonText;s6=slotid;}
                                                    });


                                                  }
                                              );
                                            }).toList()

                                        )
                                      ])),

                                ))),
                        Padding(
                          padding: EdgeInsets.only(top: x?getDevicewidth(context, 0.93): getDevicewidth(context, 1.1),bottom: getDeviceheight(context, 0.1)),
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
                                                              color: f.changeButtonColor ? Colors
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
                                                    print(f.slotId);
                                                    setState(() {
                                                      time=f.buttonText;
                                                      f.changeButtonColor = !f.changeButtonColor;
                                                      slotid=f.slotId;
                                                      if(border){time0=f.buttonText;s0=slotid;}
                                                      if(border1){time1=f.buttonText;s1=slotid;}
                                                      if(border2){time2=f.buttonText;s2=slotid;}
                                                      if(border3){time3=f.buttonText;s3=slotid;}
                                                      if(border4){time4=f.buttonText;s4=slotid;}
                                                      if(border5){time5=f.buttonText;s5=slotid;}
                                                      if(border6){time6=f.buttonText;s6=slotid;}
                                                    });
                                                  }
                                              );
                                            }).toList()

                                        )
                                      ])))

                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.only(top: x?getDevicewidth(context, 0.93): getDevicewidth(context, 1.1),bottom: getDeviceheight(context, 0.1)),
                          child: Align(
                              alignment:Alignment.topRight,
                              child:Container(
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
                                                              color: f.changeButtonColor ? Colors
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
                                                    print(f.slotId);
                                                    setState(() {
                                                      time=f.buttonText;
                                                      f.changeButtonColor = !f.changeButtonColor;
                                                      slotid=f.slotId;
                                                      if(border){time0=f.buttonText;s0=slotid;}
                                                      if(border1){time1=f.buttonText;s1=slotid;}
                                                      if(border2){time2=f.buttonText;s2=slotid;}
                                                      if(border3){time3=f.buttonText;s3=slotid;}
                                                      if(border4){time4=f.buttonText;s4=slotid;}
                                                      if(border5){time5=f.buttonText;s5=slotid;}
                                                      if(border6){time6=f.buttonText;s6=slotid;}

                                                    });
                                                  }
                                              );
                                            }).toList()

                                        )
                                      ])))),
                        ),
                        x?Container(
                            child: Positioned(
                                bottom: 20,
                                left: 10,
                                right: 10,
                                child: ButtonTheme(
                                    minWidth: 350,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: RaisedButton(
                                      color: time.isNotEmpty?tealaccent:lightgrey,
                                      onPressed: () async {
                                        print(time);
                                        print(slotid);
                                        findridedata = {
                                          "startLocation": {
                                            "lat": C_pic_lat, //13.0067,
                                            "lng": C_pic_lng ,//80.2206
                                            "address" : C_pickup
                                          },
                                          "endLocation": {
                                            "lat": C_drop_lat, //12.9830,
                                            "lng": C_drop_lng ,//80.2594
                                            "address" : C_droploc
                                          },
                                          "slotDetails": [ //slotdetailsarray,
                                            {
                                              "date": todaydate,
                                              "slot":slotid
                                            }
                                          ]
                                        };

                                        props.findrideapi(findridedata);

                                      },
                                      child: Text('FIND RIDES',style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black)),
                                    )))):

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
                                      onPressed: () async {
                                        if(y==true) {
                                          findridedata= {
                                            "startLocation": {
                                              "lat": C_pic_lat,//13.0067,
                                              "lng": C_pic_lng, //80.2206
                                              "address" : C_pickup
                                            },
                                            "endLocation": {
                                              "lat": C_drop_lat,//12.9830,
                                              "lng": C_drop_lng ,//80.2594
                                              "address" : C_droploc
                                            },
                                            "slotDetails": [
                                              if(time0.isNotEmpty)    {
                                                "date" : dateint[0],//"2021-05-18",
                                                "slot" : s0
                                              },

                                              if(time1.isNotEmpty)  {
                                                "date": dateint[1], //"2021-05-23",
                                                "slot": s1
                                              },
                                              if(time2.isNotEmpty)  {
                                                "date": dateint[2],//"2021-05-15",
                                                "slot": s2
                                              },
                                              if(time3.isNotEmpty)   {
                                                "date": dateint[3],//"2021-05-16",
                                                "slot": s3
                                              },
                                              if(time4.isNotEmpty)   {
                                                "date": dateint[4],//"2021-05-16",
                                                "slot": s4
                                              },
                                              if(time5.isNotEmpty)   {
                                                "date": dateint[5],//"2021-05-16",
                                                "slot": s5
                                              },
                                              if(time6.isNotEmpty)   {
                                                "date": dateint[6],//"2021-05-16",
                                                "slot": s6
                                              }

                                            ]

                                          };
                                          props.findrideapi(findridedata);
                                        }

                                        if(z==true) {
                                          findridedata = {
                                            "startLocation": {
                                              "lat": C_pic_lat, //13.0067,
                                              "lng": C_pic_lng, //80.2206
                                              "address" : C_pickup
                                            },
                                            "endLocation": {
                                              "lat": C_drop_lat, //12.9830,
                                              "lng": C_drop_lng, //80.2594
                                              "address" : C_droploc
                                            },
                                            "slotDetails": [ //slotdetailsarray,
                                              {
                                                "date": dateint[0],
                                                "slot":slotid
                                              },
                                              {
                                                "date": dateint[1],
                                                "slot":slotid
                                              },
                                              {
                                                "date": dateint[2],
                                                "slot":slotid
                                              },
                                              {
                                                "date": dateint[3],
                                                "slot":slotid
                                              },
                                              {
                                                "date": dateint[4],
                                                "slot":slotid
                                              },
                                              {
                                                "date": dateint[5],
                                                "slot":slotid
                                              },
                                              {
                                                "date": dateint[6],
                                                "slot":slotid
                                              }
                                            ]
                                          };
                                          props.findrideapi(findridedata);
                                        }
                                      },
                                      child: Text('SELECT A TIME SLOT & FIND RIDES',style: TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black)),
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
                        alertbox?Container(
                            child: Positioned(
                                top: 1,
                                left: 0,
                                right: 0,
                                child:Container(
                                    color: red,
                                    padding: EdgeInsets.all(6),
                                    child: Row(
                                        children: <Widget>[
                                          SizedBox(width: getDevicewidth(context, 0.02),),
                                          Text("No rides found",
                                            style:TextStyle(color: white,fontFamily:'ProximaNova-Medium',fontSize: 16),),
                                          new Flexible(
                                              child: Align(alignment: Alignment.topRight,
                                                  child: IconButton(
                                                      icon: Icon(Icons.close_rounded,color: white,),
                                                      onPressed: (){
                                                        print("alertboxfalse");
                                                        setState(() {
                                                          alertbox= !alertbox;
                                                        });
                                                      }))),
                                        ])))):Container(),
                      ])));
        });

  }
  erroralert() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 300), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: whitelight,
            title: Center(child: Text("Updated Successfully",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
          );
        });
  }

  void dateandtime() {
    DateTime now = new DateTime.now();
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
      //color: white,
      //child: Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),//3
        child: Column(
            children: <Widget>[
              SizedBox(height:getDeviceheight(context, 0.01),),
              if(time.isEmpty) SizedBox(height:getDeviceheight(context, 0.015),),
              dat,
              SizedBox(height: getDeviceheight(context, 0.013),),
              if(time.isNotEmpty)  Container(
                height: getDeviceheight(context, 0.02),//25,
                width: 70,
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
    );
  }


}

class Timeslotmodal{
  final String dateText;
  final String timeSlot;
  bool borderColor;
  bool removecon;
  bool select;



  Timeslotmodal({this.dateText,this.timeSlot,this.borderColor=false,this.removecon=false,this.select=false});
}
List<Timeslotmodal>_T=[
  Timeslotmodal(dateText:dateall[0],select: true),
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

  MyButtonmodal({this.buttonText,this.slotId, this.changeButtonColor=false});
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
  MyButtonmodal(buttonText:"7.30-8pm",slotId: '14'),
];

class FindrideProps {
  final bool loading;
  final dynamic error;
  final FindrideModal rideresults;
  final Function findrideapi;
  final Function clearprops;

  FindrideProps({
    this.loading,
    this.error,
    this.rideresults,
    this.findrideapi,
    this.clearprops,
  });
}
FindrideProps mapStateToProps(Store<AppState> store) {
  return FindrideProps(
      loading: store.state.rideresults.loading,
      error: store.state.rideresults.error,
      rideresults: store.state.rideresults.rideresult,
      findrideapi:(data)=>store.dispatch(findridecommuter(data)),
      clearprops: (data)=>store.dispatch(clearpropsfindride(data))
  );
}



