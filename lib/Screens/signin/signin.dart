
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carpooling/Actions/login_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/login/login_model.dart';
import 'package:carpooling/Model/slide.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/role_select/role_select.dart';
import 'package:carpooling/Screens/signin/forgetpassword/mail.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:carpooling/Widgets/slide_item.dart';
import 'package:carpooling/Widgets/slide_dots.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

class Signin extends StatefulWidget {

  _SigninState createState() => _SigninState();
}
class _SigninState extends State<Signin> {
  TextEditingController controlpasswordfield = TextEditingController();
  FocusNode emailfield = FocusNode();
  FocusNode passwordfield= FocusNode();
  String smail, spass;
  bool issave= false;
  bool alertbox =false;
  bool alertmsg =false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  bool showPassword = true;


  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds:2), (Timer timer) {
      if (_currentPage < 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }


  @override
  Widget build(BuildContext context) {

          return WillPopScope(
            onWillPop:(){
              exit(0);
            },

            child:
            Scaffold(
            backgroundColor: white,
            resizeToAvoidBottomInset: true,
            body:
                Stack(
              children:[
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                    child: Form(
                        key: formkey,
                        child: Container(
                          width: double.infinity,
                          child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(25.0),
                                      bottomRight: Radius.circular(25.0)),
                                  child: Container(
                                      height: 320,
                                      width: double.infinity,
                                      color:tealaccent4,
                                      child: Center(
                                        child: Stack(
                                          alignment: AlignmentDirectional
                                              .bottomCenter,
                                          children: <Widget>[
                                            PageView.builder(
                                              scrollDirection: Axis
                                                  .horizontal,
                                              controller: _pageController,
                                              onPageChanged: _onPageChanged,
                                              itemCount: slideList.length,
                                              itemBuilder: (ctx, i) =>
                                                  SlideItem(i),
                                            ),
                                            Stack(
                                              alignment: AlignmentDirectional
                                                  .topStart,
                                              children: <Widget>[
                                                Container(
                                                  margin: const EdgeInsets
                                                      .only(
                                                      bottom: 5),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: <Widget>[
                                                      for(int i = 0; i <
                                                          slideList
                                                              .length; i++)
                                                        if( i ==
                                                            _currentPage )
                                                          SlideDots(true)
                                                        else
                                                          SlideDots(false)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ),


                                SizedBox(
                                  height: getDeviceheight(context, 0.01),
                                ),
                                Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox( height: getDeviceheight(context, 0.01),),
                                            TextFormField(
                                              focusNode: emailfield,
                                              keyboardType: TextInputType.emailAddress,
                                              onSaved: (input) =>
                                              smail = input,
                                              decoration: buildInputDecoration(
                                                  workemail),
                                              validator: validateemail,
                                              textInputAction: TextInputAction.done,
                                              onChanged: (value) {
                                                validateemail(value);
                                                },
                                              onFieldSubmitted: (value) {
                                                formkey.currentState.validate();
                                              if(validateemail(value)==null){
                                               FocusScope.of(context).requestFocus(passwordfield);
                                                } else {
                                                  FocusScope.of(context).requestFocus(emailfield);
                                                }
                                              }

                                            ),
                                            SizedBox( height: getDeviceheight(context, 0.01),),
                                            TextFormField(
                                              //controller: widget.
                                              focusNode: passwordfield,
                                              keyboardType: TextInputType.text,
                                              obscureText: showPassword,
                                              decoration: InputDecoration(
                                                suffixIcon:
                                                IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      showPassword =
                                                      !showPassword;
                                                    });
                                                  },
                                                  icon:showPassword ? Icon(Icons.visibility_off,color:Colors.black26,):Icon(Icons.visibility,color: grey,),

                                                ),
                                                enabledBorder: enableborder,
                                                focusedBorder: focusborder,
                                                border: enableborder,
                                                labelText: pasword,
                                                labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),

                                              ),
                                              textInputAction: TextInputAction.done,
                                              onChanged: (value) {
                                                validatepasss(value);
                                              },
                                              onFieldSubmitted: (value) {
                                                formkey.currentState.validate();
                                                if(validatepasss(value)==null){
                                                  FocusScope.of(context).unfocus();
                                                } else {
                                                  FocusScope.of(context).requestFocus(passwordfield);
                                                }
                                              } ,
                                              validator: validatepasss,
                                              onSaved: (input) =>
                                              spass = input,
                                            ),

                                            SizedBox( height: getDeviceheight(context, 0.02),),
                                            ButtonTheme(
                                              minWidth: 400,
                                              height:40,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20)),
                                              child:
                                              FlatButton(
                                                color: tealaccent,
                                                onPressed: () async {
                                                  if (validateAndSave()) {
                                                    var connectivityResult = await (Connectivity().checkConnectivity());
                                                    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
                                                    setState(() => issave = true);
                                                    print(smail);
                                                    print(spass);
                                                    Map data = {
                                                      "email": smail,
                                                     "password": spass
                                                    };
                                                    print(data);
                                                    try {
                                                            var url = Uri.parse(BASE_URL + LOGIN);
                                                            final response = await http
                                                                .post(url,
                                                                body: data);
                                                            if (response
                                                                .statusCode ==
                                                                200 ||
                                                                response
                                                                    .statusCode ==
                                                                    201) {
                                                              setState(() =>
                                                              issave = false);
                                                              print(
                                                                  "successful");
                                                              print(response
                                                                  .body);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (
                                                                          context) =>
                                                                          Role()));
                                                              var status = response.body.contains('error');
                                                              var data = json.decode(response.body);
                                                              if (status) {
                                                                print(
                                                                    'data : ${data["error"]}');
                                                              } else {
                                                                print(
                                                                    'data : ${data["token"]}');
                                                                _save(
                                                                    data["token"]);
                                                                accesstoken =
                                                                data["token"];
                                                                print(
                                                                    "acessstoken" +
                                                                        accesstoken);
                                                              }
                                                            }else if(response.statusCode==404){
                                                              setState(() =>
                                                              issave = false);
                                                              print(response
                                                                  .body);
                                                              print("alert");
                                                              setState(() {
                                                                alertbox =
                                                                !alertbox;
                                                              });

                                                            }else if(response.statusCode==400||response.statusCode==401){
                                                              setState(() =>
                                                              issave = false);
                                                              print(response
                                                                  .body);
                                                              print("alert");
                                                              setState(() {
                                                                alertmsg =
                                                                !alertmsg;
                                                              });

                                                            }
                                                            else{
                                                              setState(() =>
                                                              issave = false);
                                                              print(response
                                                                  .body);
                                                              print("else");
                                                              setState(() {
                                                                alertbox =
                                                                !alertbox;
                                                              });
                                                            }
                                                          } catch(e) {
                                                           setState(() =>
                                                            issave = false);
                                                           alert("Please Try Again");
                                                           print("catch");
                                                    }
                                                  }else {
                                                      alert("No internet connection");
                                                      print("No internet");
                                                    }

                                                }},

                                                child: Text(signin),
                                              ),
                                            ),
                                            FlatButton(
                                                onPressed: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Forgetpassword()));
                                                },
                                                child: Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    children: <Widget>[
                                                      Text(
                                                        forgotpassword,
                                                        style: kSubtitlestyle,
                                                      ),
                                                    ]
                                                )
                                            ),
                                            SizedBox( height: getDeviceheight(context, 0.02),),
                                            Text(
                                              newuser, style: kSubtitlestyle,
                                              textAlign: TextAlign.center,),
                                            SizedBox( height: getDeviceheight(context, 0.01),),
                                            ButtonTheme(
                                              minWidth: 400,
                                              height: 40,//getDeviceheight(context, 0.052),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20)),
                                              child: OutlineButton(
                                                focusColor: lightgrey,
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, '/register');

                                                },
                                                child: Text(registernow),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                )
                              ]
                          ),
                          //  ),
                        )))),
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
                    padding: EdgeInsets.all(6),
                    child: Row(
                        children: <Widget>[
                          SizedBox(width: getDevicewidth(context, 0.02),),
                         Text("User not found",//"You have entered invalid credentials",
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
                if(alertmsg)  Container(
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
                                  Text("Password mismatch",
                                    style:TextStyle(color: white,fontFamily:'ProximaNova-Medium',fontSize: 16),),
                                  new Flexible(
                                      child: Align(alignment: Alignment.topRight,
                                          child: IconButton(
                                              icon: Icon(Icons.close_rounded,color: white,),
                                              onPressed: (){
                                                setState(() {
                                                  alertmsg=!alertmsg;
                                                });
                                              }))),
                                ])))),
                ]

                ),
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

  void alert(String s) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: whitelight,
            title: Center(child: Text(s,style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
          );
        });
  }
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





class LoginScreenProps {
  final bool loading;
  final dynamic error;
  final Loginmodel success;
  final Function loginapi;


  LoginScreenProps({
    this.loading,
    this.error,
    this.success,
    this.loginapi,

  });

}
  LoginScreenProps mapStateToProps(Store<AppState> store) {
    return LoginScreenProps(
      loading: store.state.login.loading,
      error: store.state.login.error,
      success: store.state.login.success,
      loginapi: (data) => store.dispatch(login(data)),

    );
  }

