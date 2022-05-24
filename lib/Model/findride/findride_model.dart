
class FindrideModal {
  List<List<MatchingRides>> matchingRides;
  List<MatchingRides> date;

  FindrideModal({this.matchingRides});

  FindrideModal.fromJson(Map<String, dynamic> json) {
    if (json['matchingRides'] != null) {
      matchingRides = [];
      json['matchingRides'].forEach((v) {
        date = [];
        v.forEach((s) {
          date.add(new MatchingRides.fromJson(s));
        });
        matchingRides.add(date);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.matchingRides != null) {
       // data['matchingRides'] =
       //    this.matchingRides.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class MatchingRides {
  RequestDetails requestDetails;
  OwnerDetails ownerDetails;
  RideDetails rideDetails;
  VehicleDetails vehicleDetails;

  MatchingRides(
      {this.requestDetails,
        this.ownerDetails,
        this.rideDetails,
        this.vehicleDetails});

  MatchingRides.fromJson(Map<String, dynamic> json) {
    requestDetails = json['requestDetails'] != null
        ? new RequestDetails.fromJson(json['requestDetails'])
        : null;
    ownerDetails = json['ownerDetails'] != null
        ? new OwnerDetails.fromJson(json['ownerDetails'])
        : null;
    rideDetails = json['rideDetails'] != null
        ? new RideDetails.fromJson(json['rideDetails'])
        : null;
    vehicleDetails = json['vehicleDetails'] != null
        ? new VehicleDetails.fromJson(json['vehicleDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestDetails != null) {
      data['requestDetails'] = this.requestDetails.toJson();
    }
    if (this.ownerDetails != null) {
      data['ownerDetails'] = this.ownerDetails.toJson();
    }
    if (this.rideDetails != null) {
      data['rideDetails'] = this.rideDetails.toJson();
    }
    if (this.vehicleDetails != null) {
      data['vehicleDetails'] = this.vehicleDetails.toJson();
    }
    return data;
  }
}

class RequestDetails {
  int requestId;
  StartLocation startLocation;
  StartLocation endLocation;
  bool isAccepted;
  bool isRejected;
  bool isCancelled;
  bool isRideOver;

  RequestDetails(
      {this.requestId,
        this.startLocation,
        this.endLocation,
        this.isAccepted,
        this.isRejected,
        this.isCancelled,
        this.isRideOver});

  RequestDetails.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    startLocation = json['startLocation'] != null
        ? new StartLocation.fromJson(json['startLocation'])
        : null;
    endLocation = json['endLocation'] != null
        ? new StartLocation.fromJson(json['endLocation'])
        : null;
    isAccepted = json['isAccepted'];
    isRejected = json['isRejected'];
    isCancelled = json['isCancelled'];
    isRideOver = json['isRideOver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['requestId'] = this.requestId;
    if (this.startLocation != null) {
      data['startLocation'] = this.startLocation.toJson();
    }
    if (this.endLocation != null) {
      data['endLocation'] = this.endLocation.toJson();
    }
    data['isAccepted'] = this.isAccepted;
    data['isRejected'] = this.isRejected;
    data['isCancelled'] = this.isCancelled;
    data['isRideOver'] = this.isRideOver;
    return data;
  }
}

class StartLocation {
  double lat;
  double lng;
  String address;

  StartLocation({this.lat, this.lng, this.address});

  StartLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['address'] = this.address;
    return data;
  }
}

class OwnerDetails {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  bool isDeleted;
  bool isDeactivated;
  bool isVerified;
  StartLocation homeLocation;
  StartLocation officeLocation;
  String profilePictureUrl;

  OwnerDetails(
      {this.id,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.email,
        this.isDeleted,
        this.isDeactivated,
        this.isVerified,
        this.homeLocation,
        this.officeLocation,
        this.profilePictureUrl});

  OwnerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isDeleted = json['isDeleted'];
    isDeactivated = json['isDeactivated'];
    isVerified = json['isVerified'];
    homeLocation = json['homeLocation'] != null
        ? new StartLocation.fromJson(json['homeLocation'])
        : null;
    officeLocation = json['officeLocation'] != null
        ? new StartLocation.fromJson(json['officeLocation'])
        : null;
    profilePictureUrl = json['profilePictureUrl'];
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
    data['profilePictureUrl'] = this.profilePictureUrl;
    return data;
  }
}

class RideDetails {
  int id;
  StartLocation startLocation;
  StartLocation endLocation;
  String date;
  int slot;
  bool isStarted;
  bool isCompleted;
  bool isCancelled;
  int seatsFilled;
  int totalSeats;
  int ownerId;

  RideDetails(
      {this.id,
        this.startLocation,
        this.endLocation,
        this.date,
        this.slot,
        this.isStarted,
        this.isCompleted,
        this.isCancelled,
        this.seatsFilled,
        this.totalSeats,
        this.ownerId});

  RideDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startLocation = json['startLocation'] != null
        ? new StartLocation.fromJson(json['startLocation'])
        : null;
    endLocation = json['endLocation'] != null
        ? new StartLocation.fromJson(json['endLocation'])
        : null;
    date = json['date'];
    slot = json['slot'];
    isStarted = json['isStarted'];
    isCompleted = json['isCompleted'];
    isCancelled = json['isCancelled'];
    seatsFilled = json['seatsFilled'];
    totalSeats = json['totalSeats'];
    ownerId = json['ownerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.startLocation != null) {
      data['startLocation'] = this.startLocation.toJson();
    }
    if (this.endLocation != null) {
      data['endLocation'] = this.endLocation.toJson();
    }
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['isStarted'] = this.isStarted;
    data['isCompleted'] = this.isCompleted;
    data['isCancelled'] = this.isCancelled;
    data['seatsFilled'] = this.seatsFilled;
    data['totalSeats'] = this.totalSeats;
    data['ownerId'] = this.ownerId;
    return data;
  }
}

class VehicleDetails {
  int id;
  String vehicleName;
  String numberOfSeats;
  String vehicleNumber;
  String insuranceNumber;
  String validity;

  VehicleDetails(
      {this.id,
        this.vehicleName,
        this.numberOfSeats,
        this.vehicleNumber,
        this.insuranceNumber,
        this.validity});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleName = json['vehicleName'];
    numberOfSeats = json['numberOfSeats'];
    vehicleNumber = json['vehicleNumber'];
    insuranceNumber = json['insuranceNumber'];
    validity = json['validity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicleName'] = this.vehicleName;
    data['numberOfSeats'] = this.numberOfSeats;
    data['vehicleNumber'] = this.vehicleNumber;
    data['insuranceNumber'] = this.insuranceNumber;
    data['validity'] = this.validity;
    return data;
  }
}