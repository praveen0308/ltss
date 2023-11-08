class CreateCommissionRequestModel {
  CreateCommissionRequestModel({
      this.serviceId, 
      this.name, 
      this.value,this.isActive});

  CreateCommissionRequestModel.fromJson(dynamic json) {
    serviceId = json['service_id'];
    name = json['name'];
    value = json['value'];
    isActive = json['is_active'];
  }
  int? serviceId;
  String? name;
  String? value;
  bool? isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = serviceId;
    map['name'] = name;
    map['value'] = value;
    map['is_active'] = isActive;
    return map;
  }

}