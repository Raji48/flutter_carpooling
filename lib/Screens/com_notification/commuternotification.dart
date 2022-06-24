
import 'package:carpooling/Actions/com_notification_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/com_notification/com_notification_modal.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:flutter/material.dart';


import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
class Commuternotification extends StatefulWidget {
  @override
  _CommuternotificationState createState() => _CommuternotificationState();
}

class _CommuternotificationState extends State<Commuternotification> {
  bool loader=false;
  String currenttime="";


  void initState(){
    var addDt = DateTime.now();
    currenttime= addDt.toString();
    print("currentime"+currenttime);
  }
  // @override
  void handleInitialBuild(ComnotificationProps props) {
    var addDT=currenttime;
    var  data = {
      "currentTime" :  addDT
    };
    props.comnotificationapi(data);

  }

  
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ComnotificationProps>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),

        builder: (context, props) {
          Widget body;
          if (props.loading==true) {
            print("loading");
            body = Center(
              child: CircularProgressIndicator(),
            );
            //loader=true;
          }
          else
          if(props.comnotification!=null) {
            loader=false;
            print("successs");
            body = new ListView.builder(
                itemCount:   props.comnotification.notifications.length,
                itemBuilder: (context, index ) {
                  return Container(
                      padding: EdgeInsets.all(17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(props.comnotification.notifications[index].date,
                        style:TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 14,color: grey)),
                          SizedBox(height: getDeviceheight(context, 0.025),),
                          Card(
                            child: Padding(
                              padding:  EdgeInsets.only(top:5,bottom:5,right: 1),
                              child: Row(
                                  children: [
                                    Container(height: 50, child: VerticalDivider(color: props.comnotification.notifications[index].status=="rejected"?red:green,thickness: 2.0,)),
                                    CircleAvatar(
                                        backgroundImage:NetworkImage("https://www.imaginetricks.com/wp-content/uploads/2017/08/beautiful-girl-profile.jpg"),
                                        radius: getDevicewidth(context, 0.045)
                                    ),
                                    SizedBox(width: getDevicewidth(context, 0.03),),
                                    Column(
                                        children: [
                                            RichText(
                                              textAlign: TextAlign.left,
                                              softWrap: true,
                                              text: TextSpan(children: <TextSpan>
                                              [
                                                TextSpan(text: "Your ride to Request to office on \n",
                                                    style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: grey)),

                                                TextSpan(text:props.comnotification.notifications[index].createdAt,
                                                    style: TextStyle(fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 14,color: black)),

                                                TextSpan(text: " has been \n ",
                                                    style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Regular',color: grey)),

                                                TextSpan(text: props.comnotification.notifications[index].status + " by ",
                                                    style:TextStyle(fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 14,color: black)),

                                                TextSpan(text: props.comnotification.notifications[index].ownerFirstName  +" "+props.comnotification.notifications[index].ownerLastName,
                                                    style:TextStyle(fontFamily: 'ProximaNova-Semiboldstyle',fontSize: 14,color: black)),

                                              ]
                                              ),
                                            ),
                                          //  style:kSubtitlestyle ,),
                                        ]),


                                  ]),
                            ),


                          ),
                        ],
                      )//)

                  );
                });
          }
          else if (props.error != null) {
            loader = false;
           body=Center(child: Text(props.error.toString()));
            print(props.error.toString());
            print("error");
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(notifications,style: TextStyle(fontFamily: 'ProximaNova-Medium',fontSize: 20,color: black)),
              automaticallyImplyLeading: false,),
            body: body,
          );

        });
  }
  }

class ComnotificationProps {
  final bool loading;
  final dynamic error;
  final Com_notification_modal comnotification ;
  final Function comnotificationapi;
  final Function clearprops;

  ComnotificationProps({
  this.loading,
  this.error,
  this.comnotification,
  this.comnotificationapi,
  this.clearprops,
  });
  }
ComnotificationProps mapStateToProps(Store<AppState> store) {
  return ComnotificationProps(
  loading: store.state.comnotification.loading,
  error: store.state.comnotification.error,
  comnotification: store.state.comnotification.comnotification,
  comnotificationapi: (data)=>store.dispatch(comnotification(data)),
  //clearprops: (data)=>store.dispatch(clearpropsupcomride(data)),
  );
  }


