class Requested_ride_modal {
  List<RequestedRides> requestedRides;

  Requested_ride_modal({this.requestedRides});

  Requested_ride_modal.fromJson(Map<String, dynamic> json) {
    if (json['requestedRides'] != null) {
      requestedRides = new List<RequestedRides>();
      json['requestedRides'].forEach((v) {
        requestedRides.add(new RequestedRides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestedRides != null) {
      data['requestedRides'] =
          this.requestedRides.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestedRides {
  RequestDetails requestDetails;
  RideDetails rideDetails;
  List<CommuterDetails> commuterDetails;
  OwnerDetails ownerDetails;
  VehicleDetails vehicleDetails;

  RequestedRides(
      {this.requestDetails,
        this.rideDetails,
        this.commuterDetails,
        this.ownerDetails,
        this.vehicleDetails});

  RequestedRides.fromJson(Map<String, dynamic> json) {
    requestDetails = json['requestDetails'] != null
        ? new RequestDetails.fromJson(json['requestDetails'])
        : null;
    rideDetails = json['rideDetails'] != null
        ? new RideDetails.fromJson(json['rideDetails'])
        : null;
    if (json['commuterDetails'] != null) {
      commuterDetails = new List<CommuterDetails>();
      json['commuterDetails'].forEach((v) {
        commuterDetails.add(new CommuterDetails.fromJson(v));
      });
    }
    ownerDetails = json['ownerDetails'] != null
        ? new OwnerDetails.fromJson(json['ownerDetails'])
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
    if (this.rideDetails != null) {
      data['rideDetails'] = this.rideDetails.toJson();
    }
    if (this.commuterDetails != null) {
      data['commuterDetails'] =
          this.commuterDetails.map((v) => v.toJson()).toList();
    }
    if (this.ownerDetails != null) {
      data['ownerDetails'] = this.ownerDetails.toJson();
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
  TimeSlotDetails timeSlotDetails;
  List<ViaPointDetails> viaPointDetails;

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
        this.ownerId,
        this.timeSlotDetails,
        this.viaPointDetails});

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
    timeSlotDetails = json['timeSlotDetails'] != null
        ? new TimeSlotDetails.fromJson(json['timeSlotDetails'])
        : null;
    if (json['viaPointDetails'] != null) {
      viaPointDetails = new List<ViaPointDetails>();
      json['viaPointDetails'].forEach((v) {
        viaPointDetails.add(new ViaPointDetails.fromJson(v));
      });
    }
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
    if (this.timeSlotDetails != null) {
      data['timeSlotDetails'] = this.timeSlotDetails.toJson();
    }
    if (this.viaPointDetails != null) {
      data['viaPointDetails'] =
          this.viaPointDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViaPointDetails {
  double lat;
  double lng;
  String address;

  ViaPointDetails({this.lat, this.lng, this.address});

  ViaPointDetails.fromJson(Map<String, dynamic> json) {
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

class TimeSlotDetails {
  int id;
  String slotCategory;
  String slotTime;

  TimeSlotDetails({this.id, this.slotCategory, this.slotTime});

  TimeSlotDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slotCategory = json['slotCategory'];
    slotTime = json['slotTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slotCategory'] = this.slotCategory;
    data['slotTime'] = this.slotTime;
    return data;
  }
}

class CommuterDetails {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  bool isDeleted;
  bool isDeactivated;
  bool isVerified;
  Null homeLocation;
  Null officeLocation;
  String profilePictureUrl;

  CommuterDetails(
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

  CommuterDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isDeleted = json['isDeleted'];
    isDeactivated = json['isDeactivated'];
    isVerified = json['isVerified'];
    homeLocation = json['homeLocation'];
    officeLocation = json['officeLocation'];
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
    data['homeLocation'] = this.homeLocation;
    data['officeLocation'] = this.officeLocation;
    data['profilePictureUrl'] = this.profilePictureUrl;
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

