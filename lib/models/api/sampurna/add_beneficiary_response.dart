class AddBeneficiaryResponse {
  AddBeneficiaryResponse({
      this.beneID, 
      this.statuscode, 
      this.message, 
      this.errorCode, 
      this.isOTPRequired,});

  AddBeneficiaryResponse.fromJson(dynamic json) {
    beneID = json['beneID'];
    statuscode = json['statuscode'];
    message = json['message'];
    errorCode = json['errorCode'];
    isOTPRequired = json['isOTPRequired'];
  }
  String? beneID;
  int? statuscode;
  String? message;
  int? errorCode;
  bool? isOTPRequired;
AddBeneficiaryResponse copyWith({  String? beneID,
  int? statuscode,
  String? message,
  int? errorCode,
  bool? isOTPRequired,
}) => AddBeneficiaryResponse(  beneID: beneID ?? this.beneID,
  statuscode: statuscode ?? this.statuscode,
  message: message ?? this.message,
  errorCode: errorCode ?? this.errorCode,
  isOTPRequired: isOTPRequired ?? this.isOTPRequired,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['beneID'] = beneID;
    map['statuscode'] = statuscode;
    map['message'] = message;
    map['errorCode'] = errorCode;
    map['isOTPRequired'] = isOTPRequired;
    return map;
  }

}