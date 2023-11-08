class PostKycResponse {
  PostKycResponse({
      this.aadhaarNo, 
      this.userId, 
      this.pan, 
      this.profileImage, 
      this.shopImage, 
      this.id, 
      this.addedOn, 
      this.addedBy,});

  PostKycResponse.fromJson(dynamic json) {
    aadhaarNo = json['aadhaar_no'];
    userId = json['user_id'];
    pan = json['pan'];
    profileImage = json['profile_image'];
    shopImage = json['shop_image'];
    id = json['id'];
    addedOn = json['added_on'];
    addedBy = json['added_by'];
  }
  String? aadhaarNo;
  int? userId;
  String? pan;
  String? profileImage;
  String? shopImage;
  int? id;
  String? addedOn;
  String? addedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aadhaar_no'] = aadhaarNo;
    map['user_id'] = userId;
    map['pan'] = pan;
    map['profile_image'] = profileImage;
    map['shop_image'] = shopImage;
    map['id'] = id;
    map['added_on'] = addedOn;
    map['added_by'] = addedBy;
    return map;
  }

}