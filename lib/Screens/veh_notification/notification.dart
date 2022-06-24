import 'package:carpooling/Actions/veh_notification_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/veh_notification/veh_notification_modal.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool loader=false;
  String currenttime="";


  void initState(){
    var addDt = DateTime.now();
    currenttime= addDt.toString();
    print("currentime"+currenttime);
  }
  // @override
  void handleInitialBuild(VehnotificationProps props) {
    var addDT=currenttime;
    var  data = {
      "currentTime" :  addDT//"2021-05-03 16:50:58.265078"
    };
    props.vehnotificationapi(data);

  }

 // @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VehnotificationProps>(
    converter: (store) => mapStateToProps(store),
    onInitialBuild: (props) => this.handleInitialBuild(props),

    builder: (context, props) {
    Widget body;
    if (props.loading) {
    body = Center(
    child: CircularProgressIndicator(),
    );
    }
    else
    if(props.vehnotification!=null) {
    loader=false;
    print("successs");
        body = new ListView.builder(
        itemCount:   props.vehnotification.notifications.length,
            itemBuilder: (context, index ) {

              return Padding(
                padding:EdgeInsets.only(top: getDeviceheight(context,0.015),left: 1,right: 1),
                child: Container(

            child: Column(
                  children: [
                   Card(
                     color: white,
                       child: Padding(
                         padding:  EdgeInsets.only(top:getDeviceheight(context, 0.01),bottom:getDeviceheight(context, 0.01)
                            ,right: 1),
                       child:  Row(
                            children: [
                              Container(height: 50, child: VerticalDivider(color: props.vehnotification.notifications[index].status=="cancelled"?red:green,thickness: 2.0,)),
                              CircleAvatar(
                                  backgroundImage:NetworkImage("https://bestprofilepix.com/wp-content/uploads/2014/03/cute-stylish-winter-girls-facebook-profile-pictures.jpg"),
                                  radius: getDevicewidth(context, 0.045)
                              ),
                              SizedBox(width: getDevicewidth(context, 0.02),),
                              Column(
                                 children: [
                                      if(props.vehnotification.notifications[index].status=="requested")
                                     RichText(
                                        textAlign: TextAlign.left,
                                        softWrap:true,
                                        text: TextSpan(children: <TextSpan>
                                        [
                                          TextSpan(text: props.vehnotification.notifications[index].commuterFirstName+" "+props.vehnotification.notifications[index].commuterLastName,
                                              style:TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 14,color: black)),
                                          TextSpan(text: " has ",
                                              style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: grey)),
                                          TextSpan(text: props.vehnotification.notifications[index].status, // "Your Ride Request to office on ",
                                              style:TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 14,color: black)),
                                          TextSpan(text: " you for a ride to\noffice, Scheduled on ",
                                              style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: grey)),
                                          TextSpan(text:props.vehnotification.notifications[index].createdAt,
                                              style: TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 14,color: black)),

                                        ]
                                        ),
                                      ),
                                      if(props.vehnotification.notifications[index].status=="cancelled")
                                      RichText(
                                        textAlign: TextAlign.left,
                                        softWrap: false,
                                        text: TextSpan(children: <TextSpan>
                                        [
                                          TextSpan(text: props.vehnotification.notifications[index].commuterFirstName+" "+props.vehnotification.notifications[index].commuterLastName,
                                              style:TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 14,color: black)),
                                          TextSpan(text: " has ",
                                              style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: grey)),
                                          TextSpan(text: props.vehnotification.notifications[index].status, // "Your Ride Request to office on ",
                                              style:TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 14,color: black)),
                                          TextSpan(text: " their request for the \n ride Scheduled on at ",
                                              style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: grey)),
                                          TextSpan(text: props.vehnotification.notifications[index].slotName+" |\n"+props.vehnotification.notifications[index].createdAt,
                                              style: TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 14,color: black)),

                                        ]
                                        ),
                                      ),



                                      //  style:kSubtitlestyle ,),
                                  ]),


                            ]),
                       )),


                  ]  ),



             ),
              );
             });
    }
    else if (props.error != null) {
    loader = false;
    body= Center(child: Text(props.error));
    print(props.error);
    print("error");
    }


      return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(notifications,style: TextStyle(fontFamily: 'ProximaNova-Regular',fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.bold,)),
        //style: kTitlestyle,),
        automaticallyImplyLeading: false,),
    body: body,
    );

  });
  }
}

class VehnotificationProps {
  final bool loading;
  final dynamic error;
  final Veh_owner_notification_modal vehnotification ;
  final Function vehnotificationapi;
  final Function clearprops;

  VehnotificationProps({
    this.loading,
    this.error,
    this.vehnotification,
    this.vehnotificationapi,
    this.clearprops,
  });
}
VehnotificationProps mapStateToProps(Store<AppState> store) {
  return VehnotificationProps(
    loading: store.state.vehnotification.loading,
    error: store.state.vehnotification.error,
    vehnotification: store.state.vehnotification.vehnotification,
    vehnotificationapi: (data)=>store.dispatch(vehnotification(data)),
    //clearprops: (data)=>store.dispatch(clearpropsupcomride(data)),
  );
}
