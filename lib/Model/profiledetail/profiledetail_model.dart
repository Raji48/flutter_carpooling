class Profiledetails {
  User user;

  Profiledetails({this.user});

  Profiledetails.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  bool isDeleted;
  bool isDeactivated;
  bool isVerified;
  HomeLocation homeLocation;
  HomeLocation officeLocation;

  User(
      {this.id,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.email,
        this.isDeleted,
        this.isDeactivated,
        this.isVerified,
        this.homeLocation,
        this.officeLocation});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isDeleted = json['isDeleted'];
    isDeactivated = json['isDeactivated'];
    isVerified = json['isVerified'];
    homeLocation = json['homeLocation'] != null
        ? new HomeLocation.fromJson(json['homeLocation'])
        : null;
    officeLocation = json['officeLocation'] != null
        ? new HomeLocation.fromJson(json['officeLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['isDeleted'] = this.isDeleted;
    data['isDeactivated'] = this.isDeactivated;
    data['isVerified'] = this.isVerified;
    if (this.homeLocation != null) {
      data['homeLocation'] = this.homeLocation.toJson();
    }
    if (this.officeLocation != null) {
      data['officeLocation'] = this.officeLocation.toJson();
    }
    return data;
  }
}

class HomeLocation {
  double lat;
  double lng;

  HomeLocation({this.lat, this.lng});

  HomeLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
