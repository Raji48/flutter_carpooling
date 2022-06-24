
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Services/Apiconstant.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MaterialApp(home: Pickuplocation()));
}

class Pickuplocation extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return MyHomePageState();
  }

}

class MyHomePageState extends State{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: MyMap(),
    );
  }

}
class MyMap extends StatefulWidget{

  @override
  State createState() {
    // TODO: implement createState
    return MyMapState();
  }

}

class MyMapState extends State{
  LatLng latlong=null;
  CameraPosition _cameraPosition;
  GoogleMapController _controller ;
  Set<Marker> _markers={};
  BitmapDescriptor sourceIcon;
  TextEditingController locationController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMapPin();
    _cameraPosition=CameraPosition(target: LatLng(0, 0),zoom: 10.0);
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: blacklight,
          ),
          backgroundColor: Colors.white,
          title: Text("Pickup Location", style: TextStyle(fontSize: 18,fontFamily: 'ProximaNova-Medium',color: black)),
        ),
        body:SafeArea(
            child: Stack(
                children: [
                  (latlong!=null) ?GoogleMap(
                      initialCameraPosition: _cameraPosition,
                      onMapCreated: (GoogleMapController controller){
                        _controller=(controller);
                        _controller.animateCamera(
                            CameraUpdate.newCameraPosition(_cameraPosition));

                      },

                      markers:_markers
                  ):Container(),
                  Positioned(
                    top: 1.0,
                    right: 15.0,
                    left: 15.0,
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 5.0),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),
                      child: TextField(
                          cursorColor: Colors.black,
                          controller: locationController,style:TextStyle(color: black, fontFamily: 'ProximaNova-Regular', fontSize: 16),
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top:0),
                              width: 20,
                              height: 20,
                              child:Image(image:locationicon,
                                width: 24,height: 24,),
                            ),
                            hintText: "pick up Location",hintStyle: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 0, top: 12.0),
                            suffixIcon:  IconButton(
                              icon: Icon(Icons.clear,color: grey,),
                              onPressed: ()  {
                                locationController.clear();
                              },
                            ),
                          )),
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom:2),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ButtonTheme(
                                  minWidth: getDevicewidth(context, 0.8),
                                  height: getDeviceheight(context, 0.05),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius
                                          .circular(20)),
                                  child:
                                  RaisedButton(
                                    color: tealaccent,
                                    onPressed: ()  {
                                      C_pickup= locationController.text;
                                      print(C_pickup);
                                      Navigator.pop(context);
                                      Navigator.popAndPushNamed(context, '/homecommuter');
                                    },
                                    child: Text("CONFIRM POINT",style:TextStyle(color: black,fontFamily: 'ProximaNova-Medium',fontSize: 16)),
                                  )),

                            ],
                          )))]

            )));
  }
  void setCustomMapPin() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/loc_marker.png');
  }
  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != PermissionStatus.granted)
        getLocation();
      return;
    }
    getLocation();
  }
  List<Address> results = [];
  getLocation() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    C_pic_lat=position.latitude;
    C_pic_lng=position.longitude.abs();
    print("location latitude");
    print(position.latitude);
    print("location longitude");
    print(position.longitude);
    print(C_pic_lng);


    setState(() {
      latlong=new LatLng(position.latitude, position.longitude);
      _cameraPosition=CameraPosition(target:latlong,zoom: 10.0 );
      if(_controller!=null)
        _controller.animateCamera(
            CameraUpdate.newCameraPosition(_cameraPosition));
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: latlong, //SOURCE_LOCATION,
          icon: sourceIcon
      ));
    });

    getCurrentAddress();
  }

  getCurrentAddress() async
  {
    final coordinates = new Coordinates(latlong.latitude, latlong.longitude);
    results  = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = results.first;
    if(first!=null) {
      var address;
      address = first.featureName;
      //address =   " $address, ${first.subLocality}" ;
      // address =  " $address, ${first.subLocality}" ;
      address =  "$address, ${first.locality}";
      //  address =  " $address, ${first.countryName}" ;
      // address = " $address, ${first.postalCode}" ;
      locationController.text = address;
    }
  }
}
