


import 'package:carpooling/Actions/locationplaces_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/locationplaces/places_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/com_ride/scheduleride.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:redux/redux.dart';

class Droplocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DroplocationState();
}

class DroplocationState extends State<Droplocation> {
 GoogleMapController mapController;
 String querychange="";
 List<String>_searchListItems = [];
 List<double>_searchListlat = [];
 List<double>_searchListlng = [];
 bool loader=false;


  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
 LatLng pinPosition = C_pic_lng==null?LatLng(12.848598,80.225684):LatLng(C_pic_lat,C_pic_lng);
 String selectedTerm;

  FloatingSearchBarController controller;
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

 // @override
  void handleInitialBuild(PlaceslistProps props) {
    props.placelistapi();
 }


  Widget build(BuildContext context) {

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
        print("success location");
        print(props.placeslist.places[1].name);
        body=SafeArea(
              child: Stack(
                  children: [
                    Container(
                       child: GoogleMap(
                       markers: _markers,
                           initialCameraPosition: CameraPosition(
                                   zoom: 13.0,   bearing: 30,  target:pinPosition,  // LatLng( 12.898265, 80.225691) //11.1271,78.6569 )           //21.1458,79.0882)
                                ),
                           onMapCreated: (
                               GoogleMapController googleMapController) {
                     setMapPins();
                    setState(() {
                      mapController = googleMapController;

                    });
                  })),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Container(
                         child: FloatingSearchBar(
                            controller: controller,
                           backdropColor: Colors.transparent,
                           openAxisAlignment: 0.0,
                           scrollPadding: EdgeInsets.zero,
                           transition: CircularFloatingSearchBarTransition(),
                           physics: BouncingScrollPhysics(),
                            title: Text(
                                C_pickup.isEmpty
                                    ? 'Search your pickup location here'
                                    : C_pickup,
                                style: TextStyle(color: grey,fontFamily: 'ProximaNova-Regular',fontSize: 16)),
                            automaticallyImplyBackButton: false,
                            leadingActions: [
                              FloatingSearchBarAction(
                                showIfOpened: false,
                                child: CircularButton(
                                  icon: Image(image: locationicon,
                                    width: 14, height: 14,),
                                  onPressed: () {},
                                ),
                              ),
                            ],

                            hint: 'Search your pickup location here',
                            actions: [
                            ],
                            builder: (context, transition) {
                            return null;
                            },
                          )
                      ),
                    ),
                   Padding(
                        padding: const EdgeInsets.only(top: 50,),
                        child: Container(
                            child: FloatingSearchBar(
                              controller: controller,
                              clearQueryOnClose: true,
                              scrollPadding: EdgeInsets.zero,
                              backdropColor: Colors.transparent,
                              transition: CircularFloatingSearchBarTransition(),
                              physics: BouncingScrollPhysics(),
                              title: Text(
                                  selectedTerm ??
                                      'Search your drop location here',
                                  style: TextStyle(color: grey,
                                      fontFamily: 'ProximaNova-Regular',
                                      fontSize: 16)
                              ),
                              automaticallyImplyBackButton: false,
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
                                    icon: Image(image: locationicon, width: 14, height: 14,),
                                    onPressed: () {
                                      },
                                  ),
                                ),
                              ],
                              hint: 'Search your drop location here',
                              actions: [
                                FloatingSearchBarAction.searchToClear(
                                  showIfClosed: false,
                                  color: grey,
                                ),
                              ],

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
                              //  return   _searchAddList();
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
                                                 padding:EdgeInsets.only(top: 100,left: getDevicewidth(context,0.25)),
                                                 child: Text ("Search not found",style: TextStyle(fontFamily: 'ProximaNova-Bold',color: black),),
                                               );
                                             }else{
                                             return Container(
                                                height: getDeviceheight(context,0.5),
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
                                                                        ],
                                                                      ),
                                                                    onTap: (){
                                                                      setState(() {
                                                                        selectedTerm =_searchListItems[index];
                                                                        C_droploc=selectedTerm;
                                                                        C_drop_lat=_searchListlat[index];
                                                                        C_drop_lng=_searchListlng[index];
                                                                       /* if(_recentsearch.length==2) _recentsearch.removeAt(0);
                                                                        _recentsearch.add(_searchListItems[index]);
                                                                        _recentsearchlat.add(_searchListlat[index]);
                                                                        _recentsearchlng.add(_searchListlng[index]);
                                                                        print('recentitem');
                                                                        print(_recentsearch.length);*/

                                                                      });

                                                                      controller.close();
                                                                      if(selectedTerm!=null && C_pickup.isNotEmpty){
                                                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>Commuterscheduleride()));
                                                                      }
                                                                    },
                                                                  ),
                                                                  Divider(color:grey,height: 10,thickness: 0.1,),
                                                                ],

                                                              );

                                                            }));

                                          } }else {
                                             return null;
                                          }

                              },
                            ))),
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
      leading: BackButton(color: blacklight,

    ),
      backgroundColor: Colors.white,
      title: Text("Drop Location", style: TextStyle(
      fontSize: 18, fontFamily: 'ProximaNova-Medium', color: black)),
      ),
        body: body,
     );
    });
  }


    void setCustomMapPin() async {
          pinLocationIcon = await BitmapDescriptor.fromAssetImage(
            //ImageConfiguration(),//
             ImageConfiguration(size:Size(5,50),),
               'assets/images/loc_marker.png',
             );
      }

  void setMapPins() {
      setState(() {
        // destination pin
        _markers.add(Marker(
            markerId: MarkerId('pickupPin'),
            position: pinPosition,
            icon: pinLocationIcon
        ));
      });
    }
  }





class PlaceslistProps {
  final bool loading;
  final dynamic error;
  final Placesmodal placeslist ;
  final Function placelistapi;
 final Function clearprops;

  PlaceslistProps({
    this.loading,
    this.error,
    this.placeslist,
    this.placelistapi,
    this.clearprops,
  });
}
PlaceslistProps mapStateToProps(Store<AppState> store) {
  return PlaceslistProps(
    loading: store.state.placelist.loading,
    error: store.state.placelist.error,
    placeslist:store.state.placelist.placelists,
    placelistapi:()=>store.dispatch(placeslist()),
      clearprops: (data)=>store.dispatch(clearpropsplaces(data))
  );
}