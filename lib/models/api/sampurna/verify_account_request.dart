class VerifyAccountRequest {
  VerifyAccountRequest({
      this.beneMobile, 
      this.beneAccountNumber, 
      this.bankName, 
      this.ifsc, 
      this.bankID, 
      this.transMode, 
      this.senderMobile, 
      this.referenceID, 
      this.sPKey, 
      this.aPIRequestID, 
      this.userID, 
      this.token, 
      this.outletID,});

  VerifyAccountRequest.fromJson(dynamic json) {
    beneMobile = json['BeneMobile'];
    beneAccountNumber = json['BeneAccountNumber'];
    bankName = json['BankName'];
    ifsc = json['IFSC'];
    bankID = json['BankID'];
    transMode = json['TransMode'];
    senderMobile = json['SenderMobile'];
    referenceID = json['ReferenceID'];
    sPKey = json['SPKey'];
    aPIRequestID = json['APIRequestID'];
    userID = json['UserID'];
    token = json['Token'];
    outletID = json['OutletID'];
  }
  String? beneMobile;
  String? beneAccountNumber;
  String? bankName;
  String? ifsc;
  int? bankID;
  int? transMode;
  String? senderMobile;
  String? referenceID;
  String? sPKey;
  String? aPIRequestID;
  int? userID;
  String? token;
  int? outletID;
VerifyAccountRequest copyWith({  String? beneMobile,
  String? beneAccountNumber,
  String? bankName,
  String? ifsc,
  int? bankID,
  int? transMode,
  String? senderMobile,
  String? referenceID,
  String? sPKey,
  String? aPIRequestID,
  int? userID,
  String? token,
  int? outletID,
}) => VerifyAccountRequest(  beneMobile: beneMobile ?? this.beneMobile,
  beneAccountNumber: beneAccountNumber ?? this.beneAccountNumber,
  bankName: bankName ?? this.bankName,
  ifsc: ifsc ?? this.ifsc,
  bankID: bankID ?? this.bankID,
  transMode: transMode ?? this.transMode,
  senderMobile: senderMobile ?? this.senderMobile,
  referenceID: referenceID ?? this.referenceID,
  sPKey: sPKey ?? this.sPKey,
  aPIRequestID: aPIRequestID ?? this.aPIRequestID,
  userID: userID ?? this.userID,
  token: token ?? this.token,
  outletID: outletID ?? this.outletID,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BeneMobile'] = beneMobile;
    map['BeneAccountNumber'] = beneAccountNumber;
    map['BankName'] = bankName;
    map['IFSC'] = ifsc;
    map['BankID'] = bankID;
    map['TransMode'] = transMode;
    map['SenderMobile'] = senderMobile;
    map['ReferenceID'] = referenceID;
    map['SPKey'] = sPKey;
    map['APIRequestID'] = aPIRequestID;
    map['UserID'] = userID;
    map['Token'] = token;
    map['OutletID'] = outletID;
    return map;
  }

}