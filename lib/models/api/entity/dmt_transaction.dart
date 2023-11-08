class DmtTransaction {
  DmtTransaction({
      this.customerId, 
      this.transactionId, 
      this.amount, 
      this.status, 
      this.addedOn, 
      this.serviceId, 
      this.bankId, 
      this.extras, 
      this.addedBy,});

  DmtTransaction.fromJson(dynamic json) {
    customerId = json['customer_id'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    status = json['status'];
    addedOn = json['added_on'];
    serviceId = json['service_id'];
    bankId = json['bank_id'];
    extras = json['extras'];
    addedBy = json['added_by'];
  }
  int? customerId;
  int? transactionId;
  double? amount;
  String? status;
  String? addedOn;
  int? serviceId;
  int? bankId;
  String? extras;
  dynamic addedBy;
DmtTransaction copyWith({  int? customerId,
  int? transactionId,
  double? amount,
  String? status,
  String? addedOn,
  int? serviceId,
  int? bankId,
  String? extras,
  dynamic addedBy,
}) => DmtTransaction(  customerId: customerId ?? this.customerId,
  transactionId: transactionId ?? this.transactionId,
  amount: amount ?? this.amount,
  status: status ?? this.status,
  addedOn: addedOn ?? this.addedOn,
  serviceId: serviceId ?? this.serviceId,
  bankId: bankId ?? this.bankId,
  extras: extras ?? this.extras,
  addedBy: addedBy ?? this.addedBy,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customer_id'] = customerId;
    map['transaction_id'] = transactionId;
    map['amount'] = amount;
    map['status'] = status;
    map['added_on'] = addedOn;
    map['service_id'] = serviceId;
    map['bank_id'] = bankId;
    map['extras'] = extras;
    map['added_by'] = addedBy;
    return map;
  }

}