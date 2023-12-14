class GetBeneficiaryResponse {
  GetBeneficiaryResponse({
      this.beneficiaries, 
      this.statuscode, 
      this.message, 
      this.errorCode,});

  GetBeneficiaryResponse.fromJson(dynamic json) {
    if (json['beneficiaries'] != null) {
      beneficiaries = [];
      json['beneficiaries'].forEach((v) {
        beneficiaries?.add(Beneficiary.fromJson(v));
      });
    }
    statuscode = json['statuscode'];
    message = json['message'];
    errorCode = json['errorCode'];
  }
  List<Beneficiary>? beneficiaries;
  int? statuscode;
  String? message;
  int? errorCode;
GetBeneficiaryResponse copyWith({  List<Beneficiary>? beneficiaries,
  int? statuscode,
  String? message,
  int? errorCode,
}) => GetBeneficiaryResponse(  beneficiaries: beneficiaries ?? this.beneficiaries,
  statuscode: statuscode ?? this.statuscode,
  message: message ?? this.message,
  errorCode: errorCode ?? this.errorCode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (beneficiaries != null) {
      map['beneficiaries'] = beneficiaries?.map((v) => v.toJson()).toList();
    }
    map['statuscode'] = statuscode;
    map['message'] = message;
    map['errorCode'] = errorCode;
    return map;
  }

}

class Beneficiary {
  Beneficiary({
      this.mobileNo, 
      this.beneName, 
      this.ifsc, 
      this.accountNo, 
      this.bankName, 
      this.bankID, 
      this.beneID, 
      this.isVerified, 
      this.transMode, 
      this.impsStatus, 
      this.neftStatus,});

  Beneficiary.fromJson(dynamic json) {
    mobileNo = json['mobileNo'];
    beneName = json['beneName'];
    ifsc = json['ifsc'];
    accountNo = json['accountNo'];
    bankName = json['bankName'];
    bankID = json['bankID'];
    beneID = json['beneID'];
    isVerified = json['isVerified'];
    transMode = json['transMode'];
    impsStatus = json['impsStatus'];
    neftStatus = json['neftStatus'];
  }
  String? mobileNo;
  String? beneName;
  String? ifsc;
  String? accountNo;
  String? bankName;
  int? bankID;
  String? beneID;
  bool? isVerified;
  int? transMode;
  bool? impsStatus;
  bool? neftStatus;
Beneficiary copyWith({  String? mobileNo,
  String? beneName,
  String? ifsc,
  String? accountNo,
  String? bankName,
  int? bankID,
  String? beneID,
  bool? isVerified,
  int? transMode,
  bool? impsStatus,
  bool? neftStatus,
}) => Beneficiary(  mobileNo: mobileNo ?? this.mobileNo,
  beneName: beneName ?? this.beneName,
  ifsc: ifsc ?? this.ifsc,
  accountNo: accountNo ?? this.accountNo,
  bankName: bankName ?? this.bankName,
  bankID: bankID ?? this.bankID,
  beneID: beneID ?? this.beneID,
  isVerified: isVerified ?? this.isVerified,
  transMode: transMode ?? this.transMode,
  impsStatus: impsStatus ?? this.impsStatus,
  neftStatus: neftStatus ?? this.neftStatus,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobileNo'] = mobileNo;
    map['beneName'] = beneName;
    map['ifsc'] = ifsc;
    map['accountNo'] = accountNo;
    map['bankName'] = bankName;
    map['bankID'] = bankID;
    map['beneID'] = beneID;
    map['isVerified'] = isVerified;
    map['transMode'] = transMode;
    map['impsStatus'] = impsStatus;
    map['neftStatus'] = neftStatus;
    return map;
  }

}