class TransactionEntity {
  TransactionEntity({
      this.transactionId, 
      this.serviceId, 
      this.detailId, 
      this.addedOn, 
      this.tracking,});

  TransactionEntity.fromJson(dynamic json) {
    transactionId = json['transaction_id'];
    serviceId = json['service_id'];
    detailId = json['detail_id'];
    addedOn = json['added_on'];
    if (json['tracking'] != null) {
      tracking = [];
      json['tracking'].forEach((v) {
        tracking?.add(Tracking.fromJson(v));
      });
    }
  }
  int? transactionId;
  int? serviceId;
  int? detailId;
  String? addedOn;
  List<Tracking>? tracking;
TransactionEntity copyWith({  int? transactionId,
  int? serviceId,
  int? detailId,
  String? addedOn,
  List<Tracking>? tracking,
}) => TransactionEntity(  transactionId: transactionId ?? this.transactionId,
  serviceId: serviceId ?? this.serviceId,
  detailId: detailId ?? this.detailId,
  addedOn: addedOn ?? this.addedOn,
  tracking: tracking ?? this.tracking,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_id'] = transactionId;
    map['service_id'] = serviceId;
    map['detail_id'] = detailId;
    map['added_on'] = addedOn;
    if (tracking != null) {
      map['tracking'] = tracking?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Tracking {
  Tracking({
      this.trackingId, 
      this.lastStatus, 
      this.status, 
      this.addedOn, 
      this.extras, 
      this.comment,});

  Tracking.fromJson(dynamic json) {
    trackingId = json['tracking_id'];
    lastStatus = json['last_status'];
    status = json['status'];
    addedOn = json['added_on'];
    extras = json['extras'];
    comment = json['comment'];
  }
  int? trackingId;
  String? lastStatus;
  String? status;
  String? addedOn;
  String? extras;
  String? comment;
Tracking copyWith({  int? trackingId,
  String? lastStatus,
  String? status,
  String? addedOn,
  String? extras,
  String? comment,
}) => Tracking(  trackingId: trackingId ?? this.trackingId,
  lastStatus: lastStatus ?? this.lastStatus,
  status: status ?? this.status,
  addedOn: addedOn ?? this.addedOn,
  extras: extras ?? this.extras,
  comment: comment ?? this.comment,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tracking_id'] = trackingId;
    map['last_status'] = lastStatus;
    map['status'] = status;
    map['added_on'] = addedOn;
    map['extras'] = extras;
    map['comment'] = comment;
    return map;
  }

}