import 'dart:async';

import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/signin/forgetpassword/setpassword.dart';
import 'package:carpooling/Services/Apicontroller.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:pin_code_fields/pin_code_fields.dart';


class Passwordotp extends StatefulWidget {
  final String savemail;
  const Passwordotp({Key key,@required this.savemail,}): super(key:key);
  @override
  _PasswordotpState createState() => _PasswordotpState();
}

class _PasswordotpState extends State<Passwordotp> {
  String firstdigit,seconddigit,thirddigit,fourthdigit,fifthdigit,sixthdigit;
  GlobalKey<FormState> formkey =GlobalKey<FormState>();
  bool issave= false;
  bool alertbox=false;
  bool valid =false;
  bool x=false;
  String currentText = "";
  StreamController<ErrorAnimationType> errorController;
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){
          Navigator.pushNamed(
              context, '/signin');
        },
    child:Scaffold(
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
    Align(alignment: Alignment.topLeft,
    child:IconButton(
    icon:Image(image:backarrowicon,
        width: 25,height: 26,color: black),
    onPressed: () =>  Navigator.pushNamed(
        context, '/signin'),

    )),
    SizedBox(height: 30,),
        Padding(
        padding: EdgeInsets.only(left: getDevicewidth(context, 0.05)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
    Text(enterotp,style: kTitlestyle,textAlign: TextAlign.start,),
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
            activeColor:green,
            selectedColor:green
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        errorAnimationController: errorController,
        controller: _controller,
        keyboardType: TextInputType.number,

        onCompleted: (value) {

        },
        onSubmitted: (text) {

        },
        onChanged: (text)  {
          print(text);

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
        child: FlatButton(
          onPressed: ()  {

            Map data = {
              "email": widget.savemail,
            };
            print(data);
            postmethod(FORGET_PASSWORD, data);
          },
          color:lightgrey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          child: Text(resend),
         )),
      SizedBox(height: 50,),
      Center(
      child:

       RawMaterialButton(
      onPressed: () async {

        print(_controller.text.length);

         if(_controller.text.length<6){
           setState(() {
             alertbox=!alertbox;
           });
         }
         else if(_controller.text.length==6){
           setState(() => issave =true);
          var savemail = widget.savemail;
          print(savemail);
          Map data = {
            'email':savemail ,
            'otpCode':_controller.text
          };
          print(data);
           var url = Uri.parse(BASE_URL+VERIFY_RESETPASSOTP);
          var response = await http.put(url,
              body: data);
          print(response.body);
          if (response.statusCode == 200 ||
              response.statusCode == 201) {
            setState(() => issave =false);
            print("successful");
            print(response.body);
            print(response.statusCode);
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                Setpassword(
                  savemail: savemail, //widget.savemail,
                  saveotp: _controller.text,
                )));
          } else if(response.statusCode>202){
            setState(() => issave = false);
            print(response.statusCode);
            setState(() {
              alertbox=!alertbox;
            });
          }

         /*Navigator.push(context, MaterialPageRoute(builder: (context) =>
              Setpassword(
                savemail: savemail, //widget.savemail,
                saveotp: _controller.text,
              )));*/
      }},
        elevation: 2.0,
        fillColor:tealaccent,
        child: Icon(
          Icons.arrow_forward,
          size: 35.0,
        ),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
      ),
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
  }


