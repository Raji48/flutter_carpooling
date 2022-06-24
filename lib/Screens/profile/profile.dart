import 'dart:io';
import 'package:carpooling/Actions/profile_action.dart';
import 'package:carpooling/Model/app_state.dart';
import 'package:carpooling/Model/profiledetail/profiledetail_model.dart';
import 'package:carpooling/Res/colors.dart';
import 'package:carpooling/Res/images.dart';
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Screens/profile/changephonenumber.dart';
import 'package:carpooling/Services/Apicontroller.dart';
import 'package:carpooling/Services/index.dart';
import 'package:carpooling/Utilis/devicesize.dart';
import 'package:carpooling/Utilis/function.dart';
import 'package:carpooling/Utilis/style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:redux/redux.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String ephonenum, ename, elname;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool issave = false;
  bool alertbox = false;
  bool validnumber = false;
  bool numberexit = false;
  bool gosave = false;
  bool x = false;
  bool removeimg = false;
  bool img = true;
  bool change = false;
  File _displayImage;

  void handleInitialBuild(ProfileProps props) {
    props.profileapi();
    _download();
  }

  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileProps>(
        converter: (store) => mapStateToProps(store),
        onInitialBuild: (props) => this.handleInitialBuild(props),
        builder: (context, props) {
          Widget body;
          if (props.loading) {
            print("loding");
            body = Center(
              child: CircularProgressIndicator(),
            );
          } else if (props.userdata != null) {
            userid = props.userdata.user.id.toString();
            username = props.userdata.user.firstName.toString() + "\t" +
                props.userdata.user.lastName.toString();
            print(userid);
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
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                  child: Stack(children: [
                                CircleAvatar(
                                  backgroundColor: greylight,
                                  radius: 60.0,
                                  child: ClipOval(
                                      child: _displayImage != null
                                          ? Image.file(_displayImage)
                                          : Image(
                                              image: NetworkImage(
                                                  "https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg"),
                                            )),
                                )
                              ])),
                              SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: RawMaterialButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: topBorder,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return StatefulBuilder(
                                              builder: (BuildContext context,
                                                      StateSetter
                                                          setModalState) =>
                                                  SafeArea(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    child: SingleChildScrollView(
                                                        child: Form(
                                                            key: formkey,
                                                            child: Container(
                                                                child: Stack(children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  FocusScope.of(context).unfocus();
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                10),
                                                                        child: Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              SizedBox(
                                                                                height: 15,
                                                                              ),
                                                                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                                                                                Align(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: Text(
                                                                                      editprofile,
                                                                                      style: kTitlestyle,
                                                                                    )),
                                                                                Align(
                                                                                    alignment: Alignment.topRight,
                                                                                    child: ButtonTheme(
                                                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                                                      child: FlatButton(
                                                                                        color: tealaccent,
                                                                                        onPressed: () async {
                                                                                          if (validateAndSave()) {
                                                                                            setModalState(() {
                                                                                              issave = true;
                                                                                            });
                                                                                            print(ename);
                                                                                            print(ephonenum);
                                                                                            if (ephonenum.length != 13) {
                                                                                              print("invalid");
                                                                                              setModalState(() {
                                                                                                ephonenum = "+91" + ephonenum;
                                                                                                print(ephonenum);
                                                                                              });
                                                                                            }

                                                                                            if (removeimg == false) {
                                                                                              // if(_displayImage !=null){
                                                                                              FormData data = new FormData.fromMap({
                                                                                                "firstName": ename,
                                                                                                "lastName": elname,
                                                                                                "profilePicture": _imageFile == null ? "" : await MultipartFile.fromFile(_imageFile.path)
                                                                                              });

                                                                                              print(body);
                                                                                              final prefs = await SharedPreferences.getInstance();
                                                                                              final key = 'token';
                                                                                              final value = prefs.get(key) ?? 0;
                                                                                              print(value);
                                                                                              try {
                                                                                                var url = BASE_URL + PROFILE_DETAILS;
                                                                                                if (props.userdata.user.phoneNumber != ephonenum) {
                                                                                                  setModalState(() {
                                                                                                    validnumber = true;
                                                                                                  });
                                                                                                  setModalState(() {
                                                                                                    issave = false;
                                                                                                  });
                                                                                                } else {
                                                                                                  var response = await dio.put(url,
                                                                                                      data: data,
                                                                                                      options: Options(
                                                                                                          headers: {'Authorization': 'jwt $value'},
                                                                                                          validateStatus: (status) {
                                                                                                            return status < 500;
                                                                                                          }));
                                                                                                  print(response.data);
                                                                                                  if (response.statusCode == 200 || response.statusCode == 201) {
                                                                                                    setModalState(() {
                                                                                                      issave = false;
                                                                                                    });
                                                                                                    props.profileapi();
                                                                                                    _download();

                                                                                                    print(response.data);
                                                                                                    print(response.statusCode);
                                                                                                    Navigator.pop(context);

                                                                                                    updatealert();
                                                                                                  } else if (response.statusCode > 200) {
                                                                                                    setModalState(() {
                                                                                                      issave = false;
                                                                                                    });
                                                                                                    print(response.statusCode);
                                                                                                    setModalState(() {
                                                                                                      alertbox = true;
                                                                                                    });
                                                                                                  } else {
                                                                                                    setModalState(() {
                                                                                                      issave = false;
                                                                                                    });
                                                                                                  }
                                                                                                }
                                                                                              } catch (e) {
                                                                                                alert();
                                                                                                setModalState(() {
                                                                                                  issave = false;
                                                                                                });
                                                                                              }
                                                                                            } else if (removeimg == true) {
                                                                                              FormData data = new FormData.fromMap({
                                                                                                "firstName": ename,
                                                                                                "lastName": elname,
                                                                                                "profilePicture": "",
                                                                                              });

                                                                                              print(body);
                                                                                              final prefs = await SharedPreferences.getInstance();
                                                                                              final key = 'token';
                                                                                              final value = prefs.get(key) ?? 0;
                                                                                              print(value);
                                                                                              try {
                                                                                                var url = BASE_URL + PROFILE_DETAILS;
                                                                                                if (props.userdata.user.phoneNumber != ephonenum) {
                                                                                                  setModalState(() {
                                                                                                    validnumber = true;
                                                                                                  });
                                                                                                  setModalState(() {
                                                                                                    issave = false;
                                                                                                  });
                                                                                                } else {
                                                                                                  var response = await dio.put(url,
                                                                                                      data: data,
                                                                                                      options: Options(
                                                                                                          headers: {'Authorization': 'jwt $value'},
                                                                                                          validateStatus: (status) {
                                                                                                            return status < 500;
                                                                                                          }));
                                                                                                  print(response.data);
                                                                                                  if (response.statusCode == 200 || response.statusCode == 201) {
                                                                                                    setModalState(() {
                                                                                                      issave = false;
                                                                                                    });
                                                                                                    props.profileapi();
                                                                                                    _download();

                                                                                                    print(response.data);
                                                                                                    print(response.statusCode);
                                                                                                    Navigator.pop(context);

                                                                                                    updatealert();
                                                                                                  } else if (response.statusCode > 200) {
                                                                                                    setModalState(() {
                                                                                                      issave = false;
                                                                                                    });
                                                                                                    print(response.statusCode);
                                                                                                    setModalState(() {
                                                                                                      alertbox = true;
                                                                                                    });
                                                                                                  }
                                                                                                }
                                                                                              } catch (e) {
                                                                                                alert();
                                                                                                print(e);
                                                                                                setModalState(() {
                                                                                                  issave = false;
                                                                                                });
                                                                                              }
                                                                                            }
                                                                                          }
                                                                                        },
                                                                                        child: Text(save),
                                                                                      ),
                                                                                    )),
                                                                              ]),
                                                                              Text(
                                                                                edityourprofile,
                                                                                style: kSubtitlestyle,
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10,
                                                                              ),
                                                                              Center(
                                                                                child: Stack(
                                                                                  children: [
                                                                                    _imageFile == null
                                                                                        ? CircleAvatar(
                                                                                            radius: 60.0,
                                                                                            child: ClipOval(
                                                                                                child: _displayImage != null
                                                                                                    ? Image.file(_displayImage)
                                                                                                    : Image(
                                                                                                        image: NetworkImage("https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg"),
                                                                                                      )))
                                                                                        : CircleAvatar(radius: 60.0, backgroundImage: FileImage(File(_imageFile.path))),
                                                                                    Positioned(
                                                                                      bottom: 0,
                                                                                      right: 0,
                                                                                      child: InkWell(
                                                                                        onTap: () {
                                                                                          showModalBottomSheet(
                                                                                              shape: topBorder,
                                                                                              context: context,
                                                                                              builder: ((builder) => Container(
                                                                                                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                                    child: Container(
                                                                                                        height: 100, //getDeviceheight(context, 0.13),
                                                                                                        width: MediaQuery.of(context).size.width,
                                                                                                        margin: EdgeInsets.symmetric(
                                                                                                          horizontal: 20,
                                                                                                          vertical: 20,
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
                                                                                                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                                                                ),
                                                                                                                child: FlatButton(
                                                                                                                  onPressed: () async {
                                                                                                                    final pickedFile = await _picker.getImage(source: ImageSource.camera);
                                                                                                                    setModalState(() {
                                                                                                                      removeimg = false;
                                                                                                                      _imageFile = pickedFile;
                                                                                                                      _displayImage != null;
                                                                                                                      change = true;
                                                                                                                    });

                                                                                                                    Navigator.pop(context);
                                                                                                                  },
                                                                                                                  child: Column(children: <Widget>[
                                                                                                                    SizedBox(
                                                                                                                      height: 20,
                                                                                                                    ),
                                                                                                                    Icon(
                                                                                                                      Icons.camera_alt,
                                                                                                                      size: 35,
                                                                                                                      color: grey,
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 10,
                                                                                                                    ),
                                                                                                                    Text(camera),
                                                                                                                  ]),
                                                                                                                )), //),
                                                                                                            Container(
                                                                                                                decoration: BoxDecoration(
                                                                                                                  color: whiteyellow,
                                                                                                                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                                                                ),
                                                                                                                child: FlatButton(
                                                                                                                  onPressed: () async {
                                                                                                                    // takePhoto(ImageSource.gallery);
                                                                                                                    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
                                                                                                                    setModalState(() {
                                                                                                                      removeimg = false;
                                                                                                                      _imageFile = pickedFile;
                                                                                                                      _displayImage != null;
                                                                                                                    });
                                                                                                                    Navigator.pop(context);
                                                                                                                  },
                                                                                                                  child: Column(children: <Widget>[
                                                                                                                    SizedBox(
                                                                                                                      height: 15,
                                                                                                                    ),
                                                                                                                    new IconButton(
                                                                                                                      icon: new Image(image: galleryicon),
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      height: 4,
                                                                                                                    ),
                                                                                                                    Text(gallery),
                                                                                                                  ]),
                                                                                                                )),
                                                                                                            _displayImage != null || _imageFile != null
                                                                                                                ? Container(
                                                                                                                    decoration: BoxDecoration(
                                                                                                                      color: whiteyellow,
                                                                                                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                                                                    ),
                                                                                                                    child: FlatButton(
                                                                                                                        onPressed: () {
                                                                                                                          Navigator.pop(context);
                                                                                                                          setModalState(() {
                                                                                                                            removeimg = true;
                                                                                                                            _displayImage = null;
                                                                                                                            _imageFile = null;
                                                                                                                          });
                                                                                                                        },
                                                                                                                        child: Column(children: <Widget>[
                                                                                                                          SizedBox(
                                                                                                                            height: 20,
                                                                                                                          ),
                                                                                                                          Icon(
                                                                                                                            Icons.do_disturb_on_rounded,
                                                                                                                            size: 35,
                                                                                                                            color: grey,
                                                                                                                          ),
                                                                                                                          SizedBox(
                                                                                                                            height: 10,
                                                                                                                          ),
                                                                                                                          Text(
                                                                                                                            remove,
                                                                                                                          ),
                                                                                                                        ])))
                                                                                                                : Container()
                                                                                                          ],
                                                                                                        )),
                                                                                                  )));
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 40,
                                                                                          width: 40,
                                                                                          decoration: BoxDecoration(
                                                                                            shape: BoxShape.circle,
                                                                                            border: Border.all(width: 2, color: greylight
                                                                                                //color:  Theme.of(context).scaffoldBackgroundColor,
                                                                                                ),
                                                                                            color: white,
                                                                                          ),
                                                                                          child: Icon(Icons.camera_alt, color: grey, size: 24.0),
                                                                                        ),
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              TextFormField(
                                                                                inputFormatters: [
                                                                                  WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z]+|\s")),
                                                                                ],
                                                                                initialValue: props.userdata.user.firstName,
                                                                                validator: validatename,
                                                                                onSaved: (input) => ename = input,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  enabledBorder: enableborder,
                                                                                  focusedBorder: focusborder,
                                                                                  border: enableborder,
                                                                                  labelText: firstname,
                                                                                  labelStyle: TextStyle(color: grey),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 10.0,
                                                                              ),
                                                                              TextFormField(
                                                                                inputFormatters: [
                                                                                  WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z]+|\s")),
                                                                                ],
                                                                                initialValue: props.userdata.user.lastName,
                                                                                validator: validatelname,
                                                                                onSaved: (input) => elname = input,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  enabledBorder: enableborder,
                                                                                  focusedBorder: focusborder,
                                                                                  border: enableborder,
                                                                                  labelText: lastname,
                                                                                  labelStyle: TextStyle(color: grey),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 10),
                                                                              TextFormField(
                                                                                initialValue: props.userdata.user.phoneNumber,
                                                                                validator: validatephonenew,
                                                                                onSaved: (input) => ephonenum = input,

                                                                                keyboardType: TextInputType.phone,
                                                                                maxLength: 13,
                                                                                decoration: InputDecoration(
                                                                                  enabledBorder: enableborder,
                                                                                  focusedBorder: focusborder,
                                                                                  border: enableborder,
                                                                                  counterText: "",
                                                                                  labelText: phonenumber,
                                                                                  suffixIcon: TextButton(
                                                                                    onPressed: () async {
                                                                                      if (validateAndSave()) {
                                                                                        if (ephonenum.length != 13) {
                                                                                          print("invalid");
                                                                                          setModalState(() {
                                                                                            ephonenum = "+91" + ephonenum;
                                                                                            print(ephonenum);
                                                                                          });
                                                                                        }
                                                                                        print(ephonenum);
                                                                                        Map body = {
                                                                                          "newPhoneNumber": ephonenum
                                                                                        };
                                                                                        print(body);
                                                                                        if (props.userdata.user.phoneNumber == ephonenum) {
                                                                                          setModalState(() {
                                                                                            numberexit = true;
                                                                                          });
                                                                                          setModalState(() {
                                                                                            issave = false;
                                                                                          });
                                                                                        } else if (props.userdata.user.phoneNumber == "+91" + ephonenum) {
                                                                                          setModalState(() {
                                                                                            numberexit = true;
                                                                                          });
                                                                                          setModalState(() {
                                                                                            issave = false;
                                                                                          });
                                                                                        } else {
                                                                                          var urlvalue = Uri.parse(BASE_URL + VERIFY_NEW_NUMBER);
                                                                                          final prefs = await SharedPreferences.getInstance();
                                                                                          final key = 'token';
                                                                                          final value = prefs.get(key) ?? 0;
                                                                                          print(value);
                                                                                          try {
                                                                                            issave = true;
                                                                                            var response = await http.put(urlvalue, body: body, headers: {
                                                                                              'Authorization': 'jwt $value'
                                                                                            });
                                                                                            print(response.body);
                                                                                            setModalState(() {
                                                                                              issave = true;
                                                                                            });
                                                                                            if (response.statusCode == 200 || response.statusCode == 201) {
                                                                                              setModalState(() {
                                                                                                issave = false;
                                                                                              });
                                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => Changephonenumber(changenumber: ephonenum)));
                                                                                              print("successful");
                                                                                              print(response.body);
                                                                                              print(response.statusCode);
                                                                                            } else {
                                                                                              setModalState(() {
                                                                                                issave = false;
                                                                                              });
                                                                                              print(response.statusCode);
                                                                                            }
                                                                                          } catch (e) {
                                                                                            alert();
                                                                                            setModalState(() {
                                                                                              issave = false;
                                                                                            });
                                                                                          }
                                                                                        }
                                                                                      }
                                                                                    },
                                                                                    child: Text(
                                                                                      verify,
                                                                                      style: TextStyle(color: Theme.of(context).primaryColor),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ])),
                                                              ),
                                                              issave
                                                                  ? Container(
                                                                      width: MediaQuery.of(context).size.width,
                                                                      height: 450,
                                                                      color: Colors.black26,
                                                                      child: Align(
                                                                          alignment: Alignment.center,
                                                                          child: Container(
                                                                            child: CircularProgressIndicator(),
                                                                          )))
                                                                  : Container(),
                                                              if (alertbox)
                                                                Container(
                                                                    child: Positioned(
                                                                        top: 20,
                                                                        left: 0,
                                                                        right: 0,
                                                                        child: Container(
                                                                            color: red,
                                                                            padding: EdgeInsets.all(6),
                                                                            child: Row(children: <Widget>[
                                                                              SizedBox(
                                                                                width: getDevicewidth(context, 0.02),
                                                                              ),
                                                                              Text(
                                                                                "Invalid Credentials",
                                                                                style: TextStyle(color: white, fontFamily: 'ProximaNova-Medium', fontSize: 16),
                                                                              ),
                                                                              new Flexible(
                                                                                  child: Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: IconButton(
                                                                                          icon: Icon(
                                                                                            Icons.close_rounded,
                                                                                            color: white,
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            setModalState(() {
                                                                                              alertbox = !alertbox;
                                                                                            });
                                                                                          }))),
                                                                            ])))),
                                                              if (validnumber)
                                                                Container(
                                                                    child: Positioned(
                                                                        top: 20,
                                                                        left: 0,
                                                                        right: 0,
                                                                        child: Container(
                                                                            color: red,
                                                                            padding: EdgeInsets.all(6),
                                                                            child: Row(children: <Widget>[
                                                                              SizedBox(
                                                                                width: getDevicewidth(context, 0.02),
                                                                              ),
                                                                              Text(
                                                                                "Phone Number should be verified",
                                                                                style: TextStyle(color: white, fontFamily: 'ProximaNova-Medium', fontSize: 16),
                                                                              ),
                                                                              new Flexible(
                                                                                  child: Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: IconButton(
                                                                                          icon: Icon(
                                                                                            Icons.close_rounded,
                                                                                            color: white,
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            setModalState(() {
                                                                                              validnumber = !validnumber;
                                                                                            });
                                                                                          }))),
                                                                            ])))),
                                                              if (numberexit)
                                                                Container(
                                                                    child: Positioned(
                                                                        top: 20,
                                                                        left: 0,
                                                                        right: 0,
                                                                        child: Container(
                                                                            color: red,
                                                                            padding: EdgeInsets.all(6),
                                                                            child: Row(children: <Widget>[
                                                                              SizedBox(
                                                                                width: getDevicewidth(context, 0.02),
                                                                              ),
                                                                              Text(
                                                                                "Phone Number already verified",
                                                                                style: TextStyle(color: white, fontFamily: 'ProximaNova-Medium', fontSize: 16),
                                                                              ),
                                                                              new Flexible(
                                                                                  child: Align(
                                                                                      alignment: Alignment.topRight,
                                                                                      child: IconButton(
                                                                                          icon: Icon(
                                                                                            Icons.close_rounded,
                                                                                            color: white,
                                                                                          ),
                                                                                          onPressed: () {
                                                                                            setModalState(() {
                                                                                              numberexit = !numberexit;
                                                                                            });
                                                                                          }))),
                                                                            ])))),
                                                            ])))),
                                                  )));
                                        });
                                  },
                                  child: Image(
                                    image: editicon,
                                    width: 40,
                                    height: 33,
                                  ),
                                  shape: CircleBorder(),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FlatButton.icon(
                                  icon: Image(
                                    image: isymbolicon,
                                    width: 20,
                                    height: 20,
                                  ),
                                  label: Text(
                                    basicdetails,
                                    style: TextStyle(fontFamily: 'ProximaNovaBold', color: black),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: getDevicewidth(context, 0.1)),
                                  child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(name, style: kSubtitlestyle,),
                                        SizedBox(height: getDeviceheight(context, 0.01),),
                                        Text(
                                          props.userdata.user.firstName + "\t" + props.userdata.user.lastName,
                                          style: TextStyle(fontSize: 16, fontFamily: 'ProximaNova-Medium', color: black),
                                        ),
                                        SizedBox(
                                          height: getDeviceheight(context, 0.01),),
                                        Divider(color: grey, indent: 0, endIndent: 0, height: 10, thickness: 0.06,),
                                        SizedBox(
                                            height: getDeviceheight(context, 0.01)),
                                        Text(
                                          phonenumberprofile, style: kSubtitlestyle,),
                                        SizedBox(
                                          height: getDeviceheight(context, 0.01),),
                                        Text(
                                          props.userdata.user.phoneNumber,
                                          style: TextStyle(fontSize: 16, fontFamily: 'ProximaNova-Medium', color: black),
                                        ),
                                        SizedBox(
                                          height: getDeviceheight(context, 0.01),
                                        ),
                                        Divider(color: grey, indent: 0, endIndent: 0, height: 10, thickness: 0.06,),
                                        SizedBox(
                                            height: getDeviceheight(context, 0.01)),
                                        Text(
                                          workemail, style: kSubtitlestyle,),
                                        SizedBox(
                                          height: getDeviceheight(context, 0.01),
                                        ),
                                        Text(
                                          props.userdata.user.email,
                                          style: TextStyle(fontSize: 16, fontFamily: 'ProximaNova-Medium', color: black),
                                        )
                                      ])),
                            ],
                          )))),
            );
          } else if (props.error) {
            body = Text(props.error);
            //print("error");
          }
          return Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: BackButton(
                color: blacklight,
              ),
              title: Text(myprofile,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'ProximaNova-Medium',
                    color: black,
                  )),
              actions: [
                IconButton(
                  icon: Icon(Icons.more_vert, color: black),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: topBorder,
                      isScrollControlled: true,
                      builder: (context) {
                        return StatefulBuilder(
                            builder: (BuildContext context,
                                    StateSetter setModalState) =>
                                logout());
                      },
                    );
                  },
                ),
              ],
              backgroundColor: Colors.white,
            ),
            body: body,
          );
          // },
          //);
        });
  }

  Widget logout() {
    return Container(
        height: 150,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/changepassword');
                },
                icon: Image(
                  image: changepassicon,
                  width: 16,
                ),
                label: Text(
                  changepassword,
                  style: TextStyle(fontFamily: 'ProximaNova-Regular'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  logoutAlert();
                },
                icon: Image(image: logouticon, width: 15),
                label: Text(
                  logut,
                  style:
                      TextStyle(color: red, fontFamily: 'ProximaNova-Regular'),
                ),
              ),
            ]));
  }

  logoutAlert() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                // contentPadding: EdgeInsets.only(top: 10.0),
                content: Container(
                    width: 150.0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                              alignment: Alignment.topLeft,
                              child: FlatButton.icon(
                                icon: Image(
                                  image: logouticon,
                                  width: 15,
                                  height: 20,
                                ),
                                label: Text(
                                  logut,
                                  style: TextStyle(color: red),
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(surelogout),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  color: lightgrey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    no,
                                    style: TextStyle(color: lightblack),
                                  ),
                                ),
                                RaisedButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs?.clear();
                                    final key = null;
                                    final value = prefs.get(key);

                                    print(value);
                                    if (value == null) {
                                      print("null");
                                      Navigator.pushNamed(context, '/signin');
                                    } else {
                                      print("notnull");
                                    }
                                  },
                                  color: tealaccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(yes),
                                ),
                              ]),
                        ])),
              ) ??
              false;
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
            title: Center(
                child: Text(
              "OTP send to your SMS successfully",
              style: TextStyle(
                  fontSize: 17, fontFamily: 'ProximaNova-Bold', color: grey),
            )),
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

  Future<File> _download() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'token';
    final value = prefs.get(key) ?? 0;
    print(value);

    var url = Uri.parse(PROFILE_PICTURE);
    print(url);
    final response = await http.get(
      url,
      headers: {'Authorization': 'jwt $value'},
    );
    if (response.statusCode == 200) {
      print(response.statusCode);

      // Get the image name
      final imageName = path.basename(PROFILE_PICTURE);
      // Get the document directory path
      final appDir = await pathProvider.getApplicationDocumentsDirectory();

      // This is the saved image path
      // You can use it to display the saved image later.
      final localPath = path.join(appDir.path, imageName);

      // Downloading
      final imageFile = File(localPath);
      await imageFile.writeAsBytes(response.bodyBytes);
      setState(() {
        _displayImage = imageFile;
      });
    } else {
      print("nullimg");
      _displayImage = null;
    }
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
            title: Center(
                child: Text(
              "Please Try Again",
              style: TextStyle(
                  fontSize: 17, fontFamily: 'ProximaNova-Bold', color: grey),
            )),
          );
        });
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
            title: Center(
                child: Text(
              "Updated Successfully",
              style: TextStyle(
                  fontSize: 17, fontFamily: 'ProximaNova-Bold', color: grey),
            )),
          );
        });
  }

}

class ProfileProps {
  final bool loading;
  final dynamic error;
  final Profiledetails userdata;
  final Function profileapi;

  ProfileProps({this.loading, this.error, this.userdata, this.profileapi});
}

ProfileProps mapStateToProps(Store<AppState> store) {
  return ProfileProps(
    loading: store.state.profdetails.loading,
    error: store.state.profdetails.error,
    userdata: store.state.profdetails.userdata,
    profileapi: () => store.dispatch(profiledata()),
  );
}
