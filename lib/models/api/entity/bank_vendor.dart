import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';

class BankVendor {
  BankVendor({
      this.bankId, 
      this.vendorId, 
      this.bank, 
      this.vendor,});

  BankVendor.fromJson(dynamic json) {
    bankId = json['bank_id'];
    vendorId = json['vendor_id'];
    bank = BankEntity.fromJson(json['bank']);
    vendor =UserEntity.fromJson(json['vendor']);
  }
  int? bankId;
  int? vendorId;
  BankEntity? bank;
  UserEntity? vendor;
BankVendor copyWith({  int? bankId,
  int? vendorId,
  BankEntity? bank,
  UserEntity? vendor,
}) => BankVendor(  bankId: bankId ?? this.bankId,
  vendorId: vendorId ?? this.vendorId,
  bank: bank ?? this.bank,
  vendor: vendor ?? this.vendor,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bank_id'] = bankId;
    map['vendor_id'] = vendorId;
    map['bank'] = bank?.toJson();
    map['vendor'] = vendor?.toJson();
    return map;
  }

}