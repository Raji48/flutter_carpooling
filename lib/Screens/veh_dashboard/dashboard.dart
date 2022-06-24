
import 'dart:convert';

import 'package:carpooling/Model/vehicledetail/vehicledetail_model.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/home_vehicle/home.dart';
import 'package:carpooling/Screens/profile/vehicledetails.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool issave= false;
  bool alertbox =false;
  String vname, vnumber, inumber, ivalidity;
  String seatschoose;
  List a;
  List listitem = [
    '4 seats', '5 seats', '6 seats', '7 seats', '8 seats'
  ];
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FocusNode vnamefield = FocusNode();
  FocusNode vnumfield= FocusNode();
  FocusNode inumfield = FocusNode();
  FocusNode ivalidityfield= FocusNode();
  TextEditingController vehvalidity= new TextEditingController();



  @override
  Widget build(BuildContext context) {
  /* return WillPopScope(
        onWillPop:(){
          Navigator.pushNamed(
              context, '/Role');
        },
    child:*/
   return  Scaffold(
      backgroundColor: white,
       // resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body:
            Stack(
        children:[
        GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
                child: SingleChildScrollView(
                  //child: Form(
                  //  key: formkey,
                    child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30,),
                              Align(alignment: Alignment.topLeft,
                                child: Text("Hello, "+username+"!", style: TextStyle(fontSize: 24,fontFamily: 'ProximaNova-Medium',color: black),),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //new Flexible(
                                      //child:
                                      Text(profilecompletion,
                                        style: kSubtitlestyle,),
                                    //),
                                    new Flexible(
                                      child: Align(alignment: Alignment
                                          .topRight,
                                          child: Text(sixty,
                                            style: TextStyle(color: blue,
                                                fontWeight: FontWeight
                                                    .bold),)),
                                    )
                                  ]
                              ),
                              SizedBox(height: 10,),
                              Container(
                                  height: 20,
                                  width: double.infinity,
                                  child: Image(image: profilestatus,
                                    fit: BoxFit.cover,)
                              ),
                              SizedBox(height: 70,),
                              Center(
                                child: Container(
                                    width: double.infinity,
                                    child: Image(
                                      image: dashboard, fit: BoxFit.cover,)
                                ),
                              ),
                              SizedBox(height: 20.0,),
                              Center(
                                  child: Text(
                                    almostthere, style: TextStyle(
                                   color: black, fontSize: 20, fontFamily: 'ProximaNova-Semiboldstyle',))),
                              SizedBox(height: 10.0,),
                              Center(
                                  child: Text(
                                      setstart, style: kSubtitlestyle)),
                              SizedBox(height: 20.0,),
                              ButtonTheme(
                                minWidth: 400,
                                height: 40,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20)),
                                child: FlatButton(
                                  color: tealaccent,
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: topBorder,
                                        //isDismissible: false,
                                       // enableDrag: false,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setModalState) =>
                                              //   Container());
                                              //  });
                                              //   showModalBottomSheet(
                                              // context: context,
                                              //  isScrollControlled: true,
                                              // shape: topBorder,
                                              // builder: (context) =>
                                              SafeArea(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: SingleChildScrollView(
                                                        child: Form(
                                                            key: formkey,
                                                            child: Container(
                                                              /*  padding: EdgeInsets
                                                            .only(
                                                            bottom: MediaQuery
                                                                .of(
                                                                context)
                                                                .viewInsets
                                                                .bottom),*/
                                                              child:
                                                         /*     vehicledetail(),
                                                            ))))
                                          );
                                        });
                                  },
                                  child: Text(completenow),
                                ),
                              ),
                            ]
                        )))))


    );
  }*/

 // vehicledetail() {
  //   return
     Stack(
        children:[
   //   GestureDetector(
       // onTap: () {
       //   FocusScope.of(context).unfocus();
      //  },
     //   child:
     Container(
        padding: EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(alignment: Alignment.topLeft,
                        child: Text(vehicledetails, style: kTitlestyle,)),
                    Align(alignment: Alignment.topRight,
                        child: ButtonTheme(
                          height: getDeviceheight(context, 0.05) ,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: FlatButton(
                            color: tealaccent,
                            onPressed: () async {
                              // String str=seatschoose;
                              // List a= str.split(" ");
                              // print(a[0]);
                              // print("list");
                              String str=seatschoose;
                              List a= str.split(" ");
                              print(a[0]);

                              if(seatschoose==null){
                                String str="4 seats";
                                 a= str.split(" ");
                                print(a[0]);
                                setModalState((){
                             //   seatschoose=a[0];
                                });
                              }
                              print(seatschoose);
                              print(vname);
                              if (validateAndSave()) {
                                setModalState(() {
                                  issave = true;
                                });
                                // Navigator.pop(context);
                                print(seatschoose);
                                print(vname);
                                print(vnumber);
                                print(ivalidity);
                                //  send();
                                Map data = {
                                  "vehicleName": vname,
                                  "numberOfSeats":a[0].toString(), //seatschoose,//a[0].toString(),//
                                  "vehicleNumber": vnumber,
                                  "insuranceNumber": inumber,
                                  "validity": ivalidity,
                                };
                                print(data);
                                print(vname);
                                var url = Uri.parse(BASE_URL + VEHICLE_DETAIL);
                                final prefs = await SharedPreferences
                                    .getInstance();
                                final key = 'token';
                                final value = prefs.get(key) ?? 0;
                                print(value);
                                try {
                                  var response = await http.post(
                                    url, body: data,
                                    //"http://54.235.130.26:8002/api/user/vehicle",
                                    headers: {
                                      'Authorization': 'jwt $value'
                                    },
                                  );
                                  print(response.body);
                                  // Navigator.push(context,MaterialPageRoute(builder: (context)=>Vehicledetails()));
                                  if (response.statusCode == 200 ||
                                      response.statusCode == 201) {
                                    Navigator.pop(context);
                                    Navigator.of(context).pushReplacementNamed('/home');
                                   // Navigator.push(context,
                                   //   MaterialPageRoute(builder: (context) =>Home()),
                                   // );
                                    setModalState(() {
                                      issave = false;
                                    });
                                    //Navigator.pop(context);
                                    print("successful");
                                    print(response.body);
                                    print(response.statusCode);
                                    //updatealert();
                                  } else if (response.statusCode >
                                      202) {

                                    setModalState(() {
                                      issave = false;
                                    });
                                    print(response.body);
                                    setModalState(() {
                                      alertbox = !alertbox;
                                    });
                                  }
                                  else {
                                    //setState(() => issave = false);
                                    print(response.statusCode);
                                    alert();
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
              Text(entervehicle, style: kSubtitlestyle,),
              SizedBox(height: 10.0,),
              TextFormField(
                inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                focusNode: vnamefield,
                validator: validatefield,
                keyboardType: TextInputType.text,
                onSaved: (input) => vname = input,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  validatefield(value);
                },
                onFieldSubmitted: (value) {
                  formkey.currentState.validate();
                  if(validatefield(value)==null){
                    FocusScope.of(context).unfocus();
                  } else {
                    FocusScope.of(context).requestFocus(vnamefield);
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: enableborder,
                  focusedBorder: focusborder,
                  border: enableborder,
                  labelText: vehiclename,
                  labelStyle: TextStyle(color: grey),
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                padding: EdgeInsets.only(
                    left: 16, right: 16, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    border: Border.all(color: lightgrey, width: 1.3)
                ),
                child: DropdownButton(
                  hint: seatschoose == null
                      ? Text("Seat Count", style: TextStyle(color: grey),)
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
                    }
                    );

                 //   setState(() {
                    //  seatschoose = newValue;
                   // });
                  },
                  items: listitem.map((valueItem) {
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(
                        valueItem,),
                    );
                  }).toList(),
                ),

              ), //),



              SizedBox(height: 10.0,),
              TextFormField(
                inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                focusNode: vnumfield,
                onSaved: (input) => vnumber = input,
                validator: validatefield,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                maxLength: 10,
                onChanged: (value) {
                  validatefield(value);
                },
                onFieldSubmitted: (value) {
                  formkey.currentState.validate();
                  if(validatefield(value)==null){
                    FocusScope.of(context).requestFocus(inumfield);
                  } else {
                    FocusScope.of(context).requestFocus(vnumfield);
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: enableborder,
                  focusedBorder: focusborder,
                  border: enableborder,
                  labelText: vehiclenumber,
                  labelStyle: TextStyle(color: grey),
                  counterText: "",
                ),
              ),

              SizedBox(height: 10.0,),
              TextFormField(
                focusNode: inumfield,
                inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                maxLength: 20,
                onSaved: (input) => inumber = input,
                validator: validatefield,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  validatefield(value);
                },
                onFieldSubmitted: (value) {
                  formkey.currentState.validate();
                  if(validatefield(value)==null){
                    FocusScope.of(context).requestFocus(ivalidityfield);
                  } else {
                    FocusScope.of(context).requestFocus(inumfield);
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: enableborder,
                  focusedBorder: focusborder,
                  border: enableborder,
                  labelText: insurancenumber,
                  labelStyle: TextStyle(color: grey),
                  counterText: "",
                ),
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                focusNode: ivalidityfield,
                controller: vehvalidity,
                readOnly: true,
                onSaved: (input) => ivalidity = input,
                validator: validatefield,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  validatefield(value);
                },
                onFieldSubmitted: (value) {
                  formkey.currentState.validate();
                  if(validatefield(value)==null){
                    FocusScope.of(context).unfocus();
                  } else {
                    FocusScope.of(context).requestFocus(ivalidityfield);
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: enableborder,
                  focusedBorder: focusborder,
                  border: enableborder,
                  labelText: insurancevalidity,
                  labelStyle: TextStyle(color: grey),
                ),
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
        )
     ),//Container();
        issave? Container(
              width:MediaQuery.of(context).size.width,
            height: 450,
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
                            Text("vehicle details already Exist",
                              style:TextStyle(color: white,fontFamily:'ProximaNova-Regular',fontSize: 18),),

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

                                                        ))),
                                                  ))
                                          );
                                        });
                                  },
                                  child: Text(completenow,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black)),
                                ),
                              ),
                            ]
                        ))

                ))),

    ])


    );
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


