
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapapp extends StatefulWidget {
  final double loclat,loclng;
  final String locadd,loctime,locdate,locuserfname,locuserlname;
  const Mapapp({Key key,@required this.loclat, this.loclng,this.locadd,this.locdate,this.loctime,this.locuserfname,this.locuserlname}): super(key:key);
  @override
  _MapappState createState() => _MapappState();
}

class _MapappState extends State<Mapapp> {
  bool loader = false;

  Set<Marker> _markers = {};
  BitmapDescriptor sourceIcon;


  @override
  void initState() {
    super.initState();
    setCustomMapPin();
  }


  GoogleMapController mapController;
  String searchAddr;
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
                children: [
            SingleChildScrollView(
            child:   Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                      height: MediaQuery.of(context).size.height/1.4,
                      child: Stack(
                        children: [

                          GoogleMap(
                            onMapCreated: (
                                GoogleMapController googleMapController) {
                              setMapPins();
                              setState(() {
                                mapController = googleMapController;
                              });
                            },
                            myLocationEnabled: true,
                            markers: _markers,
                            compassEnabled: true,
                            tiltGesturesEnabled: false,
                            initialCameraPosition: CameraPosition(
                                zoom: 13.0, //bearing: 30,
                                target: LatLng(widget.loclat, widget.loclng )//13.0827, 80.2707) //11.1271,78.6569 )           //21.1458,79.0882)
                            ),
                            mapType: MapType.normal,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: getDeviceheight(context, 0.03)),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  fillColor: white,
                                  child: Icon(
                                    Icons.arrow_back,
                                    size: 25.0,
                                    color: black,
                                  ),
                                  shape: CircleBorder(
                                      side: BorderSide(
                                          color: grey)
                                  ),
                                )),
                          ),
                        ],
                      )),
                  SizedBox(height:getDeviceheight(context, 0.03)),
                   Padding(
                     padding: EdgeInsets.only(left: getDevicewidth(context, 0.05)),
                     child: Text( widget.locuserfname +' '+widget.locuserlname+ " Location & Schedule",style: TextStyle(fontSize: 20,color: black,fontFamily: 'ProximaNova-Semiboldstyle'),),
                   ),
                  SizedBox(height: getDeviceheight(context, 0.03),),
           Padding(
            padding:EdgeInsets.only(left: getDevicewidth(context, 0.10)),
                 child: Row(
                      children:[
                        Image(image:locationicon, width: 14,height: 14,),
                        Text(widget.locadd,
                            style:TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular') )
                      ])),

        SizedBox(height: getDeviceheight(context, 0.02),),
        Padding(
          padding:EdgeInsets.only(left: getDevicewidth(context, 0.10)),
          child: Row(
            children: [
              Image(image:clockicon, width: 14,height: 14,),
              Text(widget.loctime +" | "+widget.locdate
                ,style: TextStyle(color: black,fontSize: 14,fontFamily: 'ProximaNova-Regular'),),
            ],
          ),
        ),
                  ])))

                ])));
  }

  Future<void> setCustomMapPin() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/locviewmarker.png');
  }


  void setMapPins() {
    setState(() {
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('sorcepin'),
          position: LatLng(widget.loclat, widget.loclng),
          icon: sourceIcon
      ));
    });
  }
}
