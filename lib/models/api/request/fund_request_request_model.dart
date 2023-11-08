class FundRequestRequestModel {
  FundRequestRequestModel({
      this.sender, 
      this.receiver, 
      this.amount,});

  FundRequestRequestModel.fromJson(dynamic json) {
    sender = json['sender'];
    receiver = json['receiver'];
    amount = json['amount'];
  }
  int? sender;
  int? receiver;
  double? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender'] = sender;
    map['receiver'] = receiver;
    map['amount'] = amount;
    return map;
  }

}