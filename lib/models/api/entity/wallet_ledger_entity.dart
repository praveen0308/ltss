class WalletLedgerEntity {
  WalletLedgerEntity({
      this.creditWalletType, 
      this.ledgerId, 
      this.debitedFrom, 
      this.amount, 
      this.referenceId, 
      this.creditedInto, 
      this.debitWalletType, 
      this.type, 
      this.addedOn,});

  WalletLedgerEntity.fromJson(dynamic json) {
    creditWalletType = json['credit_wallet_type'];
    ledgerId = json['ledger_id'];
    debitedFrom = json['debited_from'];
    amount = json['amount'];
    referenceId = json['reference_id'];
    creditedInto = json['credited_into'];
    debitWalletType = json['debit_wallet_type'];
    type = json['type'];
    addedOn = json['added_on'];
  }
  String? creditWalletType;
  int? ledgerId;
  int? debitedFrom;
  double? amount;
  int? referenceId;
  int? creditedInto;
  String? debitWalletType;
  String? type;
  String? addedOn;
WalletLedgerEntity copyWith({  String? creditWalletType,
  int? ledgerId,
  int? debitedFrom,
  double? amount,
  int? referenceId,
  int? creditedInto,
  String? debitWalletType,
  String? type,
  String? addedOn,
}) => WalletLedgerEntity(  creditWalletType: creditWalletType ?? this.creditWalletType,
  ledgerId: ledgerId ?? this.ledgerId,
  debitedFrom: debitedFrom ?? this.debitedFrom,
  amount: amount ?? this.amount,
  referenceId: referenceId ?? this.referenceId,
  creditedInto: creditedInto ?? this.creditedInto,
  debitWalletType: debitWalletType ?? this.debitWalletType,
  type: type ?? this.type,
  addedOn: addedOn ?? this.addedOn,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['credit_wallet_type'] = creditWalletType;
    map['ledger_id'] = ledgerId;
    map['debited_from'] = debitedFrom;
    map['amount'] = amount;
    map['reference_id'] = referenceId;
    map['credited_into'] = creditedInto;
    map['debit_wallet_type'] = debitWalletType;
    map['type'] = type;
    map['added_on'] = addedOn;
    return map;
  }

}