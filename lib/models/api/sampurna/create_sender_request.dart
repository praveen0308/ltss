class CreateSenderRequest {
  CreateSenderRequest({
      this.firstName, 
      this.lastName, 
      this.pincode, 
      this.address, 
      this.dob, 
      this.mobileNo, 
      this.referenceId,});

  CreateSenderRequest.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    pincode = json['pincode'];
    address = json['address'];
    dob = json['dob'];
    mobileNo = json['mobile_no'];
    referenceId = json['reference_id'];
  }
  String? firstName;
  String? lastName;
  String? pincode;
  String? address;
  String? dob;
  String? mobileNo;
  String? referenceId;
CreateSenderRequest copyWith({  String? firstName,
  String? lastName,
  String? pincode,
  String? address,
  String? dob,
  String? mobileNo,
  String? referenceId,
}) => CreateSenderRequest(  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  pincode: pincode ?? this.pincode,
  address: address ?? this.address,
  dob: dob ?? this.dob,
  mobileNo: mobileNo ?? this.mobileNo,
  referenceId: referenceId ?? this.referenceId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['pincode'] = pincode;
    map['address'] = address;
    map['dob'] = dob;
    map['mobile_no'] = mobileNo;
    map['reference_id'] = referenceId;
    return map;
  }

}