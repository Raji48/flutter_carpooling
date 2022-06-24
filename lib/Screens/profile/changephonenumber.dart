
import 'dart:async';

import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/profile/profile.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Changephonenumber extends StatefulWidget {
  final String changenumber;
  const Changephonenumber({Key key,@required this.changenumber,}): super(key:key);
  @override
  _ChangephonenumberState createState() => _ChangephonenumberState();
}

class _ChangephonenumberState extends State<Changephonenumber> {
  StreamController<ErrorAnimationType> errorController;
  var _controller = TextEditingController();
  String firstdigit,seconddigit,thirddigit,fourthdigit,fifthdigit,sixthdigit;
  bool x=false;
  GlobalKey<FormState> formkey =GlobalKey<FormState>();
  bool issave= false;
  bool alertbox=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:white,
        body:
            Stack(
        children:[
        GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
                child: SingleChildScrollView(
                    child:Form(
                        key:formkey,
                        child: Container(
                            padding: EdgeInsets.all(17),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 20,),
                                  Row(
                                      children: [
                                        Align(alignment: Alignment.topLeft,
                                            child:IconButton(
                                              icon:Image(image:backarrowicon,
                                                  width: 25,height: 26,color: black),
                                              onPressed: () =>  Navigator.pop(context)

                                            )),
                                        SizedBox(width: 30,),
                                      if(x)  Container(
                                            color: bluelight,
                                            child:Row(
                                              children: [
                                                Icon(Icons.person,color: green,),
                                                Text(otpverified,style: TextStyle(color: green,fontSize: 17,fontFamily: 'ProximaNova-Regular'),),
                                              ],
                                            )),
                                      ]),
                                  SizedBox(height: 30,),
                            Padding(
                            padding: EdgeInsets.only(left: getDevicewidth(context, 0.05)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(otpverification,style:TextStyle(fontFamily:'ProximaNova-Bold',fontSize: 22,color: black1),textAlign: TextAlign.start,),
                                  SizedBox(height: 10,),
                                  Text(sendotpnewnum,style:kSubtitlestyle,textAlign: TextAlign.start,),
                                  SizedBox(height: 35),
                                  PinCodeTextField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    appContext: context,
                                    length: 6,
                                    obscureText: false,
                                    animationType: AnimationType.fade,
                                    validator: (v) {
                                      if ( v.length < 6 ) {
                                        return"";

                                      } else {
                                        return '';
                                      }
                                    },
                                    pinTheme: PinTheme(
                                      borderWidth: 1.5,
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(15.0),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: Colors.tealAccent,
                                        selectedColor:green
                                    ),
                                    animationDuration: Duration(milliseconds: 300),
                                    backgroundColor: Colors.transparent,
                                    errorAnimationController: errorController,
                                    controller: _controller,
                                    keyboardType: TextInputType.number,

                                    onCompleted: (text) {},
                                    onSubmitted: (text) {

                                    },
                                    onChanged: (text) {

                                    },
                                    beforeTextPaste: (text) {
                                      return true;
                                    },
                                  ),

                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child:Text(didnotgetotp)),
                                  Center(
                                      child: RaisedButton(

                                        onPressed: () async {


                                          Map body={
                                            "newPhoneNumber":widget.changenumber,

                                          };
                                          print(body);
                                          final prefs = await SharedPreferences.getInstance();
                                          final key = 'token';
                                          final value = prefs.get(key ) ?? 0;
                                          print(value);
                                          var url=Uri.parse(BASE_URL+VERIFY_NEW_NUMBER,);
                                          var response = await http
                                              .put(
                                             url,
                                              body: body, headers: {
                                            'Authorization': 'jwt $value'
                                          }
                                          );
                                          print("success");
                                          print(response.body);
                                          print(response.statusCode);
                                          if(response.statusCode==200 || response.statusCode==201){
                                            print(response.statusCode);
                                          }else{
                                            print("retry");
                                          }

                                        },
                                        color:lightgrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20)),
                                        child: Text(resend),
                                      )),
                                  SizedBox(height: 50,),
                                  Center(
                                      child:RawMaterialButton(
                                        onPressed: () async {
                                          if(_controller.text.length<6){
                                          setState(() {
                                          alertbox=!alertbox;
                                          });
                                          }
                                          if(_controller.text.length==6) {
                                            Map body = {
                                              "newPhoneNumber": widget
                                                  .changenumber,
                                              "otpCode": _controller.text,
                                            };
                                            print(body);

                                            final prefs = await SharedPreferences.getInstance();
                                            final key = 'token';
                                            final value = prefs.get(key ) ?? 0;
                                            print(value);
                                            var url=Uri.parse(BASE_URL+CHANGE_PHONE_NUMBER);
                                            var response = await http
                                                .put(
                                              url,
                                                body: body,
                                                headers: {
                                                  'Authorization': 'jwt $value'
                                                }
                                            );
                                            print("success");
                                            print(response.body);
                                            print(response.statusCode);
                                            if (response.statusCode == 200 ||
                                                response.statusCode == 201) {
                                              Navigator.pop(context);
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Profile()));
                                              print(response.statusCode);
                                            } if (response.statusCode >
                                                       202) {
                                              setState(() => issave = false);
                                              print(response.body);
                                              setState(() {
                                                alertbox = true;
                                              });
                                            }

                                            else {
                                              print("retry");
                                            }
                                          }

                                         },

                                        elevation: 2.0,
                                        fillColor:tealaccent,
                                        child: Icon(
                                            Icons.done,
                                          size: 35.0,
                                        ),
                                        padding: EdgeInsets.all(15.0),
                                        shape: CircleBorder(),
                                      )),
                                  //   SizedBox(height: 50,),
                               ])) ]
                            )
                        )
                    )
                ))),
          issave?Container(
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

          if(alertbox)  Container(

              child: Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child:Container(
                      height: 50,
                      width: 40,
                      color: red,
                      child: Row(
                          children: <Widget>[
                            SizedBox(width: getDevicewidth(context, 0.02),),
                            Text("Invalid OTP",
                              style:TextStyle(color: white,fontFamily:'ProximaNova-Medium',fontSize: 16),),
                            new Flexible(
                                child: Align(alignment: Alignment.topRight,
                                    child: IconButton(
                                        icon: Icon(Icons.close_rounded,color: white,),
                                        onPressed: (){
                                          setState(() {
                                            alertbox=!alertbox;
                                          });
                                        }))),
                          ])))),
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
}




