import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/index.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/signin/signin.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Setpassword extends StatefulWidget {
  final String savemail,saveotp;
  const Setpassword({Key key,@required this.savemail,this.saveotp,}): super(key:key);
  @override
  _SetpasswordState createState() => _SetpasswordState();
}


class _SetpasswordState extends State<Setpassword> {
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _password = TextEditingController();
  String password,cpassword;
  final scafoldkey=GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool issave= false;
  bool showPassword = true;
  bool showPassword1 = true;
  bool alertbox=false;
  FocusNode cpasswordfield = FocusNode();
  FocusNode passwordfield= FocusNode();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){
          Navigator.pushNamed(
              context, '/signin');
        },
        child: Scaffold(
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
                                  key: formkey,
                                  child: Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(height: 30,),
                                            Align(alignment: Alignment.topLeft,
                                                child:IconButton(
                                                  icon: Image(image:backarrowicon,
                                                      width: 25,height: 26,color: black),
                                                  onPressed: () =>  Navigator.pushNamed(
                                                      context, '/signin'),

                                                )),

                                            SizedBox(height: 30,),
                                      Padding(padding: EdgeInsets.only(left: getDevicewidth(context, 0.05,),right:1 ),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(setpassword,style:kTitlestyle,),
                                            SizedBox(height: 10,),
                                            Text(enternewpassword,style: kSubtitlestyle),
                                            SizedBox(height: 20,),
                                            TextFormField(
                                              focusNode: passwordfield,
                                              controller: _password,
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
                                                labelText: newpassword,
                                                labelStyle: TextStyle(color:grey,fontFamily: 'ProximaNova-Regular',fontSize: 15),

                                              ),
                                              textInputAction: TextInputAction.done,
                                              onChanged: (value) {
                                                validatepass(value);
                                              },
                                              onFieldSubmitted: (value) {
                                                formkey.currentState.validate();
                                                if(validatepass(value)==null){
                                                  FocusScope.of(context).requestFocus(cpasswordfield);
                                                } else {
                                                  FocusScope.of(context).requestFocus(passwordfield);
                                                }
                                              } ,
                                              validator: validatepass,
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
                                                  FocusScope.of(context).requestFocus(cpasswordfield);
                                                }
                                              } ,
                                              onSaved: (input) => cpassword = input,

                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return reenterpassword;
                                                }
                                                if (_password.text !=_confirmpassword.text) {
                                                  return passwordnotmatch;

                                                }
                                                return null;
                                              },
                                            ),

                                            SizedBox(height: 30.0,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20)),
                                                  onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                Signin(
                                                                )));
                                                  },
                                                  color:lightgrey,
                                                  child: Text(cancel,style: TextStyle(color: lightblack,fontFamily: 'ProximaNova-Medium')),
                                                ),
                                                SizedBox(width: getDevicewidth(context, 0.05),),
                                                FlatButton(
                                                  onPressed: () async{
                                                    if(validateAndSave()) {
                                                      setState(() => issave = true);
                                                      print(password);
                                                      Map data={
                                                        "otpCode" : widget.saveotp,
                                                        "email": widget.savemail,
                                                        "password": password
                                                      };
                                                      print(data);

                                                      var url = Uri.parse(BASE_URL+RESET_PASSWORD);
                                                      var response = await http.post(url, body:data);
                                                      print(response.body);
                                                      if(response.statusCode==200 || response.statusCode==201){
                                                        print("successful");
                                                        print(response.body);
                                                        print(response.statusCode);
                                                        setState(() => issave = false);
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                                builder: (
                                                                    context) =>
                                                                    Signin(
                                                                    )));
                                                      }  else if(response.statusCode>200){
                                                        print(response.statusCode);
                                                        setState(() => issave = false);
                                                        setState(() {
                                                          alertbox=!alertbox;
                                                        });
                                                      }
                                                      else{
                                                        print(response.statusCode);
                                                      }
                                                    }
                                                  },
                                                  color:tealaccent,

                                                  padding: EdgeInsets.symmetric(horizontal: 60),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(20)),
                                                  child: Text(save),

                                                )
                                              ],
                                            )
                                            ]))
                                          ])))))),
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
                                    Text("Enter a Valid Password",
                                      style:TextStyle(color: white,fontFamily:'ProximaNova-Medium',fontSize: 16),),
                                    new Flexible(
                                        child:
                                        Align(alignment: Alignment.topLeft,
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

  void alertsucc() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            backgroundColor: whitelight,
            title: Center(child: Text("Reset Password successfully",style: TextStyle(fontSize: 17,fontFamily: 'ProximaNova-Bold',color: grey),)),
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
  void _showsnackbar() {
    final snackbar=SnackBar(content: Text("set password"),);
    scafoldkey.currentState.showSnackBar(snackbar);
    formkey.currentState.reset();
  }

}

