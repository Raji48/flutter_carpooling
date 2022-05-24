
import 'package:carpooling/Res/strings.dart';
import 'package:carpooling/Services/Apiconstant.dart';
import 'package:carpooling/Services/constants.dart';
import 'package:carpooling/Widgets/application_bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var dio = Dio();

//GET METHOD DIO
Future getDioApi(url, List<String> type, store) async {
  var urlValue = BASE_URL + url;
  Response response;
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key ) ?? 0;
  print(value);
  print("REQUEST URL: " + urlValue);
  print("REQUEST METHOD: GET");
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    store.dispatch(ResponseModal.responseResult(null, type[0]));
    try {
      response = await dio.get(
          urlValue,
          options: Options(
              headers: {
                headerAuth: "jwt $value" ,
              // headerAuth: headerAuthToken ,

              },
              validateStatus: (status) { return status < 500; }
          )
      );
      if (response.statusCode == 200) {

        store.dispatch(ResponseModal.responseResult(response, type[1]));
        print(response.statusCode);

          }else {
            store.dispatch(ResponseModal.responseResult(response, type[1]));
            print(response.statusCode);
          }

    } catch(e) {
                store.dispatch(ResponseModal.responseResult("Please try again", type[2]));
    }
  } else {
    store.dispatch(ResponseModal.responseResult("No internet connection", type[2]));

  }
}


//POST METHOD
Future postDioApi(url, params, List<String> type, store) async {
 // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //String buildNumber = packageInfo.buildNumber;
  var urlValue = BASE_URL + url;
  Response response;
  print("REQUEST URL: " + urlValue);
 print("REQUEST PARAMS: " + params.toString());
  print("REQUEST METHOD: POST");
 // print("REQUEST HEADERS: " + {
  //  headerHost: Header_Host,
   // headerOrigin: Header_Origin,
  //  headerRefer: Header_Refer,
    // headerVersion: headerAppVersion,
    // headerCsrf: headerCsrfToken,
   // headerAuth: headerAuthToken,
  //}.toString());
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
   final value = prefs.get(key ) ?? 0;
  //final value ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJjYXJwb29saW5nIiwic3ViIjp7ImlkIjo3fSwiaWF0IjoxNjIwMjAxMzc5ODQzLCJleHAiOjE2MjAyODc3Nzk4NDN9.oCDf3W2RVp7hVAgKfM4fMR-T8Ue4OHUfYI6ZZvr9zm4";
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    store.dispatch(ResponseModal.responseResult(null, type[0]));
    try {
      response = await dio.post(
          urlValue,
          data: params,//{"query": params},
          options: Options(
              headers: {
               // headerHost: Header_Host,
              //  headerOrigin: Header_Origin,
               // headerRefer: Header_Refer,
                // headerVersion: headerAppVersion,
                // headerCsrf: headerCsrfToken,
            //   headerAuth: headerAuthToken,
                headerAuth: "jwt $value",

              },
              validateStatus: (status) { return status < 500; }
          )
      );
      print(response.data);
      if (response.statusCode == 200 ||response.statusCode ==201 ) {

            store.dispatch(ResponseModal.responseResult(response, type[1]));
            print(response.statusCode);
            print(response.data);


        }
        // store.dispatch(ResponseModal.responseResult(response, type[1]));
        else {
          store.dispatch(ResponseModal.responseResult(response, type[2]));

        }

    } catch(e) {
      store.dispatch(ResponseModal.responseResult("Please try again", type[2]));
    }
  } else {
    Future.delayed(const Duration(milliseconds: 100), (){
     // BaseAlertDialog.showLoginAlert(Icons.signal_wifi_off, noNetworkMsg);
    });
   // store.dispatch(ResponseModal.responseResult("No internet connection", type[2]));
  }
}



//PUT METHOD
Future putDioApi(url, params, List<String> type, store) async {
  // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //String buildNumber = packageInfo.buildNumber;
  var urlValue = BASE_URL + url;
  Response response;
   final prefs = await SharedPreferences.getInstance();
   final key = 'token';
  final value = prefs.get(key ) ?? 0;
 //final value="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJjYXJwb29saW5nIiwic3ViIjp7ImlkIjozfSwiaWF0IjoxNjIwNzQwMTEwNDA4LCJleHAiOjE2MjA4MjY1MTA0MDh9.N6jgz02qn9yIpFwpLWHmOM1fwACB_4GCQ9op2Ln7isQ";
  print(value);
  accesstoken=value;
  print("REQUEST URL: " + urlValue);
  print("REQUEST PARAMS: " + params.toString());
  print("REQUEST METHOD: PUT");
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
    store.dispatch(ResponseModal.responseResult(null, type[0]));
    try {
      print("go");
      response = await dio.put(
          urlValue,
          data: params,//{"query": params},
          options: Options(
              headers: {
              //  headerAuth: headerAuthToken,
                headerAuth: "jwt $value",
              },
              validateStatus: (status) { return status < 500; }
          )
      );
         print(response.statusCode);
      if (response.statusCode == 200) {
         print(response.data);
        store.dispatch(ResponseModal.responseResult(response, type[1]));
        print(response.statusCode);

      }
      // store.dispatch(ResponseModal.responseResult(response, type[1]));
      else {
        store.dispatch(ResponseModal.responseResult(response, type[2]));
        print(response.statusCode);
      }
    } catch(e) {
      store.dispatch(ResponseModal.responseResult("Please try again", type[2]));
    }
  } else {
    print('no network');
    Future.delayed(const Duration(milliseconds: 100), (){
      Text("No internet Connection");
      //BaseAlertDialog.showLoginAlert(Icons.signal_wifi_off, "NoNetwork");
    });
   // store.dispatch(ResponseModal.responseResult("No internet connection", type[2]));
  }
}



class ResponseModal {
  final String type;
  dynamic payload;
  dynamic statuscode;
  dynamic error;

  ResponseModal({
    this.type,
    this.payload,
    this.statuscode,
    this.error
  });

  ResponseModal.responseResult(result, this.type) {
    if (result != null) {
      if (result is String) {
        payload = result;
        statuscode = null;
        error = false;
      } else if (result is Response) {
        if (result.statusCode == 200) {
          payload = result.data;
          statuscode = result.statusCode;
          error = false;
        } else {
          payload = result.data['error_msg'].toString();
          statuscode = result.statusCode;
          error = result.statusMessage;
        }
      }
    } else {
      payload = null;
      statuscode = null;
      error = null;
    }
  }
}

postmethod(url,data) async {
  var urlvalue = Uri.parse(BASE_URL + url);
  var response = await http.post(urlvalue, body:data);
  print(response.body);
  if(response.statusCode==200 || response.statusCode==201){
    print("successful");
    print(response.body);
    print(response.statusCode);

  } if (response.statusCode>200 ){
    print("error");
    print(response.statusCode);
  }
  else{
    print(response.statusCode);
  }
}


putmethod(url,data) async {
  var urlvalue = Uri.parse(BASE_URL + url);
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key ) ?? 0;
  print(value);
  var response = await http.put(urlvalue, body:data,
      headers: {
        'Authorization': 'jwt $value'
      });
  print(response.body);
  if(response.statusCode==200 || response.statusCode==201){
    print("successful");
    print(response.body);
    print(response.statusCode);
  }else{
    print(response.statusCode);
  }
}




Future getmethod(url) async {
  var urlvalue = Uri.parse(BASE_URL + url);
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key ) ?? 0;
  print(value);

  var response = await http.put(urlvalue,
      headers: {
        'Authorization': 'jwt $value'
      });

  print(response.body);
  if(response.statusCode==200 || response.statusCode==201){
    print("successful");
    print(response.body);
    print(response.statusCode);

    // return json.decode(response.body);

  }else{
    print(response.statusCode);
  }
  // var data;
  return response;
}


_save(String token) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = token;
  prefs.setString(key, value);
}


read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key ) ?? 0;
  print('read : $value');
}



