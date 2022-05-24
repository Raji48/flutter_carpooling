//import 'package:dio/dio.dart';

class RegisterRequestModel {
  String firstname;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  //ProfilePic profilePic;

  RegisterRequestModel({
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.password,
  });
 // final Map<String, dynamic> data = Map<String, dynamic>();
  Map<String, dynamic> FormData() {
    Map<String, dynamic> map = {
   // FormData formData= {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'email': email, //.trim(),
      'password': password, //.trim(),

    } ;//as FormData;
  /*  FormData formData = new FormData.fromMap({
      'firstName':firstName,
      'lastName':lastName,
      'phoneNumber':phoneNumber,
      'email': email,//.trim(),
      'password': password,//.trim(),
    });*/

    return map;
  }
}

/*var dio = Dio();
class APIService {

  Future register(RegisterRequestModel requestModel) async {
    print("succ");
    String url = "http://54.235.130.26:8002/api/auth/register";

    final response = await dio.post(url, data:FormData.fromMap(requestModel.FormData()));// requestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("successful");
      // var data=jsonDecode(response.data);
      //  print('$data');


    }    if (response.statusCode > 202){
      print("error");
    }
    else {
      throw Exception('Failed to load data!');
    }
  }
}*/