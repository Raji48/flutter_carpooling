

import 'package:carpooling/Actions/locationplaces_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/locationplaces/places_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redux/redux.dart';


class Picklocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PicklocationState();
}



class PicklocationState extends State<Picklocation> {
  GoogleMapController mapController;
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  BitmapDescriptor sourceIcon;
  bool loader=false;
  bool curloc=true;
  bool y=true;
  String x="true";
  LatLng PICKUP_LOCATION = C_pic_lng==null?LatLng(12.848598,80.225684):LatLng(C_pic_lat,C_pic_lng);
  String selectedTerm;
  String querychange="";
  List<String>_searchListItems = [];
  List<double>_searchListlat = [];
  List<double>_searchListlng = [];


  FloatingSearchBarController controller;

  @override
  void initState(){
    super.initState();
    setCustomMapPin();
    controller=FloatingSearchBarController();
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  void handleInitialBuild(PlaceslistProps props) {
    props.placelistapi();
  }
  // @override


  Widget build(BuildContext context) {
    LatLng pinPosition = C_pic_lng==null?LatLng(12.848598,80.225684):LatLng(C_pic_lat,C_pic_lng);
    return StoreConnector<AppState, PlaceslistProps>(
        onInitialBuild: (props) => this.handleInitialBuild(props),
        converter: (store) => mapStateToProps(store),
        builder: (context, props) {
          Widget body;
          if (props.loading) {
            print("loding");
            body = Center(
              child: CircularProgressIndicator(),
            );
          } else if (props.placeslist != null) {
            loader = false;
            print("success");
            print(props.placeslist.places[1].name);
            body=SafeArea(
                child: Stack(
                    children: [
                      Container(
                          child: GoogleMap(
                            onMapCreated: (
                                GoogleMapController googleMapController) {
                              setState(() {
                                mapController = googleMapController;
                              });
                            },
                            initialCameraPosition: CameraPosition(
                              zoom: 10.0,   bearing: 30,  target: pinPosition, //          //21.1458,79.0882)
                            ),
                            myLocationEnabled: true,
                            markers: _markers,
                            mapType: MapType.normal,
                          )),
                      Container(
                          child: FloatingSearchBar(
                            automaticallyImplyBackButton: false,
                            clearQueryOnClose: true,
                            transitionDuration: const Duration(milliseconds: 800),
                            transitionCurve: Curves.easeInOutCubic,
                            physics: const BouncingScrollPhysics(),
                            openAxisAlignment: 0.0,
                            debounceDelay: const Duration(milliseconds: 500),
                            scrollPadding: EdgeInsets.zero,
                            transition: CircularFloatingSearchBarTransition(spacing: 16),
                            backdropColor: Colors.transparent,
                            controller: controller,
                            title: Text(
                                selectedTerm ?? 'Search your pickup location here',
                                style: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16)
                            ),
                            leadingActions: [
                              if(selectedTerm == null) FloatingSearchBarAction(
                                showIfOpened: false,
                                child: CircularButton(
                                  icon: const Icon(
                                      Icons.search, color: Colors.grey),
                                  onPressed: () {
                                  },
                                ),
                              ),
                              if(selectedTerm != null)FloatingSearchBarAction(
                                showIfOpened: false,
                                child: CircularButton(
                                  icon: Image(image: locationicon,
                                    width: 14, height: 14,),
                                  onPressed: () {
                                  },
                                ),
                              ),
                            ],
                            hint: 'Search your pickup location here',hintStyle: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16),
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
                                curloc=!curloc;
                              });

                            }:null,


                            onQueryChanged: (query) {
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
                            onSubmitted: (query) {
                              setState(() {
                                selectedTerm = query;
                              });
                              controller.close();
                            },
                            builder: (context, transition) {
                              if(querychange.isNotEmpty){
                                if(_searchListItems.isEmpty){
                                  return Padding(
                                    padding:EdgeInsets.only(top: 49,left: getDevicewidth(context,0.25)),
                                    child: Text ("Search not found",style: TextStyle(fontFamily: 'ProximaNova-Bold',color: black),),
                                  );
                                }else{

                                  return Container(
                                      height:getDeviceheight(context,0.5),
                                      color:white,
                                      child:new ListView.builder(
                                          itemCount: _searchListItems.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return  Column(
                                              children: [
                                                ListTile(
                                                    title: Row(
                                                        children: [
                                                          Image(image: locationicon, width: 20,height: 14, ),
                                                          Text(_searchListItems[index], style: TextStyle(color: grey, fontFamily: 'ProximaNova-Regular', fontSize: 16)),

                                                        ]

                                                    ),
                                                    onTap: (){
                                                      setState(() {
                                                        selectedTerm = _searchListItems[index];
                                                        C_pickup=selectedTerm;
                                                        C_pic_lat=_searchListlat[index];
                                                        C_pic_lng=_searchListlng[index];
                                                        print(selectedTerm);
                                                        y=!y;
                                                        curloc=!curloc;
                                                        PICKUP_LOCATION = LatLng(C_pic_lat,C_pic_lng);
                                                      });
                                                      controller.close();
                                                      setMapPinspicup();

                                                    }
                                                ),
                                                Divider(color:grey,height: 10,thickness: 0.1,),
                                              ],
                                            );}));
                                }} else {

                                return Container(
                                    height: getDeviceheight(context, 0.06),//_recentsearch.length>0? getDeviceheight(context, 0.25):getDeviceheight(context, 0.06),
                                    color: white,
                                    child:Stack(
                                        children: [

                                          Align(
                                            alignment:Alignment.bottomCenter,
                                            child:Padding(
                                                padding: EdgeInsets.only(left:getDevicewidth(context, 0.21)),
                                                child: TextButton(
                                                  child:Row(
                                                    children: [
                                                      Image(image:currentlocicon, width: 14,height: 14,),
                                                      Text(usecurrentloc,style:TextStyle(color: blue,fontFamily: 'ProximaNova-Medium')),
                                                    ],
                                                  ),
                                                  onPressed: (){
                                                    Navigator.pushNamed(context, '/pickuplocation');
                                                  },
                                                )
                                            ),
                                          ),

                                        ]));

                              }

                            },
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
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom:2),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
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
                                          Navigator.pop(context);
                                          Navigator.popAndPushNamed(context, '/homecommuter');
                                        },
                                        child: Text("CONFIRM POINT",style:TextStyle(color: black,fontFamily: 'ProximaNova-Medium',fontSize: 16)),
                                      )):Container()

                                ],
                              )))
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
              title: Text("Pickup Location", style: TextStyle(fontSize: 18,fontFamily: 'ProximaNova-Medium',color: black)),
            ),
            body: body,
          );
        });
  }
  void setCustomMapPin() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/loc_marker.png');
  }

  void setMapPinspicup() {
    setState(() {
      // destination pin
      _markers.add(Marker(
          markerId: MarkerId('pickupPin'),
          position: PICKUP_LOCATION,
          icon: sourceIcon
      ));
    });
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