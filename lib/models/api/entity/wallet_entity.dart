class WalletEntity {
  WalletEntity({
      this.balance, 
      this.isActive, 
      this.id, 
      this.name,});

  WalletEntity.fromJson(dynamic json) {
    balance = json['balance'];
    isActive = json['is_active'];
    id = json['id'];
    name = json['name'];
  }
  double? balance;
  bool? isActive;
  String? id;
  String? name;
WalletEntity copyWith({  double? balance,
  bool? isActive,
  String? id,
  String? name,
}) => WalletEntity(  balance: balance ?? this.balance,
  isActive: isActive ?? this.isActive,
  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = balance;
    map['is_active'] = isActive;
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}