class BankEntity {
  BankEntity({
    this.name,
    this.isActive,
    this.bankId,
    this.code,
    this.min,
    this.max,
    this.ifsc,
  });

  BankEntity.fromJson(dynamic json) {
    name = json['name'];
    isActive = json['is_active'];
    bankId = json['bank_id'];
    code = json['code'];
    min = json['min'];
    max = json['max'];
    ifsc = json['ifsc'];
  }

  String? name;
  bool? isActive;
  int? bankId;
  int? code;
  double? min;
  double? max;
  String? ifsc;

  BankEntity copyWith({
    String? name,
    bool? isActive,
    int? bankId,
    int? code,
    double? min,
    double? max,
    String? ifsc,
  }) =>
      BankEntity(
        name: name ?? this.name,
        isActive: isActive ?? this.isActive,
        bankId: bankId ?? this.bankId,
        code: code ?? this.code,
        min: min ?? this.min,
        max: max ?? this.max,
        ifsc: ifsc ?? this.ifsc,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['is_active'] = isActive;
    map['bank_id'] = bankId;
    map['code'] = code;
    map['min'] = min;
    map['max'] = max;
    map['ifsc'] = ifsc;
    return map;
  }

  @override
  String toString() {

    return name.toString();
  }
}
