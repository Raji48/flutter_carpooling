
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/com_trips/pasttrips.dart';
import 'package:carpooling/Screens/com_trips/requestedtrips.dart';
import 'package:carpooling/Screens/com_trips/upcomingtrips.dart';
import 'package:flutter/material.dart';

class Commutertrips extends StatefulWidget {
  @override
  _CommutertripsState createState() => _CommutertripsState();
}

class _CommutertripsState extends State<Commutertrips> {
  bool loader = false;
  String currenttime = "";
  TabController tabController;

  void initState() {
    super.initState();
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
        length: 3,
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

                      Tab(child: Text("Requested", style: TextStyle(
                        fontFamily: 'ProximaNova-Regular',
                        fontSize: 18,), textAlign: TextAlign.center,),),
                      Tab(child: Text("Approved", style: TextStyle(
                        fontFamily: 'ProximaNova-Regular',
                        fontSize: 18,), textAlign: TextAlign.center,),)
                    ]
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Compastride(),
                  Requestedtrips(),
                  Upcometrips(),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }


}
