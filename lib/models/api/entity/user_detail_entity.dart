class UserDetailEntity {
  UserDetailEntity({
      this.id, 
      this.name, 
      this.mobileNo, 
      this.email, 
      this.address,
      this.roleId,
      this.restrictions, 
      this.isActive, 
      this.walletBalance, 
      this.userCount, 
      this.requestCount, 
      this.aadhaar, 
      this.pan, 
      this.shopImage, 
      this.profileImage,});

  UserDetailEntity.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    address = json['address'];
    roleId = json['role_id'];
    restrictions = json['restrictions'];
    isActive = json['is_active'];
    walletBalance = json['wallet_balance'];
    userCount = json['user_count'];
    requestCount = json['request_count'];
    aadhaar = json['aadhaar'];
    pan = json['pan'];
    shopImage = json['shop_image'];
    profileImage = json['profile_image'];
  }
  num? id;
  String? name;
  String? mobileNo;
  String? email;
  String? address;
  num? roleId;
  dynamic restrictions;
  bool? isActive;
  num? walletBalance;
  num? userCount;
  num? requestCount;
  dynamic aadhaar;
  dynamic pan;
  dynamic shopImage;
  dynamic profileImage;
UserDetailEntity copyWith({  num? id,
  String? name,
  String? mobileNo,
  String? email,
  String? address,
  num? roleId,
  dynamic restrictions,
  bool? isActive,
  num? walletBalance,
  num? userCount,
  num? requestCount,
  dynamic aadhaar,
  dynamic pan,
  dynamic shopImage,
  dynamic profileImage,
}) => UserDetailEntity(  id: id ?? this.id,
  name: name ?? this.name,
  mobileNo: mobileNo ?? this.mobileNo,
  email: email ?? this.email,
  address: address ?? this.address,
  roleId: roleId ?? this.roleId,
  restrictions: restrictions ?? this.restrictions,
  isActive: isActive ?? this.isActive,
  walletBalance: walletBalance ?? this.walletBalance,
  userCount: userCount ?? this.userCount,
  requestCount: requestCount ?? this.requestCount,
  aadhaar: aadhaar ?? this.aadhaar,
  pan: pan ?? this.pan,
  shopImage: shopImage ?? this.shopImage,
  profileImage: profileImage ?? this.profileImage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['mobile_no'] = mobileNo;
    map['email'] = email;
    map['address'] = address;
    map['role_id'] = roleId;
    map['restrictions'] = restrictions;
    map['is_active'] = isActive;
    map['wallet_balance'] = walletBalance;
    map['user_count'] = userCount;
    map['request_count'] = requestCount;
    map['aadhaar'] = aadhaar;
    map['pan'] = pan;
    map['shop_image'] = shopImage;
    map['profile_image'] = profileImage;
    return map;
  }

}