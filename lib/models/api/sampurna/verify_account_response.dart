class VerifyAccountResponse {
  VerifyAccountResponse({
      this.status, 
      this.beneName, 
      this.rpid, 
      this.liveID, 
      this.statuscode, 
      this.message, 
      this.errorCode,});

  VerifyAccountResponse.fromJson(dynamic json) {
    status = json['status'];
    beneName = json['beneName'];
    rpid = json['rpid'];
    liveID = json['liveID'];
    statuscode = json['statuscode'];
    message = json['message'];
    errorCode = json['errorCode'];
  }
  int? status;
  String? beneName;
  String? rpid;
  String? liveID;
  int? statuscode;
  String? message;
  int? errorCode;
VerifyAccountResponse copyWith({  int? status,
  String? beneName,
  String? rpid,
  String? liveID,
  int? statuscode,
  String? message,
  int? errorCode,
}) => VerifyAccountResponse(  status: status ?? this.status,
  beneName: beneName ?? this.beneName,
  rpid: rpid ?? this.rpid,
  liveID: liveID ?? this.liveID,
  statuscode: statuscode ?? this.statuscode,
  message: message ?? this.message,
  errorCode: errorCode ?? this.errorCode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['beneName'] = beneName;
    map['rpid'] = rpid;
    map['liveID'] = liveID;
    map['statuscode'] = statuscode;
    map['message'] = message;
    map['errorCode'] = errorCode;
    return map;
  }

}