class CreateChargeRequestModel {
  CreateChargeRequestModel(
      {this.serviceId, this.name, this.value, this.isActive});

  CreateChargeRequestModel.fromJson(dynamic json) {
    serviceId = json['service_id'];
    name = json['name'];
    value = json['value'];
    isActive = json['is_active'];
  }

  int? serviceId;
  String? name;
  String? value;
  bool? isActive;

  CreateChargeRequestModel copyWith({
    int? serviceId,
    String? name,
    String? value,
    bool? isActive,
  }) =>
      CreateChargeRequestModel(
        serviceId: serviceId ?? this.serviceId,
        name: name ?? this.name,
        value: value ?? this.value,
        isActive: isActive ?? this.isActive,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = serviceId;
    map['name'] = name;
    map['value'] = value;
    map['is_active'] = isActive;
    return map;
  }
}
