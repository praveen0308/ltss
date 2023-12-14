import 'package:ltss/base/base.dart';

class BeneficiaryEntity {
  final String? id;
  final String? name;
  final String? accountNumber;
  final String? bank;
  final String? ifscCode;
  final String? mobileNumber;

  BeneficiaryEntity(
      {this.id,
      this.name,
      this.accountNumber,
      this.bank,
      this.ifscCode,
      this.mobileNumber});

  String subtitle() {
    return "$bank - ${accountNumber?.take(4)}";
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'accountNumber': accountNumber,
      'bank': bank,
      'ifscCode': ifscCode,
      'mobileNumber': mobileNumber,
    };
  }

  factory BeneficiaryEntity.fromJson(Map<String, dynamic> map) {
    return BeneficiaryEntity(
      id: map['id'] as String,
      name: map['name'] as String,
      accountNumber: map['accountNumber'] as String,
      bank: map['bank'] as String,
      ifscCode: map['ifscCode'] as String,
      mobileNumber: map['mobileNumber'] as String,
    );
  }
}
