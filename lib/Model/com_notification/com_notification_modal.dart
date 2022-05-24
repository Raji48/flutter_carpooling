class Com_notification_modal {
  List<Notifications> notifications;

  Com_notification_modal({this.notifications});

  Com_notification_modal.fromJson(Map<String, dynamic> json) {
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
  String ownerFirstName;
  String ownerLastName;
  int rideId;
  String status;
  String slotName;
  String date;
  String createdAt;
  String updatedAt;
  int commuterId;

  Notifications(
      {this.id,
        this.ownerFirstName,
        this.ownerLastName,
        this.rideId,
        this.status,
        this.slotName,
        this.date,
        this.createdAt,
        this.updatedAt,
        this.commuterId});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerFirstName = json['ownerFirstName'];
    ownerLastName = json['ownerLastName'];
    rideId = json['rideId'];
    status = json['status'];
    slotName = json['slotName'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    commuterId = json['commuterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerFirstName'] = this.ownerFirstName;
    data['ownerLastName'] = this.ownerLastName;
    data['rideId'] = this.rideId;
    data['status'] = this.status;
    data['slotName'] = this.slotName;
    data['date'] = this.date;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['commuterId'] = this.commuterId;
    return data;
  }
}