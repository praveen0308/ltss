class BankEntity {
  BankEntity({
      this.name, 
      this.isActive, 
      this.bankId,});

  BankEntity.fromJson(dynamic json) {
    name = json['name'];
    isActive = json['is_active'];
    bankId = json['bank_id'];
  }
  String? name;
  bool? isActive;
  int? bankId;
BankEntity copyWith({  String? name,
  bool? isActive,
  int? bankId,
}) => BankEntity(  name: name ?? this.name,
  isActive: isActive ?? this.isActive,
  bankId: bankId ?? this.bankId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['is_active'] = isActive;
    map['bank_id'] = bankId;
    return map;
  }

}