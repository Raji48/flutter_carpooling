


import 'dart:io';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Screens/register/otp.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}
class _RegisterState extends State<Register> {


  String name, email, phone, lname, password, cpassword;
  bool alertbox = false;
  bool issave = false;
  bool tryagain =false;
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  FocusNode firstnamefield = FocusNode();
  FocusNode lastnamefield = FocusNode();
  FocusNode phonefield = FocusNode();
  FocusNode emailfield = FocusNode();
  FocusNode passwordfield = FocusNode();
  FocusNode cpasswordfield = FocusNode();
  bool showPassword = true;
  bool showPassword1 = true;

  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool x=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body:
      Stack(
          children: [
            GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SafeArea(
                    child: SingleChildScrollView(
                        child: Form(
                            key: formkey,
                            child: Container(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      SizedBox(height: 10,),
                                      Align(alignment: Alignment.topLeft,
                                          child: IconButton(
                                           icon: Image(image:backarrowicon,
                                              width: 25,height: 26,color: black),

                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(),
                                          )),
                                 Container(
                                    padding: EdgeInsets.all(17),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                      SizedBox(height: 17,),
                                      Text(
                                        completeyourprofile, style:TextStyle(
                                            fontSize: 24,
                                            fontFamily: 'ProximaNova-Bold',)),
                                      SizedBox(height: 10,),
                                      Text(
                                        completeregister,
                                        style: kSubtitlestyle,),
                                      SizedBox(height: 20,),
                                      Center(
                                        child: Stack(children: [
                                          _imageFile == null ? Container(
                                              width: 120, height: 120,
                                              decoration: BoxDecoration(
                                                  color: lightgrey,
                                                  borderRadius: BorderRadius.all(Radius.circular(60.0))
                                              ),

                                              child: Center(
                                                child: Image(image: userpic, fit: BoxFit.scaleDown, width: 55, height: 55,),
                                              )
                                          ) :

                                         CircleAvatar(
                                            radius: 60.0,
                                            backgroundImage:
                                            FileImage(
                                                File(_imageFile.path)),
                                          ),

                                          Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: InkWell(
                                              onTap: () {
                                                showModalBottomSheet(
                                                  shape: topBorder,
                                                  context: context,
                                                  builder: ((builder) =>
                                                      Chooseprofilepic()),
                                                );
                                              },
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    width: 2,
                                                   color: greylight
                                                  ),
                                                  color:white,
                                                ),
                                                child: Icon(
                                                    Icons.camera_alt,
                                                    color: grey,
                                                    size: 23.0
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      TextButton.icon(
                                          icon: Image(image:isymbolicon,width: 20,height: 20,),
                                          label: Text(basicdetails,
                                              style:TextStyle(fontFamily: 'ProximaNova-Regular',color: black))),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        focusNode: firstnamefield,
                                        textCapitalization: TextCapitalization.sentences,
                                        inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z]+|\s")),],
                                        keyboardType: TextInputType.name,
                                        decoration: buildInputDecoration(
                                            firstname),
                                        validator: validatename,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          validatename(value);
                                        },
                                        onFieldSubmitted: (value) {
                                          formkey.currentState.validate();
                                          if (validatename(value) == null) {
                                            FocusScope.of(context).requestFocus(
                                                lastnamefield);
                                          } else {
                                            FocusScope.of(context).requestFocus(
                                                firstnamefield);
                                          }
                                        },

                                        onSaved: (input) => name = input,
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        focusNode: lastnamefield,
                                        textCapitalization: TextCapitalization.sentences,
                                        inputFormatters: [
                                          WhitelistingTextInputFormatter(
                                              RegExp(r"[a-zA-Z]+|\s")),
                                        ],
                                        decoration: buildInputDecoration(
                                            lastname),
                                        validator: validatelname,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          validatelname(value);
                                        },
                                        onFieldSubmitted: (value) {
                                          formkey.currentState.validate();
                                          if (validatelname(value) == null) {
                                            FocusScope.of(context).requestFocus(
                                                phonefield);
                                          } else {
                                            FocusScope.of(context).requestFocus(
                                                lastnamefield);
                                          }
                                        },
                                        onSaved: (input) => lname = input,
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        focusNode: phonefield,
                                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          enabledBorder: enableborder,
                                          focusedBorder: focusborder,
                                          border: enableborder,
                                          labelText: phonenumber,
                                          labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),
                                          counterText: "",
                                        ),
                                        validator: validatephone,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          validatephone(value);
                                        },
                                        onFieldSubmitted: (value) {
                                          formkey.currentState.validate();
                                          if (validatephone(value) == null) {
                                            FocusScope.of(context).requestFocus(
                                                emailfield);
                                          } else {
                                            FocusScope.of(context).requestFocus(
                                                phonefield);
                                          }
                                        },
                                        onSaved: (input) => phone = input,
                                      ),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        focusNode: emailfield,
                                        keyboardType: TextInputType
                                            .emailAddress,
                                        decoration: buildInputDecoration(
                                            workemail),
                                        validator: validateemail,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          validateemail(value);
                                        },
                                        onFieldSubmitted: (value) {
                                          formkey.currentState.validate();
                                          if (validateemail(value) == null) {
                                            FocusScope.of(context).requestFocus(
                                                passwordfield);
                                          } else {
                                            FocusScope.of(context).requestFocus(
                                                emailfield);
                                          }
                                        },
                                        onSaved: (input) => email = input,
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton.icon(
                                          icon:  Image(image:passwordicon,width: 20,height: 20,),
                                          label: Text(passworddetails,
                                              style:TextStyle(fontFamily: 'ProximaNova-Regular',color: black))),
                                      SizedBox(height: 10,),
                                      TextFormField(
                                        focusNode: passwordfield,
                                        obscureText: showPassword,
                                        controller: _password,
                                        keyboardType: TextInputType.text,
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
                                        validator: validatepass,
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          validatepass(value);
                                        },
                                        onFieldSubmitted: (value) {
                                          formkey.currentState.validate();
                                          if (validatepass(value) == null) {
                                            FocusScope.of(context).requestFocus(
                                                cpasswordfield);
                                          } else {
                                            FocusScope.of(context).requestFocus(
                                                passwordfield);
                                          }
                                        },
                                        onSaved: (input) => password = input,
                                      ),
                                      SizedBox(height: 10),
                                      TextFormField(
                                        focusNode: cpasswordfield,
                                        controller: _confirmpassword,
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

                                          ),
                                          enabledBorder: enableborder,
                                          focusedBorder: focusborder,
                                          border: enableborder,
                                          labelText: conpassword,
                                          labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),

                                        ),
                                        textInputAction: TextInputAction.done,
                                        onChanged: (value) {
                                          validatepass(value);
                                        },
                                        onFieldSubmitted: (value) {
                                          formkey.currentState.validate();
                                          if (validatepass(value) == null) {
                                            FocusScope.of(context).unfocus();
                                          } else {
                                            FocusScope.of(context).requestFocus(
                                                cpasswordfield);
                                          }
                                        },
                                        onSaved: (input) => cpassword = input,
                                        validator: (String value) {
                                          if (value.isEmpty) {
                                            return reenterpassword;
                                          }
                                          if (_password.text !=
                                              _confirmpassword.text) {
                                            return passwordnotmatch;
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20.0,),
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            ButtonTheme(
                                                height: getDeviceheight(context, 0.05) , //40,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20)),
                                              child: FlatButton(
                                                color: lightgrey,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(cancel,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color:  lightblack),),
                                              ),
                                            ),
                                            SizedBox(width: getDevicewidth(context, 0.05),),
                                            ButtonTheme(
                                              height: getDeviceheight(context, 0.05) ,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20)),
                                              child:
                                              FlatButton(
                                                  color: tealaccent,
                                                  onPressed: () async {

                                                    if (validateAndSave()) {
                                                      setState(() =>
                                                      issave = true);
                                                      print(name);
                                                      if (_imageFile != null) {
                                                        FormData data = new FormData
                                                            .fromMap({
                                                          "firstName": name,
                                                          "lastName": lname,
                                                          "phoneNumber": "+91" +
                                                              phone,
                                                          'email': email,
                                                          'password': password,
                                                          "profilePicture": _imageFile ==
                                                              null
                                                              ? ""
                                                              : await MultipartFile
                                                              .fromFile(
                                                              _imageFile.path)
                                                        });

                                                        try {
                                                        var url = BASE_URL +
                                                            REGISTER;
                                                        var response = await dio
                                                            .post(
                                                            url, data: data,
                                                            options: Options(
                                                                headers: {},
                                                                validateStatus: (
                                                                    status) {
                                                                  return status <
                                                                      500;
                                                                }
                                                            )
                                                        );

                                                        print("go");
                                                        print(response.data);
                                                        if (response
                                                            .statusCode ==
                                                            200 || response
                                                            .statusCode ==
                                                            201) {
                                                          setState(() =>
                                                          issave = false);
                                                          print("successful");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      Registerotp(
                                                                          registerphonenumber: phone)));
                                                        }
                                                        else if (response
                                                            .statusCode > 202) {
                                                          setState(() =>
                                                          issave = false);
                                                          // print(response.data);
                                                          setState(() {
                                                            alertbox = true;
                                                          });
                                                        }
                                                        else {
                                                          print("error");
                                                        }
                                                        }catch(e){
                                                       setState(() {
                                                        issave=false;

                                                        });
                                                       alert();
                                                     //  setState(() {
                                                       //  alertbox=!alertbox;
                                                      // });
                                                       throw Exception(e);
                                                     }
                                                      }else{
                                                        FormData data = new FormData
                                                            .fromMap({
                                                          "firstName": name,
                                                          "lastName": lname,
                                                          "phoneNumber": "+91" +
                                                              phone,
                                                          'email': email,
                                                          'password': password,
                                                        });
                                                      try {
                                                        var url = BASE_URL +
                                                            REGISTER;
                                                        var response = await dio
                                                            .post(
                                                            url, data: data,
                                                            options: Options(
                                                                headers: {},
                                                                validateStatus: (
                                                                    status) {
                                                                  return status <
                                                                      500;
                                                                }
                                                            )
                                                        );
                                                        /*Response response = await dio
                                                            .post(
                                                            'http://54.235.130.26:8002/api/auth/register',
                                                            data:data,
                                                        );*/ //formData);//options: Options(
                                                        print("go");
                                                        print(response.data);
                                                        if (response
                                                            .statusCode ==
                                                            200 || response
                                                            .statusCode ==
                                                            201) {
                                                          setState(() =>
                                                          issave = false);
                                                          print("successful");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (
                                                                      context) =>
                                                                      Registerotp(
                                                                          registerphonenumber: phone)));
                                                        }
                                                        else if (response
                                                            .statusCode > 202) {
                                                          setState(() =>
                                                          issave = false);
                                                          setState(() {
                                                            alertbox = true;
                                                          });
                                                        }
                                                        else {
                                                          print("error");
                                                        }
                                                      }catch(e){
                                                        alert();
                                                        setState(() {
                                                          issave=false;
                                                        });
                                                      }
                                                      }

                                                    }
                                                  },

                                                  child: Text(submitproceed,style:TextStyle(fontSize: 14,fontFamily: 'ProximaNova-Medium',color: black))
                                              ),
                                            ),
                                          ])
                                    ]
                                )
                            )]))
                            )))
            ),
            issave ? Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                color: Colors.black26,
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: CircularProgressIndicator(),
                    )
                )
            ) : Container(),
            SizedBox(height: 50,),
            if(alertbox) Container(
                child: Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: 50,
                        width: 40,
                        color: red,
                        child: Row(
                            children: <Widget>[
                              SizedBox(width: getDevicewidth(context, 0.02),),
                              Text("This Account is Already Registered",
                                style: TextStyle(color: white,
                                    fontFamily: 'ProximaNova-Medium',
                                    fontSize: 16),),

                              new Flexible(child:
                              Align(alignment: Alignment.topRight,
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.close_rounded, color: white,),
                                      onPressed: () {
                                        setState(() {
                                          alertbox = !alertbox;
                                        });
                                      }))),
                            ])
                    ))),

          ]),
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

  void alertsucc() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: whitelight,
            title: Center(child: Text("OTP send to your SMS successfully",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
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

  Chooseprofilepic() {
    return Container(
        height: 100.0,
        width: MediaQuery
            .of(context)
            .size
            .width,
        margin: EdgeInsets.symmetric(
          horizontal: 20, vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Container(
                decoration: BoxDecoration(
                  color: whiteyellow,
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)),
                ),
                child: FlatButton(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                    Navigator.pop(context);

                  },
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Icon(Icons.camera_alt, size: 35, color: grey,),
                        //new IconButton(icon:new Image(image:cameraicon),),
                        SizedBox(height: 10,),
                        Text(camera),
                      ]),
                )),
            Container(
                decoration: BoxDecoration(
                  color: whiteyellow,
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)),
                ),
                child: FlatButton(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                    Navigator.pop(context);

                  },
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 15,),
                        new IconButton(icon: new Image(image: galleryicon),),
                        //,size: 35,color: grey,),
                        SizedBox(height: 4,),
                        Text(gallery),
                      ]),
                )),
            _imageFile != null ? Container(
                decoration: BoxDecoration(
                  color: whiteyellow,
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)),
                ),
                child: FlatButton(
                    onPressed: () {
                    setState(() {
                         _imageFile=null;
                       });
                       Navigator.pop(context);
                    },
                    child: Column(
                        children: <Widget>[
                          SizedBox(height: 20,),
                          Icon(Icons.do_disturb_on_rounded, size: 35,
                            color: grey,),
                          SizedBox(height: 10,),
                          Text(remove,),
                        ]))):Container(),
          ],
        )
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source,);
    setState(() {
      _imageFile = pickedFile;
      x=false;
    });

  }
}


