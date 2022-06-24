




import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:carpooling/Actions/locationplaces_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/locationplaces/places_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Services/Apiconstant.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redux/redux.dart';


class Shceduleride extends StatefulWidget {
  @override
  _ShcedulerideState createState() => _ShcedulerideState();
}

class _ShcedulerideState extends State<Shceduleride> {
  String querychange="";
  List<String>_searchListItems = [];
  List<double>_searchListlat =[];
  List<double>_searchListlng = [];
  String x='true';
  bool via=true;
  bool y=true;
  bool end=true;
  List<LatLng> latlngSegment1 = List();
  GoogleMapController mapController;
  bool loader=false;
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};
  Set<Polyline> _polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  LatLng pinPosition;
  double CAMERA_ZOOM = 13;
  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;
  LatLng SOURCE_LOCATION ;
 LatLng DEST_LOCATION ;


  String selectedTerm;
  String selectedTerm1;

  FloatingSearchBarController controller;

  void handleInitialBuild(PlaceslistProps props) {
    props.placelistapi();
  }

  @override
  void initState(){
    super.initState();
    controller=FloatingSearchBarController();
    setCustomMapPin();

  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PlaceslistProps>(
    onInitialBuild: (props) => this.handleInitialBuild(props),
    converter: (store) => mapStateToProps(store),
    builder: (context, props) {
      Widget body;
    if (props.loading) {
    print("loding");
    loader = true;
    body = Center(
      child: CircularProgressIndicator(),
    );
    } else if (props.placeslist != null) {
    loader = false;
    print("success");
    print(props.placeslist.places[1].name);
    body= SafeArea(
          child:Stack(
              children: [
                Container(
                   child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          zoom: 15.0, bearing:30,
                          target:LatLng(13.0827, 80.2707)
                      ),
                      markers:  _markers,
                      onMapCreated: (
                          GoogleMapController googleMapController) {
                       setState(() {
                          mapController = googleMapController;
                        });
                      },
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
                            selectedTerm1 ?? 'Ride Starting Location',
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
                            shape: BoxShape.circle, color: green
                           ))
                          ),
                          if(selectedTerm1==null) FloatingSearchBarAction(
                            showIfOpened: false,
                            child: CircularButton(
                              icon: const Icon(Icons.search ,color:Colors.grey),
                              onPressed: () {
                              },
                            ),
                          ),
                          if(selectedTerm1!=null)FloatingSearchBarAction(
                            showIfOpened: false,
                            child: CircularButton(
                              icon:Image(image:locationicon,
                                width: 14,height: 14,),
                              //icon: const Icon(Icons.place ,color:Colors.grey),
                              onPressed: () {},
                            ),
                          ),
                        ],
                        hint: 'Ride Starting Location',
                        actions: [
                          FloatingSearchBarAction.searchToClear(
                            showIfClosed: false,
                            color: grey,
                          ),
                        ],
                        onFocusChanged:y?(x){
                          print("focussssonchange");
                          setState(() {
                            y=!y;
                            via=!via;
                            end=!end;
                          });
                        }:null,

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
                              height: getDeviceheight(context,0.5),
                              color: white,
                              child:new ListView.builder(
                                  itemCount:_searchListItems.length,
                                  itemBuilder: (BuildContext ctxt, int index){
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Row(
                                            children: [
                                              Image(image: locationicon,
                                                width: 20,height: 14, ),
                                              Text(_searchListItems[index], maxLines: 1, overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16)),
                                            ],
                                          ),

                                          onTap: () {
                                            setState(() {
                                              selectedTerm1 = _searchListItems[index];
                                              y=!y;
                                              via=!via;
                                             end=!end;
                                              V_pickup=selectedTerm1;
                                              V_pic_lat=_searchListlat[index];
                                              V_pic_lng=_searchListlng[index];
                                              SOURCE_LOCATION = LatLng(V_pic_lat,V_pic_lng);
                                            });
                                            controller.close();
                                            setMapPinspic();

                                          },
                                        ),
                                       Divider(color:grey,height: 10,thickness: 0.1,),
                                      ],
                                    );
                                  }),


                          );
                            }}

                         else{return null;}
                        },

                      )

                  ),
                ),


                end?Padding(
                  padding: const EdgeInsets.only(top:50),
                child: Container(
                      child: FloatingSearchBar(
                        controller: controller,
                        backdropColor: Colors.transparent,
                        scrollPadding: EdgeInsets.zero,
                        transition: CircularFloatingSearchBarTransition(),
                        physics: BouncingScrollPhysics(),
                        title: Text(
                            selectedTerm ?? 'Ride Ending Location',
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
                                      shape: BoxShape.circle, color:red
                                  ))
                          ),
                          if(selectedTerm==null) FloatingSearchBarAction(
                            showIfOpened: false,
                            child: CircularButton(
                              icon: const Icon(Icons.search ,color:Colors.grey),
                              onPressed: () {

                              },
                            ),
                          ),
                          if(selectedTerm!=null)FloatingSearchBarAction(
                            showIfOpened: false,
                            child: CircularButton(
                              icon:Image(image:locationicon,
                                width: 14,height: 14,),
                              onPressed: () {},
                            ),
                          ),
                        ],
                        hint: 'Ride Ending Location',
                        actions: [

                          FloatingSearchBarAction.searchToClear(
                            showIfClosed: false,
                            color: grey,
                          ),
                        ],
                          onFocusChanged:y?(x){
                          print("focussssonchange");
                          setState(() {
                            y=!y;
                            via=!via;//false;
                                });
                                }:null,


                       onQueryChanged: (query){
                         setState(() {
                           querychange=query;

                         });
                         _searchListItems = [];
                         _searchListlat = [];
                         _searchListlng = [];
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
                                              y=!y;  //false;
                                              via=!via;  //true;
                                              selectedTerm = _searchListItems[index];
                                              V_drop_lat=_searchListlat[index];
                                              V_drop_lng=_searchListlng[index];
                                              V_droploc=selectedTerm;
                                              print(V_drop_lng);
                                              print(selectedTerm);
                                              DEST_LOCATION = LatLng(V_drop_lat,V_drop_lng);

                                            });
                                            controller.close();
                                            setMapPinsdrop();
                                            },
                                        ),
                                        Divider(color:grey,height: 10,thickness: 0.1,),
                                      ],
                                    );
                                  }),

                          );
                          }}else{return null;}
                        },
                      ))):Container(),


      via? Padding(
            padding: EdgeInsets.only(top:105,left: 10,right: 10),
            child:
             Container(
                    color: white,
                    child:Row(
                        children:[
                          Padding(
                            padding:  EdgeInsets.only(left: 4),
                            child: Text("Via points:",style:TextStyle(fontFamily: 'ProximaNova-Bold',color: grey,fontSize: 13),),
                          ),
                          SizedBox(width: 20,),
                          Padding(
                            padding:  EdgeInsets.all(5),
                            child:
                            ButtonTheme(
                                minWidth: getDevicewidth(context, 0.6),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius
                                        .circular(10)),
                                child:
                                RaisedButton(
                                  color:selectedTerm!=null && selectedTerm1!=null?black:lightgrey,
                                  onPressed: ()  {
                                    if(selectedTerm!=null && selectedTerm1!=null) {
                                      Navigator.pushNamed(
                                          context, '/viapoints');
                                    }
                                  },
                                  child: Text("Set via points",style: TextStyle(fontFamily: 'ProximaNova-Bold',color: greylight,fontSize: 13),),
                                ),
                                ),
                         ),


                        ]
                    )
             )):Container(),

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

              ]));
    }
    else if (props.error != null) {
      loader = false;
      print(props.error);
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: blacklight),
        backgroundColor: Colors.white,
        title: Text("Schedule Ride", style: TextStyle(fontSize: 18,fontFamily: 'ProximaNova-Medium',color: black)),
      ),
      body: body,
    );
    });
  }

  void setCustomMapPin() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 50.5),
        'assets/images/loc_marker.png');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        createLocalImageConfiguration(context,size: Size(100.0, 100.0)),
        'assets/images/loc_destmarker.png');
  }
  void setMapPinspic() async{
      _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position:SOURCE_LOCATION,
          icon: await getBitmapDescriptorFromAssetBytes("assets/images/loc_marker.png",200,200 )//sourceIcon
      ));
  }
  void setMapPinsdrop()  async{
   // setState((){
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('destPin'),
          position: DEST_LOCATION,
          icon: await getBitmapDescriptorFromAssetBytes("assets/images/loc_destmarker.png",200,200) //destinationIcon
         //destinationIcon
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

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width, int height) async {
    final Uint8List imageData = await getBytesFromAsset(path, width,height);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width,int height) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width,targetHeight: height);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
}







class PlaceslistProps {
  final bool loading;
  final dynamic error;
  final Placesmodal placeslist ;
  final Function placelistapi;

  PlaceslistProps({
    this.loading,
    this.error,
    this.placeslist,
    this.placelistapi
  });
}
PlaceslistProps mapStateToProps(Store<AppState> store) {
  return PlaceslistProps(
    loading: store.state.placelist.loading,
    error: store.state.placelist.error,
    placeslist:store.state.placelist.placelists,
    placelistapi:()=>store.dispatch(placeslist()),
  );
}