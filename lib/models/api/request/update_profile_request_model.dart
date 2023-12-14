class UpdateProfileRequestModel {
  UpdateProfileRequestModel({
      this.firstName,
      this.lastName,
      this.email,
      this.address,});

  UpdateProfileRequestModel.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    address = json['address'];
  }
  String? firstName;
  String? lastName;
  String? email;
  String? address;
UpdateProfileRequestModel copyWith({
  String? firstName,
  String? lastName,
  String? email,
  String? address,
}) => UpdateProfileRequestModel(
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  email: email ?? this.email,
  address: address ?? this.address,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['address'] = address;
    return map;
  }

}