

import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/signin/forgetpassword/otp.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Forgetpassword extends StatefulWidget {
  @override
  _ForgetpasswordState createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  GlobalKey<FormState> formkey =GlobalKey<FormState>();
  String mail;
  bool issave= false;
  bool alertbox=false;
  FocusNode emailfield = FocusNode();
  bool alertsucc=false;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
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
    //height: MediaQuery.of(context).size.height,

    padding: EdgeInsets.all(10),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20,),
       Align(alignment: Alignment.topLeft,
        child:IconButton(
          icon: Image(image:backarrowicon,
              width: 25,height: 26,color: black),
          onPressed: () =>
          Navigator.pushNamed(
              context, '/signin'),
        )),

      SizedBox(height: 30,),
      Padding(padding:EdgeInsets.only(left: getDevicewidth(context, 0.05)),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
      Text(enterworkemail,style:kTitlestyle ,textAlign: TextAlign.start,),
        SizedBox(height: 10,),
        Text(sendyouotp,style: kSubtitlestyle),
         SizedBox(height: 50,),
        TextFormField(
          focusNode: emailfield,
          keyboardType: TextInputType.emailAddress,
          decoration: buildInputDecoration(workemail),
          validator:validateemail,
            textInputAction: TextInputAction.done,
            onChanged: (value) {
              validateemail(value);
            },
            onFieldSubmitted: (value) {
              formkey.currentState.validate();
              if(validateemail(value)==null){
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).requestFocus(emailfield);
              }
            },
          onSaved: (i)=>mail=(i),
        ),
        SizedBox(height: 50,),
        Center(
        child:
        RawMaterialButton(
          onPressed: () async {
                    if(validateAndSave()) {
                      setState(() => issave = true);
                      Map data = {
                        "email": mail,
                      };
                      print(data);
                      var url = Uri.parse(BASE_URL+FORGET_PASSWORD);
                      try{
                      var response = await http.post(
                         url,
                          body: data);
                      print(response.body);
                      if (response.statusCode == 200 ||
                          response.statusCode == 201) {
                        setState(() => issave =false);
                        Navigator.push(
                           context, MaterialPageRoute(builder: (context) =>
                            Passwordotp(
                              savemail: mail,
                            )));
                      } else if(response.statusCode>200){
                        setState(() => issave = false);
                        print(response.statusCode);
                        setState(() {
                          alertbox=!alertbox;
                        });
                      }
                      else {
                        setState(() => issave = false);
                        print(response.statusCode);
                      }
                    }catch(e){
                        setState(() => issave = false);
                        alert();
                      }

    }

          },
          elevation: 2.0,
         fillColor: tealaccent,
          child: Icon(
            Icons.arrow_forward,
            size: 35.0,
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
          ) ),
                ]))
        ]
    )))))
      ),
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
                      Text("Email doesn't exist",
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
            alertsucc?Container(
                width:MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black26,
                child:Align(
                    alignment: Alignment.center,
                    child:Container(
                            child: Text("Please Try Again",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
                    )

            ):Container(),


          ])
    );
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

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
