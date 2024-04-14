class FundRequestRequestModel {
  FundRequestRequestModel({
      this.sender, 
      this.receiver, 
      this.amount,
      this.comment,
  });

  FundRequestRequestModel.fromJson(dynamic json) {
    sender = json['sender'];
    receiver = json['receiver'];
    amount = json['amount'];
    comment = json['comment'];
  }
  int? sender;
  int? receiver;
  double? amount;
  String? comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender'] = sender;
    map['receiver'] = receiver;
    map['amount'] = amount;
    map['comment'] = comment;
    return map;
  }

}