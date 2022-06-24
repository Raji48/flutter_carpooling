
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/veh_dashboard/vehowner_dashboard/shcedule_ride.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Viapoint extends StatefulWidget {
   @override
    _ViapointState createState() => _ViapointState();
  }

 class _ViapointState extends State<Viapoint> {
   GoogleMapController mapController;
   String querychange="";
   List<String>_searchListItems =[];
   List<double>_searchListlat =[];
   List<double>_searchListlng =[];
  bool viapoint2=false;
  bool viapoint3=false;
  bool buttonvia=true;
   BitmapDescriptor pinLocationIcon;
   List<LatLng> latlngSegment1 = List();
   Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
   BitmapDescriptor sourceIcon;
   BitmapDescriptor destinationIcon;
   BitmapDescriptor viaIcon;
   BitmapDescriptor viaoffIcon;

   LatLng SOURCE_LOCATION = LatLng(V_pic_lat,V_pic_lng);
   LatLng DEST_LOCATION =  LatLng(V_drop_lat,V_drop_lng);
   LatLng VIA1_LOCATION  ;
   LatLng VIA2_LOCATION ;
   LatLng VIA3_LOCATION ;

   String selectedTerm;
  String selectedTerm1;
  String selectedTerm3;



   FloatingSearchBarController controller;

   @override
   void initState(){
     super.initState();
     controller=FloatingSearchBarController();
    setCustomMapPin();
     setState(() {
       via1loc="";
        via2loc="";
        via3loc="";
     });
   }
   bool loader= false;
   @override
   void dispose(){
     controller.dispose();
     super.dispose();
   }

   @override
   Widget build(BuildContext context) {

     return StoreConnector<AppState, PlaceslistProps>(
         converter: (store) => mapStateToProps(store),
         builder: (context, props) {
           return Scaffold(
       appBar: AppBar(
         leading: BackButton(color: blacklight),
         backgroundColor: Colors.white,
         title: Text("Via Points", style: TextStyle(fontSize: 18,fontFamily: 'ProximaNova-Medium',color: black)),
       ),

       body: SafeArea(
           child:Stack(
               children: [
                 Container(
                     child: GoogleMap(
                       onMapCreated: (
                           GoogleMapController googleMapController) {
                        setMapPins();
                         setState(() {
                           mapController = googleMapController;
                         });
                       },
                       myLocationEnabled: true,
                       markers:  _markers,
                       initialCameraPosition: CameraPosition(
                           zoom: 12.0,bearing:30,
                           target: LatLng(V_pic_lat,V_pic_lng)//13.0827, 80.2707) //11.1271,78.6569 )           //21.1458,79.0882)
                       ),
                       mapType: MapType.normal,
                     ),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top:1),
                   child: Container(
                       child: FloatingSearchBar(
                         controller: controller,
                         scrollPadding: EdgeInsets.zero,
                         backdropColor: Colors.transparent,
                         transition: CircularFloatingSearchBarTransition(),
                         physics: BouncingScrollPhysics(),
                         title: Text(
                             selectedTerm1 ?? 'Via Point 1',
                             style:TextStyle(color: grey,fontFamily: 'ProximaNova-Regular',fontSize: 16)
                         ),
                         automaticallyImplyBackButton:false,
                         leadingActions:[
                           FloatingSearchBarAction(
                               showIfOpened: false,
                               child: Container(
                                   width: 8.0, height: 8.0,
                                   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle, color:viapoint2?grey:blue
                                   ))
                           ),
                           if(selectedTerm1==null) FloatingSearchBarAction(
                             showIfOpened: false,
                             child: CircularButton(
                               icon: const Icon(Icons.search ,color:Colors.grey),
                               onPressed: () {},
                             ),
                           ),
                           if(selectedTerm1!=null)FloatingSearchBarAction(
                             showIfOpened: false,
                             child: CircularButton(
                               icon:viapoint2?Image(image:locgreyicon, width: 14,height: 14,):Image(image:locationicon, width: 14,height: 14,),
                               onPressed: () {},
                             ),
                           ),
                         ],
                         hint: 'Via Point 1',
                         actions: [
                         FloatingSearchBarAction(
                         showIfOpened: false,
                         child: CircularButton(
                           icon: const Icon(Icons.add_box_outlined,size: 22,),
                           onPressed: () {
                             if(selectedTerm1!=null) {
                               setState(() {
                                 print("viapoint2");
                                 viapoint2 = true;
                               });
                             }
                             if(viapoint2==true && selectedTerm!=null){
                               print("viapoint 3");
                               setState(() {
                                 viapoint3=true;
                               });
                             }
                           },
                         ),
                       ),


                           FloatingSearchBarAction.searchToClear(
                             showIfClosed: false,
                             color: grey,
                           ),
                         ],

                         onQueryChanged: (query){
                           setState(() {
                             querychange=query;
                           });
                           _searchListItems = [];
                           _searchListlat=[];
                           _searchListlng=[];
                           for (int i = 0; i < props.placeslist.places.length; i++) {
                             var item =props.placeslist.places[i].name;
                             var lati=props.placeslist.places[i].location.lat;
                             var lngi=props.placeslist.places[i].location.lng;
                             if (item.toLowerCase().contains(querychange.toLowerCase())) {
                               _searchListItems.add(item);
                               _searchListlat.add(lati);
                               _searchListlng.add(lngi);
                             }
                           }

                         },
                         onSubmitted: (query){
                           setState(() {
                             selectedTerm1=query;
                           });
                           controller.close();
                         },
                         builder: (context,transition){
                     if(querychange.isNotEmpty){
                       if(_searchListItems.isEmpty){
                         return Padding(
                           padding:EdgeInsets.only(top: 49,left: getDevicewidth(context,0.25)),
                           child: Text ("Search not found",style: TextStyle(fontFamily: 'ProximaNova-Bold',color: black),),
                         );
                       }else{
                           return Container(
                             height: getDeviceheight(context, 0.5),
                             color: white,
                             child:new ListView.builder(
                                 itemCount:_searchListItems.length,
                                 itemBuilder: (BuildContext ctxt, int index){
                                   return Column(
                                     children: [
                                       ListTile(
                                         title: Row(
                                           children: [
                                             Image(image: locationicon, width: 20,height: 14, ),
                                             Text(_searchListItems[index], maxLines: 1, overflow: TextOverflow.ellipsis,
                                                 style: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16)),
                                           ],
                                         ),
                                         onTap: () {
                                           setState(() {
                                             selectedTerm1 =_searchListItems[index];
                                             via1_lat =_searchListlat[index];
                                             via1_lng =_searchListlng[index];
                                             via1loc=selectedTerm1;
                                             VIA1_LOCATION = LatLng(via1_lat,via1_lng);
                                           });
                                           controller.close();
                                           setMapPinsvia1();
                                         },
                                       ),
                                       Divider(color:grey,height: 10,thickness: 0.1,),
                                     ],
                                   );
                                 }),
                           );
                           }}else{
                       return null;
                     }
                         },
                       )),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top:50),
                   child: viapoint2?Container(
                       child: FloatingSearchBar(
                         controller: controller,
                         scrollPadding: EdgeInsets.zero,
                         backdropColor: Colors.transparent,
                         transition: CircularFloatingSearchBarTransition(),
                         physics: BouncingScrollPhysics(),
                         title: Text(
                             selectedTerm ?? 'Via Point 2',
                             style:TextStyle(color: grey,fontFamily: 'ProximaNova-Regular',fontSize: 16)
                         ),
                         automaticallyImplyBackButton:false,
                         leadingActions:[
                           FloatingSearchBarAction(
                               showIfOpened: false,
                               child: Container(
                                   width: 8.0, height: 8.0,
                                   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle, color:viapoint3?grey:blue
                                   ))
                           ),
                           if(selectedTerm==null) FloatingSearchBarAction(
                             showIfOpened: false,
                             child: CircularButton(
                               icon: const Icon(Icons.search ,color:Colors.grey),
                               onPressed: () {},
                             ),
                           ),
                           if(selectedTerm!=null)FloatingSearchBarAction(
                             showIfOpened: false,
                             child: CircularButton(
                               icon:viapoint3?Image(image:locgreyicon, width: 14,height: 14,):Image(image:locationicon, width: 14,height: 14,),
                               onPressed: () {},
                             ),
                           ),
                         ],
                         hint: 'Via Point 2',
                         actions: [
                           FloatingSearchBarAction(
                                      showIfOpened: false,
                                      child: TextButton(
                                           child:Text("Remove"),
                                        onPressed: () {
                                            if(!viapoint3) setState(() {
                                               viapoint2=false;
                                               selectedTerm=null;
                                               via2loc="";
                                             });
                                        },
                                      ),
                                    ),
                           FloatingSearchBarAction.searchToClear(
                             showIfClosed: false,
                             color: grey,
                           ),

                         ],
                         onQueryChanged: (query){
                           setState(() {
                             querychange=query;
                             print(query);
                           });
                           _searchListItems = [];
                           _searchListlat=[];
                           _searchListlng=[];
                           for (int i = 0; i < props.placeslist.places.length; i++) {
                             var item =props.placeslist.places[i].name;
                             var lati=props.placeslist.places[i].location.lat;
                             var lngi=props.placeslist.places[i].location.lng;
                             if (item.toLowerCase().contains(querychange.toLowerCase())) {
                               _searchListItems.add(item);
                               _searchListlat.add(lati);
                               _searchListlng.add(lngi);
                             }
                           }

                         },
                         onSubmitted: (query){
                           setState(() {
                             selectedTerm=query;
                           });
                           controller.close();
                         },
                         builder: (context,transition){
                           if(querychange.isNotEmpty){
                             if(_searchListItems.isEmpty){
                               return Padding(
                                 padding:EdgeInsets.only(top: 100,left: getDevicewidth(context,0.25)),
                                 child: Text ("Search not found",style: TextStyle(fontFamily: 'ProximaNova-Bold',color: black),),
                               );
                             }else{
                           return Container(
                             height: getDeviceheight(context,0.5),
                             color: white,
                             child:new ListView.builder(
                                 itemCount:_searchListItems.length,
                                 itemBuilder: (BuildContext ctxt, int index){
                                   return ListTile(
                                     title: Row(
                                       children: [
                                         Image(image: locationicon, width: 20,height: 14, ),
                                         Text(_searchListItems[index], maxLines: 1, overflow: TextOverflow.ellipsis,
                                             style: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16)),
                                       ],
                                     ),

                                     onTap: () {
                                       setState(() {
                                         selectedTerm = _searchListItems[index];
                                         via2_lat = _searchListlat[index];
                                         via2_lng =_searchListlng[index];
                                         via2loc=selectedTerm;
                                         VIA2_LOCATION = LatLng(via2_lat,via2_lng);
                                        print(VIA2_LOCATION);
                                       });
                                       controller.close();
                                       setMapPinsvia2();

                                     },
                                   );
                                 }),
                           );
                           }}else{return null;}

                         },
                       )):Container(),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top:100),
                   child: viapoint3?Container(
                       child: FloatingSearchBar(
                         controller: controller,
                         scrollPadding: EdgeInsets.zero,
                         backdropColor: Colors.transparent,
                         transition: CircularFloatingSearchBarTransition(),
                         physics: BouncingScrollPhysics(),
                         title: Text(
                             selectedTerm3 ?? 'Via Point 3',
                             style:TextStyle(color: grey,fontFamily: 'ProximaNova-Regular',fontSize: 16)
                         ),
                         automaticallyImplyBackButton:false,
                         leadingActions:[
                           FloatingSearchBarAction(
                               showIfOpened: false,
                               child: Container(
                                   width: 8.0, height: 8.0,
                                   margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle, color:blue
                                   ))
                           ),
                           if(selectedTerm3==null) FloatingSearchBarAction(
                             showIfOpened: false,
                             child: CircularButton(
                               icon: const Icon(Icons.search ,color:Colors.grey),
                               onPressed: () {},
                             ),
                           ),
                           if(selectedTerm3!=null)FloatingSearchBarAction(
                             showIfOpened: false,
                             child: CircularButton(
                               icon:Image(image:locationicon,
                                 width: 14,height: 14,),
                               onPressed: () {},
                             ),
                           ),
                         ],
                         hint: 'Via Point 3',
                         actions: [
                           FloatingSearchBarAction(
                             showIfOpened: false,
                             child: TextButton(
                               child:Text("Remove"),
                               onPressed: () {
                                 setState(() {
                                   viapoint3=false;
                                   selectedTerm3=null;
                                   via3loc="";
                                 });
                               },
                             ),
                           ),


                           FloatingSearchBarAction.searchToClear(
                             showIfClosed: false,
                             color: grey,
                           ),
                         ],

                         onQueryChanged: (query){
                           setState(() {
                             querychange=query;
                           });
                           _searchListItems = [];
                           _searchListlat=[];
                           _searchListlng=[];
                           for (int i = 0; i < props.placeslist.places.length; i++) {
                             var item =props.placeslist.places[i].name;
                             var lati=props.placeslist.places[i].location.lat;
                             var lngi=props.placeslist.places[i].location.lng;
                             if (item.toLowerCase().contains(querychange.toLowerCase())) {
                               _searchListItems.add(item);
                               _searchListlat.add(lati);
                               _searchListlng.add(lngi);
                             }
                           }
                           },
                         onSubmitted: (query){
                           setState(() {
                             selectedTerm3=query;
                           });
                           controller.close();
                         },
                         builder: (context,transition){
                           if(querychange.isNotEmpty){
                             if(_searchListItems.isEmpty){
                               return Padding(
                                 padding:EdgeInsets.only(top: 149,left: getDevicewidth(context,0.25)),
                                 child: Text ("Search not found",style: TextStyle(fontFamily: 'ProximaNova-Bold',color: black),),
                               );
                             }else{
                           return Container(
                             height: getDeviceheight(context,0.5),
                             color: white,
                             child:new ListView.builder(
                                 itemCount:_searchListItems.length,
                                 itemBuilder: (BuildContext ctxt, int index){
                                   return ListTile(
                                     title: Row(
                                       children: [
                                         Image(image: locationicon, width: 20,height: 14, ),
                                         Text(_searchListItems[index], maxLines: 1, overflow: TextOverflow.ellipsis,
                                             style: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16)),
                                       ],
                                     ),
                                     onTap: () {
                                       setState(() {
                                         selectedTerm3 = _searchListItems[index];
                                         via3_lat =_searchListlat[index];
                                         via3_lng =_searchListlng[index];
                                         via3loc=selectedTerm3;
                                         VIA3_LOCATION = LatLng(via3_lat,via3_lng);
                                         print("via3latlng");
                                      print(VIA3_LOCATION);
                                       });
                                       controller.close();
                                       setMapPinsvia3();
                                     },
                                   );
                                 }),
                           );
                           }}else{return null;}
                         },
                       )):Container()
                 ),
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
         if(selectedTerm1!=null||selectedTerm!=null||selectedTerm3!=null)
        Align(
           alignment: Alignment.bottomCenter,
             child:
             Column(
               mainAxisAlignment:MainAxisAlignment.end,
               mainAxisSize: MainAxisSize.max,
               children: [
                controller.isClosed ? ButtonTheme(
                       minWidth: getDevicewidth(context, 0.8),
                       height: getDeviceheight(context, 0.05),
                       shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius
                               .circular(20)),
                       child:
                       RaisedButton(
                         color: tealaccent,
                         onPressed: ()  {
                           Navigator.pushNamed(context, '/timeslot');
                         },
                         child: Text("CONFIRM VIA POINTS",style:TextStyle(color: black,fontFamily: 'ProximaNova-Medium',fontSize: 16)),
                       )):Container(),
               ],
           ),
         ),
               ])),
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

    viaIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/locmarker_blue.png');
    viaoffIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/locmarker_grey.png');
  }
   void setMapPinsvia1() async{
       _markers.add(Marker(
           markerId: MarkerId('viapin1'),
           position: VIA1_LOCATION,
           icon: await getBitmapDescriptorFromAssetBytes("assets/images/locmarker_blue.png",200,200)  //viaIcon
       ));

   }
   void setMapPinsvia2()async {
       _markers.add(Marker(
           markerId: MarkerId('viapin2'),
           position: VIA2_LOCATION,
           icon:await getBitmapDescriptorFromAssetBytes("assets/images/locmarker_blue.png",200,200) //viaIcon  //destinationIcon
       ));

   }
   void setMapPinsvia3() async{
       _markers.add(Marker(
           markerId: MarkerId('viapin3'),
           position: VIA3_LOCATION,
           icon: await getBitmapDescriptorFromAssetBytes("assets/images/locmarker_blue.png",200,200) //destinationIcon
       ));

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
     if(via1_lat!=null)latlngSegment1.add(VIA1_LOCATION);
     if(via2_lat!=null)latlngSegment1.add(VIA2_LOCATION);
     if(via3_lat!=null)latlngSegment1.add(VIA3_LOCATION);
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



