import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/profile/profile.dart';
import 'package:carpooling/Screens/signin/signin.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class Changepassword extends StatefulWidget {
  @override
  _ChangepasswordState createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
 TextEditingController _confirmpassword = TextEditingController();
 TextEditingController _password = TextEditingController();
 FocusNode oldpassfield = FocusNode();
 FocusNode newpassfield= FocusNode();
 FocusNode cnewpassfield= FocusNode();
 bool showPassword = true;
 bool showPassword1 = true;
 bool showPassword2 = true;

bool alertbox=false;
  bool issave= false;
  String oldpassword,password,cpassword;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        resizeToAvoidBottomInset: true,
        body: Stack(
        children:[
        GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
                child: SingleChildScrollView(
                  child:Form(
                    key:formkey,
                    child: Container(
                        padding: EdgeInsets.only(top: 20,left: 0.2),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20,),
                              Align(alignment: Alignment.topLeft,
                                  child: IconButton(
                                    icon:Image(image:backarrowicon,
                                        width: 25,height: 26,color: black),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  )),

                         Container(
                           padding: EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                              SizedBox(height: 10,),
                              Text(changepassword,  style:TextStyle(fontFamily:'ProximaNova-Bold',fontSize: 22,color: black1)),
                              SizedBox(height: 10,),
                              Text(setuppassword,
                                  style: kSubtitlestyle),
                              SizedBox(height: 20,),
                              TextFormField(
                                focusNode: oldpassfield,
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
                                  labelText: opassword,
                                  labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),

                                ),
                                validator: validatechangepass,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value) {
                                    validatechangepass(value);
                                  },
                                  onFieldSubmitted: (value) {
                                    formkey.currentState.validate();
                                    if(validatechangepass(value)==null){
                                      FocusScope.of(context).requestFocus(newpassfield);
                                    } else {
                                      FocusScope.of(context).requestFocus(oldpassfield);
                                    }
                                  },
                                onSaved: (input) => oldpassword = input,
                              ),
                              SizedBox(height: 25,),
                              TextFormField(
                                focusNode: newpassfield,
                                controller: _password,
                                keyboardType: TextInputType.text,
                                obscureText: showPassword1,
                                decoration: InputDecoration(
                                  suffixIcon:
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword1 =
                                        !showPassword1;
                                      });
                                    },
                                    icon:showPassword1 ? Icon(Icons.visibility_off,color:Colors.black26,):Icon(Icons.visibility,color: grey,),

                                  ), enabledBorder: enableborder,
                                  focusedBorder: focusborder,
                                  border: enableborder,
                                  labelText: newpassword,
                                  labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),

                                ),
                                validator: validatechangepass,
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  validatechangepass(value);
                                },
                                onFieldSubmitted: (value) {
                                  formkey.currentState.validate();
                                  if(validatechangepass(value)==null){
                                    FocusScope.of(context).requestFocus(cnewpassfield);
                                  } else {
                                    FocusScope.of(context).requestFocus(newpassfield);
                                  }
                                },
                                onSaved: (input) => password = input,
                              ),
                              SizedBox(height: 10),
                              TextFormField(
                                focusNode: cnewpassfield,
                                 controller: _confirmpassword,
                                keyboardType: TextInputType.text,
                                obscureText: showPassword2,
                                decoration: InputDecoration(
                                  suffixIcon:
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showPassword2 =
                                        !showPassword2;
                                      });
                                    },
                                    icon:showPassword2 ? Icon(Icons.visibility_off,color:Colors.black26,):Icon(Icons.visibility,color: grey,),

                                  ),
                                  enabledBorder: enableborder,
                                  focusedBorder: focusborder,
                                  border: enableborder,
                                  labelText: confirmnewpassword,
                                  labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),

                                ),

                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  validatepass(value);
                                },
                                onFieldSubmitted: (value) {
                                  formkey.currentState.validate();
                                  if(validatepass(value)==null){
                                    FocusScope.of(context).unfocus();
                                  } else {
                                    FocusScope.of(context).requestFocus(cnewpassfield);
                                  }
                                },


                                validator: (String value) {
                                  if (value.isEmpty) {
                                   return reenterpassword;
                                  }
                                  if (_password.text != _confirmpassword.text){
                                    return passwordnotmatch;
                                  }

                                  return null;
                                },
                              ),

                              SizedBox(height: 20,),
                              Center(child:
                              Save())
                            ]))])))))),
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
                            top: 60,
                     left: 0,
                     right: 0,
                     child:Container(
              color: red,
              height: 50,
              child: Row(
                  children: <Widget>[
                    SizedBox(width: getDevicewidth(context, 0.02),),
                    Text("You have entered a wrong old password",
                      style:TextStyle(color: white,fontFamily:'ProximaNova-Medium',fontSize: 16),),
                   // SizedBox(width: getDevicewidth(context, 0.3)),
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
    );
  }

  Save() {
    return Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    color:lightgrey,
                    child: Text(cancel,style: TextStyle(fontSize:13,color: lightblack,fontFamily: 'ProximaNova-Medium'),),
                  ),
                  SizedBox(width: getDeviceheight(context, 0.05),),
                  FlatButton(
                    onPressed: () async {

                      if(validateAndSave()) {
                        print(oldpassword);
                        print(password);
                        Map data={
                          "oldPassword" : oldpassword,
                          "newPassword" : password,
                        };
                        setState(() => issave = true);
                        print(data);
                        final prefs = await SharedPreferences.getInstance();
                        final key = 'token';
                        final value = prefs.get(key ) ?? 0;
                        print(value);
                           var url=Uri.parse(BASE_URL+CHANGE_PASSWORD);
                        var response = await http.put(url, body:data,
                        headers: {
                          'Authorization': 'jwt $value'
                        });
                        print(response.body);
                        if(response.statusCode==200 || response.statusCode==201){
                          setState(() => issave = false);
                          print("successful");
                          print(response.body);
                          print(response.statusCode);
                            Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (
                                      context) =>
                                      Signin(
                                      )));
                        }else if(response.statusCode>200){
                          setState(() => issave = false);
                          print(response.statusCode);
                          setState(() {
                            alertbox=!alertbox;
                          });
                        }
                        else {
                          alertbox=!alertbox;
                        }
                      }

                    },
                    color: tealaccent,
                   padding: EdgeInsets.symmetric(horizontal: 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(save,style: TextStyle(fontSize:14,fontFamily: 'ProximaNova-Medium',color: black)),
                    ),
                ],
              )
            ])

    );
  }
 void alertsucc() {
   showDialog(
       context: context,
       builder: (context) {
         Future.delayed(Duration(seconds: 2), () {
           Navigator.of(context).pop(true);
         });
         return AlertDialog(
           backgroundColor: whitelight,
           title: Center(child: Text("password changed successfully",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
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


