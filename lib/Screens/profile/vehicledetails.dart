import 'package:carpooling/Actions/veh_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/vehicledetail/vehicledetail_model.dart';
import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vehicledetails extends StatefulWidget {
  @override
  _VehicledetailsState createState() => _VehicledetailsState();
}

class _VehicledetailsState extends State<Vehicledetails> {
  String vname, vnumber, inumber, ivalidity;
  String seatschoose;
  List listitem = [
    '4 seats', '5 seats', '6 seats', '7 seats', '8 seats'
  ];
  List a;
  bool issave=false;
  bool alertbox=false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController vehvalidity= new TextEditingController();

  void handleInitialBuild(VehicleProps props) {
    props.vehicleapi();

  }
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VehicleProps>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),
        builder: (context, props) {
          Widget body;
          if (props.loading) {
            print("loding");
            body = Center(
              child: CircularProgressIndicator(),
            );
          }else if(props.posts!=null) {

              vehvalidity.text=props.posts.vehicle.validity.toString();

            body = GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SafeArea(
                    child: SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.all(17),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 25,),
                                  Center(
                                      child: Stack(children: [
                                        new Image.network("https://thumbs.dreamstime.com/b/compact-red-car-white-background-32767906.jpg",
                                          width: 150,),
                                      ]
                                      )),
                                  SizedBox(height: 10,),
                                  Align(
                                    alignment: Alignment.center,
                                    child: RawMaterialButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            shape: topBorder,
                                            isScrollControlled: true,
                                            builder: (BuildContext context)
                                            {
                                              return StatefulBuilder(

                                                builder: (BuildContext context,
                                                    StateSetter setModalState) =>

                                                    Padding(
                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                      child: SingleChildScrollView(
                                                          child: Container(
                                                            child:
                                                            Stack(
                                                                children: [
                                                                  GestureDetector(
                                                                      onTap: () {
                                                                        FocusScope.of(context).unfocus();
                                                                      },
                                                                      child:
                                                                      Container(
                                                                          padding: EdgeInsets.all(16),
                                                                          child: Form(
                                                                              key: formkey,
                                                                              child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment
                                                                                      .start,
                                                                                  children: <Widget>[
                                                                                    SizedBox(height: 20,),
                                                                                    Row(
                                                                                        mainAxisAlignment: MainAxisAlignment
                                                                                            .spaceBetween,
                                                                                        children: <Widget>[
                                                                                          Align(alignment: Alignment
                                                                                              .topLeft,
                                                                                              child: Text(
                                                                                                editvehicledetails,
                                                                                                style: kTitlestyle,)),
                                                                                          Align(alignment: Alignment
                                                                                              .topRight,
                                                                                              child: ButtonTheme(
                                                                                                shape: RoundedRectangleBorder(
                                                                                                    borderRadius: BorderRadius
                                                                                                        .circular(20)),
                                                                                                child: RaisedButton(
                                                                                                  color: tealaccent,
                                                                                                  onPressed: () async {

                                                                                                    if(seatschoose==null){
                                                                                                      print("seatnull");
                                                                                                      String str=props.posts.vehicle.numberOfSeats;
                                                                                                      a= str.split(" ");
                                                                                                      print(a[0]);
                                                                                                      }else{
                                                                                                      String str=seatschoose;
                                                                                                       List a= str.split(" ");
                                                                                                       print(a[0]);
                                                                                                     }
                                                                                                    print(seatschoose);
                                                                                                    if (validateAndSave()) {
                                                                                                      setModalState((){
                                                                                                        issave = true;
                                                                                                      });
                                                                                                      print(seatschoose);
                                                                                                      Map data = {
                                                                                                        "vehicleName": vname,
                                                                                                        "numberOfSeats": a[0].toString(),//seatschoose,
                                                                                                        "vehicleNumber": vnumber,
                                                                                                        "insuranceNumber": inumber,
                                                                                                        "validity": ivalidity,
                                                                                                      };
                                                                                                      print(vname);
                                                                                                      print(data);
                                                                                                      var url =Uri.parse(BASE_URL+VEHICLE_DETAIL);
                                                                                                      final prefs = await SharedPreferences.getInstance();
                                                                                                      final key = 'token';
                                                                                                      final value = prefs.get(key ) ?? 0;
                                                                                                      print(value);
                                                                                                      try{
                                                                                                        var response = await http.put(url, body:data,
                                                                                                            headers: {
                                                                                                              'Authorization': 'jwt $value'
                                                                                                            });
                                                                                                        print(response.body);
                                                                                                        if(response.statusCode==200 || response.statusCode==201){

                                                                                                          setModalState((){
                                                                                                            issave = false;
                                                                                                          });
                                                                                                          props.vehicleapi();
                                                                                                          print(response.body);
                                                                                                          print(response.statusCode);
                                                                                                          Navigator.pop(context);
                                                                                                          updatealert();
                                                                                                        }else if(response.statusCode>200){
                                                                                                          setModalState((){
                                                                                                            issave = false;
                                                                                                          });
                                                                                                          print(response.statusCode);
                                                                                                          setState(() {
                                                                                                            alertbox=!alertbox;
                                                                                                          });
                                                                                                        }
                                                                                                        else {
                                                                                                          setState(() =>
                                                                                                          issave = false);
                                                                                                          print(response
                                                                                                              .statusCode);
                                                                                                        }
                                                                                                      }catch(e){
                                                                                                        setState(() =>
                                                                                                        issave = false);
                                                                                                        alert();
                                                                                                      }
                                                                                                    }
                                                                                                  },
                                                                                                  child: Text(submit),
                                                                                                ),

                                                                                              )),
                                                                                        ]
                                                                                    ),
                                                                                    Text(edityourvehicle,
                                                                                      style: kSubtitlestyle,),
                                                                                    SizedBox(height: 10.0,),
                                                                                    TextFormField(
                                                                                      initialValue: props.posts.vehicle.vehicleName,
                                                                                      keyboardType: TextInputType.text,
                                                                                      inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                                                                                      validator: validatefield,
                                                                                      onSaved: (input) => vname = input,
                                                                                      decoration: buildInputDecoration(
                                                                                          vehiclename),
                                                                                    ),
                                                                                    SizedBox(height: 10.0,),
                                                                                    Container(
                                                                                      padding: EdgeInsets.only(
                                                                                          left: 16,
                                                                                          right: 16,
                                                                                          top: 2,
                                                                                          bottom: 2),
                                                                                      decoration: BoxDecoration(
                                                                                          border: Border.all(
                                                                                              color: lightgrey, width: 1.3)
                                                                                      ),
                                                                                      child: DropdownButton(

                                                                                        hint: seatschoose == null
                                                                                            ? Text(props.posts.vehicle
                                                                                            .numberOfSeats+" seats",style: TextStyle(color: black))
                                                                                            : Text(
                                                                                          seatschoose,
                                                                                          style: TextStyle(color: black),
                                                                                        ),
                                                                                        isExpanded: true,
                                                                                        underline: SizedBox(),
                                                                                        iconSize: 30.0,
                                                                                        style: TextStyle(color: black),
                                                                                        value: seatschoose,
                                                                                        onChanged: (newValue) {
                                                                                          setModalState((){
                                                                                            seatschoose=newValue;
                                                                                          });
                                                                                        },
                                                                                        items: listitem.map((valueItem) {
                                                                                          return DropdownMenuItem(
                                                                                            value: valueItem,
                                                                                            child: Text(
                                                                                              valueItem,),
                                                                                          );
                                                                                        }).toList(),
                                                                                      ),
                                                                                    ),

                                                                                    SizedBox(height: 10.0,),
                                                                                    TextFormField(
                                                                                      initialValue: props.posts.vehicle.vehicleNumber,
                                                                                      keyboardType: TextInputType.text,
                                                                                      validator: validatefield,
                                                                                      inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                                                                                      onSaved: (input) => vnumber = input,
                                                                                      maxLength: 10,
                                                                                      decoration: InputDecoration(
                                                                                        labelText: vehiclenumber,
                                                                                        labelStyle: TextStyle(
                                                                                            color: grey),
                                                                                        focusedBorder: focusborder,
                                                                                        border: enableborder,
                                                                                        enabledBorder: enableborder,
                                                                                        counterText: "",
                                                                                      ),
                                                                                    ),
                                                                                    SizedBox(height: 10.0,),
                                                                                    TextFormField(
                                                                                      initialValue: props.posts.vehicle.insuranceNumber,
                                                                                      keyboardType: TextInputType.text,
                                                                                      inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                                                                                      decoration: buildInputDecoration(insurancenumber),
                                                                                      validator: validatefield,
                                                                                      onSaved: (input) => inumber = input,
                                                                                    ),
                                                                                    SizedBox(height: 10.0,),
                                                                                    TextFormField(

                                                                                      controller:vehvalidity,
                                                                                           readOnly:true ,
                                                                                      decoration: buildInputDecoration(insurancevalidity),
                                                                                      validator: validatefield,
                                                                                      onSaved: (input) => ivalidity = input,
                                                                                      onTap: () async {
                                                                                          var datevalidity = await  showDatePicker(
                                                                                                context: context,
                                                                                                initialDate: DateTime.now(),
                                                                                                firstDate: DateTime(2021, 1),
                                                                                                lastDate: DateTime(2050,12),
                                                                                              );
                                                                                            vehvalidity.text=datevalidity.toString().substring(0,10);
                                                                                      },),

                                                                                  ]
                                                                              ))
                                                                      )),
                                                                  issave?Container(
                                                                      width:MediaQuery.of(context).size.width,
                                                                      height: 460,
                                                                      // height: MediaQuery.of(context).size.height,
                                                                      color: Colors.black26,
                                                                      child:Align(
                                                                          alignment: Alignment.center,
                                                                          child:Container(
                                                                            child: CircularProgressIndicator(),
                                                                          )
                                                                      )
                                                                  ):Container(),
                                                                  if(alertbox)  Container(
                                                                      child: Positioned(
                                                                          top: 20,
                                                                          left: 0,
                                                                          right: 0,
                                                                          child:Container(
                                                                              color: red,
                                                                              padding: EdgeInsets.all(6),
                                                                              child: Row(
                                                                                  children: <Widget>[
                                                                                    SizedBox(width: getDevicewidth(context, 0.02),),
                                                                                    Text("Invalid Credentials",
                                                                                      style:TextStyle(color: white,fontFamily:'ProximaNova-Medium',fontSize: 16),),
                                                                                    new Flexible(child:
                                                                                    Align(alignment: Alignment.topRight,

                                                                                        child: IconButton(
                                                                                            icon: Icon(Icons.close_rounded,color: white,),
                                                                                            onPressed: (){
                                                                                              setModalState((){
                                                                                                alertbox=!alertbox;

                                                                                              });
                                                                                            }))),
                                                                                  ])))),
                                                                ]),
                                                          )),
                                                    ),
                                              );
                                            });
                                      },
                                      child: Image(image:editicon,
                                        width: 40,height: 33,),
                                      shape: CircleBorder(),
                                    ),),
                                  SizedBox(height: 10,),
                                  FlatButton.icon(
                                      icon:  Image(image:isymbolicon,width: 20,height: 20,),
                                      label: Text(vehicledetails,
                                          style:TextStyle(fontFamily: 'ProximaNova-Regular',color:Colors.black87,fontWeight: FontWeight.bold))),
                                  SizedBox(height: 10,),
                                  Padding(
                                      padding: EdgeInsets.only(left: getDevicewidth(context, 0.1)),
                                      child:
                                      Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(vehiclename,style:kSubtitlestyle,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(props.posts.vehicle.vehicleName,style: TextStyle(fontSize: 16,fontFamily: 'ProximaNova-Medium',color: black),),
                                            SizedBox(height:getDeviceheight(context, 0.01),),
                                            Divider(color: grey,indent: 0,endIndent: 0,height: 10,thickness: 0.05,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(seatcount,style:kSubtitlestyle,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(props.posts.vehicle.numberOfSeats+" seats",style: TextStyle(fontSize: 16,fontFamily: 'ProximaNova-Medium',color: black),),
                                            SizedBox(height:getDeviceheight(context, 0.01),),
                                            Divider(color: grey,height: 10,thickness: 0.06,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(vehiclenumber,style:kSubtitlestyle,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(props.posts.vehicle.vehicleNumber,style: TextStyle(fontSize: 16,fontFamily: 'ProximaNova-Medium',color: black),),
                                            SizedBox(height:getDeviceheight(context, 0.01),),
                                            Divider(color: grey,height: 10,thickness: 0.06,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(insurancenumber,style:kSubtitlestyle,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(props.posts.vehicle.insuranceNumber,style: TextStyle(fontSize: 16,fontFamily: 'ProximaNova-Medium',color: black),),
                                            SizedBox(height:getDeviceheight(context, 0.01),),
                                            Divider(color: grey,height: 10,thickness: 0.06,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(insurancevalidity,style:kSubtitlestyle,),
                                            SizedBox(height:getDeviceheight(context, 0.01)),
                                            Text(props.posts.vehicle.validity,style: TextStyle(fontSize: 16,fontFamily: 'ProximaNova-Medium',color: black),),

                                          ]))
                                ])))));
          }
          else if(props.error){
            print(props.error);
            body=Text(props.error);
          }
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: BackButton(
                color: blacklight,
              ),
              title: Text(vehicledetails, style: TextStyle(fontFamily: 'ProximaNova-Medium',color:black,fontSize: 20)),),
            body: body,
          );
        });
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void updatealert() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(milliseconds: 300), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: whitelight,
            title: Center(child: Text("Updated Successfully",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
          );
        });
  }

  void alert() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: whitelight,
            title: Center(child: Text("Please Try Again",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
          );
        });
  }

}






class VehicleProps {
  final bool loading;
  final dynamic error;
  final Vehicledetail posts;
  final Function vehicleapi;

  VehicleProps({
    this.loading,
    this.error,
    this.posts,
    this.vehicleapi
  });
}
VehicleProps mapStateToProps(Store<AppState> store) {
  return VehicleProps(
    loading: store.state.postsState.loading,
    error: store.state.postsState.error,
    posts: store.state.postsState.posts,
    vehicleapi: ()=>store.dispatch(vehicledata()),

  );
}


