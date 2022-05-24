class Vehicledetail {
  Vehicle vehicle;

  Vehicledetail({this.vehicle});

  Vehicledetail.fromJson(Map<String, dynamic> json) {
    vehicle =
    json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.toJson();
    }
    return data;
  }
}

class Vehicle {
  int id;
  String vehicleName;
  String numberOfSeats;
  String vehicleNumber;
  String insuranceNumber;
  String validity;

  Vehicle(
      {this.id,
        this.vehicleName,
        this.numberOfSeats,
        this.vehicleNumber,
        this.insuranceNumber,
        this.validity});

  Vehicle.fromJson(Map<String, dynamic> json) {
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












