class VerifySenderResponse {
  VerifySenderResponse({
      this.statuscode, 
      this.message, 
      this.errorCode,});

  VerifySenderResponse.fromJson(dynamic json) {
    statuscode = json['statuscode'];
    message = json['message'];
    errorCode = json['errorCode'];
  }
  int? statuscode;
  String? message;
  int? errorCode;
VerifySenderResponse copyWith({  int? statuscode,
  String? message,
  int? errorCode,
}) => VerifySenderResponse(  statuscode: statuscode ?? this.statuscode,
  message: message ?? this.message,
  errorCode: errorCode ?? this.errorCode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statuscode'] = statuscode;
    map['message'] = message;
    map['errorCode'] = errorCode;
    return map;
  }

}