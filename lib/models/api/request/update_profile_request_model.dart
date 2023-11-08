class UpdateProfileRequestModel {
  UpdateProfileRequestModel({
      this.name, 
      this.email, 
      this.address,});

  UpdateProfileRequestModel.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
  }
  String? name;
  String? email;
  String? address;
UpdateProfileRequestModel copyWith({  String? name,
  String? email,
  String? address,
}) => UpdateProfileRequestModel(  name: name ?? this.name,
  email: email ?? this.email,
  address: address ?? this.address,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['address'] = address;
    return map;
  }

}