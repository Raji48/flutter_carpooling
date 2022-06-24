

import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/veh_trips/past.dart';
import 'package:carpooling/Screens/veh_trips/upcome.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Mytrips extends StatefulWidget {
  @override
  _MytripsState createState() => _MytripsState();
}

class _MytripsState extends State<Mytrips> {
  bool loader = false;
  String currenttime = "";
  TabController tabController;
  Future<void> _launched;
  String _phone;


  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  // @override
  void initState() {
    super.initState();
    var addDt = DateTime.now();
    currenttime = addDt.toString();
    print("currentime" + currenttime);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(mytrips, style: TextStyle(
            fontFamily: 'ProximaNova-Medium', fontSize: 20, color: black)),
        automaticallyImplyLeading: false,),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: Material(
                color: Colors.white,
                child: TabBar(
                    indicatorColor: white,
                    labelColor:black,
                    unselectedLabelColor: greylight,
                    indicator: BoxDecoration(
                      color: tabbarcolor,
                    ),
                    tabs: [
                      Tab(
                        child: Text("Past", style: TextStyle(
                          fontFamily: 'ProximaNova-Regular',
                          fontSize: 18,), textAlign: TextAlign.center,),
                      ),
                      Tab(child: Text("Upcoming", style: TextStyle(
                        fontFamily: 'ProximaNova-Regular',
                        fontSize: 18,), textAlign: TextAlign.center,),)
                    ]
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Past(),
                  Upcome()
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}
