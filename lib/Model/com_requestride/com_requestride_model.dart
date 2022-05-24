class Commuter_req_modal {
  RequestDetails requestDetails;

  Commuter_req_modal({this.requestDetails});

  Commuter_req_modal.fromJson(Map<String, dynamic> json) {
    requestDetails = json['requestDetails'] != null
        ? new RequestDetails.fromJson(json['requestDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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