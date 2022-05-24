import 'dart:async';
import 'dart:convert';

import 'package:carpooling/Actions/verifynum_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/verifyphonenumber/verifynumber_model.dart';
import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/role_select/role_select.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Registerotp extends StatefulWidget {
  final String registerphonenumber;
  const Registerotp({Key key,@required this.registerphonenumber,}): super(key:key);
  @override
  _RegisterotpState createState() => _RegisterotpState();
}

class _RegisterotpState extends State<Registerotp> {
  var status ;
  var token ;
 bool x=false;
  bool issave= false;
  bool alertbox =false;
 // var dio=new Dio();
  StreamController<ErrorAnimationType> errorController;
  var _controller = TextEditingController();
  String firstdigit,seconddigit,thirddigit,fourthdigit,fifthdigit,sixthdigit;
  GlobalKey<FormState> formkey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){
          Navigator.pushNamed(
              context, '/registerotp');
        },

    child: Scaffold(
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
                                              icon: Image(image:backarrowicon,
                                                  width: 25,height: 26,color: black),
                                              onPressed: () => Navigator.of(context).pop(),
                                            )),
                                        SizedBox(width: 30,),
                                        if(x) Container(
                                           //height:35,
                                          //  width: 100,
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
                                  Text(otpverification,style: kTitlestyle,textAlign: TextAlign.start,),
                                  SizedBox(height: 10,),
                                  Text(sendotp,style:kSubtitlestyle,textAlign: TextAlign.start,),
                                  SizedBox(height: 25),
                                  PinCodeTextField(
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    appContext: context,
                                    length: 6,
                                    obscureText: false,
                                    // obscuringCharacter: '*',
                                    // blinkWhenObscuring: true,
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
                                            "phoneNumber":"+91"+widget.registerphonenumber,
                                          };
                                          print(body);
                                          var url=Uri.parse(BASE_URL+RESEND_OTP);
                                          var response = await http
                                              .put(
                                             url,
                                              body: body);
                                          print("success");
                                          print(response.body);
                                          print(response.statusCode);
                                          if(response.statusCode==200 || response.statusCode==201){
                                            print(response.statusCode);


                                          }else{
                                            print("Retry");
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
                                              alertbox=true;
                                            });

                                          }
                                          else if(_controller.text.length==6) {
                                            setState(() => issave = true);
                                            Map data = {
                                              "phoneNumber": "+91" +
                                                  widget.registerphonenumber,
                                              "otpCode": _controller.text
                                            };
                                            print(data);
                                             try {
                                            var url=Uri.parse(BASE_URL+VERIFY_PHONE_NUMBER);
                                            var response = await http
                                                .put(
                                                url,
                                                body: data);
                                            print("success");
                                            print(response.body);
                                            print(response.statusCode);
                                            if (response.statusCode == 200 ||
                                                response.statusCode == 201) {
                                              setState(() => issave = false);
                                              setState(() {
                                                x = !x;
                                              });

                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Role()));
                                              var status = response.body
                                                  .contains('error');
                                              var data = json.decode(
                                                  response.body);
                                              if (status) {
                                                print(
                                                    'data : ${data["error"]}');
                                              } else {
                                                print(
                                                    'data : ${data["token"]}');
                                                _save(data["token"]);
                                                accesstoken= data["token"];
                                                print("acessstoken"+accesstoken);
                                              }
                                              print(response.statusCode);
                                              token = response.body;
                                            }
                                            if (response.statusCode >
                                                202) {
                                              setState(() => issave = false);
                                              print(response.body);
                                              setState(() {
                                                alertbox = true;
                                              });
                                            }
                                            else {
                                              setState(() => issave = false);
                                              print("retry");
                                            }
                                          }catch(e){
                                               print("catch");
                                               setState(() => issave = false);
                                             }

                                           }else{
                                            setState(() => issave = false);
                                          }

                                        },
                                        elevation: 2.0,
                                        fillColor:tealaccent,
                                        child: Icon(
                                            Icons.arrow_forward
                                        ),
                                        padding: EdgeInsets.all(15.0),
                                        shape: CircleBorder(),
                                      )),
                                  //   SizedBox(height: 50,),
                              ]))
                                ]
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

                color: red,
              padding: EdgeInsets.only(top: getDeviceheight(context,0.01)),
              child: Row(
                  children: <Widget>[
                    SizedBox(width: getDevicewidth(context, 0.02),),
                    Text("Invalid OTP",
                      style:TextStyle(color: white,fontFamily:'ProximaNova-Regular',fontSize: 16),),
                    new Flexible(child:
                    Align(alignment: Alignment.topRight,
                        child: IconButton(
                            icon: Icon(Icons.close_rounded,color: white,),
                            onPressed: (){
                              setState(() {
                                alertbox=!alertbox;
                              });
                            }))),
                  ])))),
    ])
    ));
  }

  bool validateAndSave() {

    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    prefs.setString(key, value);
    print(value);
  }
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }
}



class VerifynumberProps{
  final bool loading;
  final dynamic error;
  final Verifynumber success;
  final Function verifyapi;


  VerifynumberProps({
    this.loading,
    this.error,
    this.success,
    this.verifyapi,

  });

}
VerifynumberProps mapStateToProps(Store<AppState> store) {
  return VerifynumberProps(
    loading: store.state.login.loading,
    error: store.state.login.error,
    success: store.state.verifynum.success,
    verifyapi: (data) => store.dispatch(verifynum(data)),

  );
}


