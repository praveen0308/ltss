import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{
  UserEntity({
      this.id, 
      this.mobileNo, 
      this.address, 
      this.dob,
      this.roleId,
      this.isActive, 
      this.addedBy, 
      this.email, 
      this.lastName, 
      this.firstName, 
      this.pincode, 
      this.restrictions,
  });

  UserEntity.fromJson(dynamic json) {
    id = json['id'];
    mobileNo = json['mobile_no'];
    address = json['address'];
    dob = json['dob'];
    roleId = json['role_id'];
    isActive = json['is_active'];
    addedBy = json['added_by'];
    email = json['email'];
    lastName = json['last_name'];
    firstName = json['first_name'];
    pincode = json['pincode'];
    restrictions = json['restrictions'];
  }
  int? id;
  String? mobileNo;
  String? address;
  String? dob;
  int? roleId;
  bool? isActive;
  dynamic addedBy;
  String? email;
  String? lastName;
  String? firstName;
  String? pincode;
  dynamic restrictions;
UserEntity copyWith({  int? id,
  String? mobileNo,
  String? address,
  String? dob,
  int? roleId,
  bool? isActive,
  dynamic addedBy,
  String? email,
  String? lastName,
  String? firstName,
  String? pincode,
  dynamic restrictions,
}) => UserEntity(  id: id ?? this.id,
  mobileNo: mobileNo ?? this.mobileNo,
  address: address ?? this.address,
  dob: dob ?? this.dob,
  roleId: roleId ?? this.roleId,
  isActive: isActive ?? this.isActive,
  addedBy: addedBy ?? this.addedBy,
  email: email ?? this.email,
  lastName: lastName ?? this.lastName,
  firstName: firstName ?? this.firstName,
  pincode: pincode ?? this.pincode,
  restrictions: restrictions ?? this.restrictions,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mobile_no'] = mobileNo;
    map['address'] = address;
    map['dob'] = dob;
    map['role_id'] = roleId;
    map['is_active'] = isActive;
    map['added_by'] = addedBy;
    map['email'] = email;
    map['last_name'] = lastName;
    map['first_name'] = firstName;
    map['pincode'] = pincode;
    map['restrictions'] = restrictions;
    return map;
  }

  String getName()=>"$firstName $lastName";

  @override
  List<Object?> get props => [id];

  @override
  String toString() {
    return getName();
  }
}