class veh_schedule_ride {
  StartLocation startLocation;
  StartLocation endLocation;
  List<ViaPoints> viaPoints;
  List<SlotDetails> slotDetails;

  veh_schedule_ride(
      {this.startLocation, this.endLocation, this.viaPoints, this.slotDetails});

  veh_schedule_ride.fromJson(Map<String, dynamic> json) {
    startLocation = json['startLocation'] != null
        ? new StartLocation.fromJson(json['startLocation'])
        : null;
    endLocation = json['endLocation'] != null
        ? new StartLocation.fromJson(json['endLocation'])
        : null;
    if (json['viaPoints'] != null) {
      viaPoints = new List<ViaPoints>();
      json['viaPoints'].forEach((v) {
        viaPoints.add(new ViaPoints.fromJson(v));
      });
    }
    if (json['slotDetails'] != null) {
      slotDetails = new List<SlotDetails>();
      json['slotDetails'].forEach((v) {
        slotDetails.add(new SlotDetails.fromJson(v));
      });
    }
  }




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.startLocation != null) {
      data['startLocation'] = this.startLocation.toJson();
    }
    if (this.endLocation != null) {
      data['endLocation'] = this.endLocation.toJson();
    }
    if (this.viaPoints != null) {
      data['viaPoints'] = this.viaPoints.map((v) => v.toJson()).toList();
    }
    if (this.slotDetails != null) {
      data['slotDetails'] = this.slotDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class StartLocation {
  double lat;
  double lng;

  StartLocation({this.lat, this.lng});

  StartLocation.fromJson(Map<String, dynamic> json) {
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

class EndLocation {
  double lat;
  double lng;

  EndLocation({this.lat, this.lng});

  EndLocation.fromJson(Map<String, dynamic> json) {
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

class SlotDetails {
  String date;
  int slot;

  SlotDetails({this.date, this.slot});

  SlotDetails.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    slot = json['slot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['slot'] = this.slot;
    return data;
  }
}
class ViaPoints {
  double lat;
  double lng;

  ViaPoints({this.lat, this.lng});

  ViaPoints.fromJson(Map<String, dynamic> json) {
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