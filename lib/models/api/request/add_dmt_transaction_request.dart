class AddDmtTransactionRequest {
  AddDmtTransactionRequest({
      this.serviceId, 
      this.senderName, 
      this.senderMobileNo, 
      this.beneficiaryId, 
      this.beneficiaryName, 
      this.accountNumber, 
      this.ifsc, 
      this.bankId, 
      this.bankName, 
      this.transMode, 
      this.amount,});

  AddDmtTransactionRequest.fromJson(dynamic json) {
    serviceId = json['service_id'];
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
  }
  int? serviceId;
  String? senderName;
  String? senderMobileNo;
  int? beneficiaryId;
  String? beneficiaryName;
  String? accountNumber;
  String? ifsc;
  int? bankId;
  String? bankName;
  String? transMode;
  int? amount;
AddDmtTransactionRequest copyWith({  int? serviceId,
  String? senderName,
  String? senderMobileNo,
  int? beneficiaryId,
  String? beneficiaryName,
  String? accountNumber,
  String? ifsc,
  int? bankId,
  String? bankName,
  String? transMode,
  int? amount,
}) => AddDmtTransactionRequest(  serviceId: serviceId ?? this.serviceId,
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
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = serviceId;
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
    return map;
  }

}