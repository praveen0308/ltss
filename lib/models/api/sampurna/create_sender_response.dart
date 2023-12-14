class CreateSenderResponse {
  CreateSenderResponse({
      this.referenceID, 
      this.isOTPRequired, 
      this.isOTPResendAvailble, 
      this.statuscode, 
      this.message, 
      this.errorCode, 
      this.isOTpRequired, 
      this.note,});

  CreateSenderResponse.fromJson(dynamic json) {
    referenceID = json['referenceID'];
    isOTPRequired = json['isOTPRequired'];
    isOTPResendAvailble = json['isOTPResendAvailble'];
    statuscode = json['statuscode'];
    message = json['message'];
    errorCode = json['errorCode'];
    isOTpRequired = json['isOTpRequired'];
    note = json['note'];
  }
  String? referenceID;
  bool? isOTPRequired;
  bool? isOTPResendAvailble;
  int? statuscode;
  String? message;
  int? errorCode;
  bool? isOTpRequired;
  String? note;
CreateSenderResponse copyWith({  String? referenceID,
  bool? isOTPRequired,
  bool? isOTPResendAvailble,
  int? statuscode,
  String? message,
  int? errorCode,
  bool? isOTpRequired,
  String? note,
}) => CreateSenderResponse(  referenceID: referenceID ?? this.referenceID,
  isOTPRequired: isOTPRequired ?? this.isOTPRequired,
  isOTPResendAvailble: isOTPResendAvailble ?? this.isOTPResendAvailble,
  statuscode: statuscode ?? this.statuscode,
  message: message ?? this.message,
  errorCode: errorCode ?? this.errorCode,
  isOTpRequired: isOTpRequired ?? this.isOTpRequired,
  note: note ?? this.note,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['referenceID'] = referenceID;
    map['isOTPRequired'] = isOTPRequired;
    map['isOTPResendAvailble'] = isOTPResendAvailble;
    map['statuscode'] = statuscode;
    map['message'] = message;
    map['errorCode'] = errorCode;
    map['isOTpRequired'] = isOTpRequired;
    map['note'] = note;
    return map;
  }

}