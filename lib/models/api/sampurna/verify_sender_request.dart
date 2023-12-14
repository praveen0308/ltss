class VerifySenderRequest {
  VerifySenderRequest({
      this.mobileNo, 
      this.referenceId, 
      this.otp,});

  VerifySenderRequest.fromJson(dynamic json) {
    mobileNo = json['mobile_no'];
    referenceId = json['reference_id'];
    otp = json['otp'];
  }
  String? mobileNo;
  String? referenceId;
  String? otp;
VerifySenderRequest copyWith({  String? mobileNo,
  String? referenceId,
  String? otp,
}) => VerifySenderRequest(  mobileNo: mobileNo ?? this.mobileNo,
  referenceId: referenceId ?? this.referenceId,
  otp: otp ?? this.otp,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_no'] = mobileNo;
    map['reference_id'] = referenceId;
    map['otp'] = otp;
    return map;
  }

}