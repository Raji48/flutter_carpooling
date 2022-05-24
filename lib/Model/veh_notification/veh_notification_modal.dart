class Veh_owner_notification_modal {
  List<Notifications> notifications;

  Veh_owner_notification_modal({this.notifications});

  Veh_owner_notification_modal.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int id;
  String commuterFirstName;
  String commuterLastName;
  int rideId;
  String status;
  String slotName;
  String date;
  String createdAt;
  String updatedAt;
  int ownerId;

  Notifications(
      {this.id,
        this.commuterFirstName,
        this.commuterLastName,
        this.rideId,
        this.status,
        this.slotName,
        this.date,
        this.createdAt,
        this.updatedAt,
        this.ownerId});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commuterFirstName = json['commuterFirstName'];
    commuterLastName = json['commuterLastName'];
    rideId = json['rideId'];
    status = json['status'];
    slotName = json['slotName'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    ownerId = json['ownerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commuterFirstName'] = this.commuterFirstName;
    data['commuterLastName'] = this.commuterLastName;
    data['rideId'] = this.rideId;
    data['status'] = this.status;
    data['slotName'] = this.slotName;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['ownerId'] = this.ownerId;
    return data;
  }
}