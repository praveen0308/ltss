import 'package:ltss/models/api/entity/user_entity.dart';

import '../../../utils/date_time_helper.dart';

class DmtTransaction {
  DmtTransaction({
      this.serviceId,
      this.transactionId,
      this.vendorId,
      this.senderName,
      this.senderMobileNo, 
      this.beneficiaryId, 
      this.beneficiaryName, 
      this.accountNumber, 
      this.ifsc, 
      this.bankId, 
      this.bankName, 
      this.transMode, 
      this.amount, 
      this.commission, 
      this.charge, 
      this.status, 
      this.comment, 
      this.addedOn, 
      this.modifiedOn, 
      this.addedBy, 
      this.modifiedBy,
      this.retailer,
      this.vendor,

  });

  DmtTransaction.fromJson(dynamic json) {
    serviceId = json['service_id'];
    transactionId = json['transaction_id'];
    vendorId = json['vendor_id'];
    senderName = json['sender_name'];
    senderMobileNo = json['sender_mobile_no'];
    beneficiaryId = json['beneficiary_id'];
    beneficiaryName = json['beneficiary_name'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    bankId = json['bank_id'];
    bankName = json['bank_name'];
    transMode = json['trans_mode'];
    amount = json['amount'];
    commission = json['commission'];
    charge = json['charge'];
    status = json['status'];
    comment = json['comment'];
    addedOn = json['added_on'];
    modifiedOn = json['modified_on'];
    addedBy = json['added_by'];
    modifiedBy = json['modified_by'];
    retailer = UserEntity.fromJson(json['retailer']);
    vendor = json['vendor'] !=null ? UserEntity.fromJson(json['vendor']):null;

  }
  int? serviceId;
  int? transactionId;
  int? vendorId;
  String? senderName;
  String? senderMobileNo;
  int? beneficiaryId;
  String? beneficiaryName;
  String? accountNumber;
  String? ifsc;
  int? bankId;
  String? bankName;
  int? transMode;
  double? amount;
  double? commission;
  double? charge;
  String? status;
  String? comment;
  String? addedOn;
  String? modifiedOn;
  int? addedBy;
  int? modifiedBy;
  UserEntity? retailer;
  UserEntity? vendor;
DmtTransaction copyWith({
  int? serviceId,
  int? transactionId,
  int? vendorId,
  String? senderName,
  String? senderMobileNo,
  int? beneficiaryId,
  String? beneficiaryName,
  String? accountNumber,
  String? ifsc,
  int? bankId,
  String? bankName,
  int? transMode,
  double? amount,
  double? commission,
  double? charge,
  String? status,
  String? comment,
  String? addedOn,
  String? modifiedOn,
  int? addedBy,
  int? modifiedBy,
  UserEntity? retailer,
  UserEntity? vendor,

}) => DmtTransaction(
  serviceId: serviceId ?? this.serviceId,
  transactionId: transactionId ?? this.transactionId,
  vendorId: vendorId ?? this.vendorId,
  senderName: senderName ?? this.senderName,
  senderMobileNo: senderMobileNo ?? this.senderMobileNo,
  beneficiaryId: beneficiaryId ?? this.beneficiaryId,
  beneficiaryName: beneficiaryName ?? this.beneficiaryName,
  accountNumber: accountNumber ?? this.accountNumber,
  ifsc: ifsc ?? this.ifsc,
  bankId: bankId ?? this.bankId,
  bankName: bankName ?? this.bankName,
  transMode: transMode ?? this.transMode,
  amount: amount ?? this.amount,
  commission: commission ?? this.commission,
  charge: charge ?? this.charge,
  status: status ?? this.status,
  comment: comment ?? this.comment,
  addedOn: addedOn ?? this.addedOn,
  modifiedOn: modifiedOn ?? this.modifiedOn,
  addedBy: addedBy ?? this.addedBy,
  modifiedBy: modifiedBy ?? this.modifiedBy,
  retailer: retailer ?? this.retailer,
  vendor: vendor ?? this.vendor,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = serviceId;
    map['transaction_id'] = transactionId;
    map['vendor_id'] = vendorId;
    map['sender_name'] = senderName;
    map['sender_mobile_no'] = senderMobileNo;
    map['beneficiary_id'] = beneficiaryId;
    map['beneficiary_name'] = beneficiaryName;
    map['account_number'] = accountNumber;
    map['ifsc'] = ifsc;
    map['bank_id'] = bankId;
    map['bank_name'] = bankName;
    map['trans_mode'] = transMode;
    map['amount'] = amount;
    map['commission'] = commission;
    map['charge'] = charge;
    map['status'] = status;
    map['comment'] = comment;
    map['added_on'] = addedOn;
    map['modified_on'] = modifiedOn;
    map['added_by'] = addedBy;
    map['modified_by'] = modifiedBy;
    map['retailer'] = retailer?.toJson();
    map['vendor'] = vendor?.toJson();
    return map;
  }

  String getCustomer(){
    return "$senderName\n$senderMobileNo";
  }
  String getRetailer(){
    return "${retailer?.firstName} ${retailer?.lastName}\n${retailer?.mobileNo}";
  }
  String? getVendor(){
    if(vendor!=null){
      return "${vendor?.firstName} ${vendor?.lastName}\n${vendor?.mobileNo}";
    }else{
      return null;
    }

  }
  String getBeneficiary(){
    return "$beneficiaryName\n$bankName\n$accountNumber\n$ifsc";
  }
  String getTransMode(){
    if(transMode==1){
      return "IMPS";
    }else{
      return "NEFT";
    }
  }

  String getFormattedAddedOn(){
    if(addedOn!=null && addedOn!.isNotEmpty){
      return DateTimeHelper.formatISOTime(addedOn!);
    }else{
      return "NIL";
    }

  }
  String getFormattedModifiedOn(){
    if(addedOn!=null && addedOn!.isNotEmpty){
      return DateTimeHelper.formatISOTime(addedOn!);
    }else{
      return "NIL";
    }
  }
}