import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/com_ride/pickuplocationcommuter.dart';
import 'package:carpooling/Services/Apiconstant.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
class Commuterride extends StatefulWidget {
  @override
  _CommuterrideState createState() => _CommuterrideState();
}

class _CommuterrideState extends State<Commuterride> {
  GoogleMapController mapController;
  LatLng latlong=null;
  TextEditingController locationController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){
           Navigator.pushNamed(context, '/Role');
        },
    child:Scaffold(
        resizeToAvoidBottomInset: true,
        body:
        Stack(
            children:[
                     SingleChildScrollView(
                        child:   Container(
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height/1.9,
                                width: double.infinity,
                              child:GoogleMap(
                                onMapCreated: (GoogleMapController googleMapController){
                                  setState(() {
                                    mapController=googleMapController;
                                  });
                                },
                                initialCameraPosition: CameraPosition(
                                    zoom: 15.0,
                                    target: LatLng(13.0827,80.2707)     //11.1271,78.6569 )           //21.1458,79.0882)
                                ),
                                mapType: MapType.normal,
                              ),
                            ),

                        SizedBox(height:getDeviceheight(context, 0.02)),
                        Center(child: Text("Find a Ride",style: TextStyle(fontSize: 20,fontFamily: 'ProximaNova-Bold',color: black),)),
                        SizedBox(height: getDeviceheight(context, 0.02),),
                       // new Flexible(child:
                  Padding(
                      padding: EdgeInsets.only(left: 15,right: 8,),
                       child: Container(
                         child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                       Row(
                          children: [
                            Text("Your Current Location",style:TextStyle(color:grey2,fontFamily: 'ProximaNova-Regular',fontSize: 14)),
                           new Flexible(child:
                            Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () async {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>Picklocation()));

                                },
                                  child:Text("change",style:TextStyle(color: blue,fontFamily: 'ProximaNova-Medium',fontSize: 12))),
                            ))
                          ],

                        ),

                       Row(
                          children:[
                            Image(image:locationicon,
                            width: 14,height: 14,),
                        new Flexible(child:
                        Text(C_pickup,style:TextStyle(color: black,fontFamily: 'ProximaNova-Regular',fontSize: 16)),
                        )]
                              ),
                               SizedBox(height:getDeviceheight(context, 0.03)),
                        Text("Drop Location",style:TextStyle(color:grey2,fontFamily: 'ProximaNova-Regular',fontSize: 14)),
                               SizedBox(height:getDeviceheight(context, 0.03)),
                       ButtonTheme(
                            minWidth: double.infinity,
                            height: getDeviceheight(context, 0.08),
                            child:RaisedButton(
                                color:teallight,
                                onPressed: (){
                                Navigator.pushNamed(context, '/droplocation');
                                },
                                child:Row(
                                  children:[
                                    Icon(Icons.search),
                                Text("Search Drop Location",style:TextStyle(color: black,fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 16))
                                ]
                                )
                            )),

                      ])
                  )),
                      ])))
    ])));

  }

}
