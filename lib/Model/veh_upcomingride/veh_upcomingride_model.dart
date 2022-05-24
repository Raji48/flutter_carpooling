

class Veh_owner_upcomingride_modal {
  List<UpcomingRides> upcomingRides;

  Veh_owner_upcomingride_modal({this.upcomingRides});

  Veh_owner_upcomingride_modal.fromJson(Map<String, dynamic> json) {
    if (json['upcomingRides'] != null) {
      upcomingRides = new List<UpcomingRides>();
      json['upcomingRides'].forEach((v) {
        upcomingRides.add(new UpcomingRides.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upcomingRides != null) {
      data['upcomingRides'] =
          this.upcomingRides.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UpcomingRides {
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
  List<CommutersDetails> commutersDetails;
  TimeSlotDetails timeSlotDetails;
  List<ViaPointsDetails> viaPointsDetails;

  UpcomingRides(
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
        this.commutersDetails,
        this.timeSlotDetails,
        this.viaPointsDetails});

  UpcomingRides.fromJson(Map<String, dynamic> json) {
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
    if (json['commutersDetails'] != null) {
      commutersDetails = new List<CommutersDetails>();
      json['commutersDetails'].forEach((v) {
        commutersDetails.add(new CommutersDetails.fromJson(v));
      });
    }
    timeSlotDetails = json['timeSlotDetails'] != null
        ? new TimeSlotDetails.fromJson(json['timeSlotDetails'])
        : null;
    if (json['viaPointsDetails'] != null) {
      viaPointsDetails = new List<ViaPointsDetails>();
      json['viaPointsDetails'].forEach((v) {
        viaPointsDetails.add(new ViaPointsDetails.fromJson(v));
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
    if (this.commutersDetails != null) {
      data['commutersDetails'] =
          this.commutersDetails.map((v) => v.toJson()).toList();
    }
    if (this.timeSlotDetails != null) {
      data['timeSlotDetails'] = this.timeSlotDetails.toJson();
    }
    if (this.viaPointsDetails != null) {
      data['viaPointsDetails'] =
          this.viaPointsDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ViaPointsDetails {
  double lat;
  double lng;
  String address;

  ViaPointsDetails({this.lat, this.lng, this.address});

  ViaPointsDetails.fromJson(Map<String, dynamic> json) {
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

class CommutersDetails {
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
  RequestDetails requestDetails;

  CommutersDetails(
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
        this.profilePictureUrl,
        this.requestDetails});

  CommutersDetails.fromJson(Map<String, dynamic> json) {
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
    requestDetails = json['requestDetails'] != null
        ? new RequestDetails.fromJson(json['requestDetails'])
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
    data['profilePictureUrl'] = this.profilePictureUrl;
    if (this.requestDetails != null) {
      data['requestDetails'] = this.requestDetails.toJson();
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
