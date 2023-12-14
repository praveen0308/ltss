class Sender {
  Sender({
      this.senderName, 
      this.senderMobile, 
      this.availbleLimit, 
      this.totalLimit, 
      this.kycStatus, 
      this.referenceID, 
      this.isOTPRequired, 
      this.isSenderNotExists, 
      this.isEKYCAvailable, 
      this.isActive, 
      this.statuscode, 
      this.message, 
      this.errorCode, 
      this.note,});

  Sender.fromJson(dynamic json) {
    senderName = json['senderName'];
    senderMobile = json['senderMobile'];
    availbleLimit = json['availbleLimit'];
    totalLimit = json['totalLimit'];
    kycStatus = json['kycStatus'];
    referenceID = json['referenceID'];
    isOTPRequired = json['isOTPRequired'];
    isSenderNotExists = json['isSenderNotExists'];
    isEKYCAvailable = json['isEKYCAvailable'];
    isActive = json['isActive'];
    statuscode = json['statuscode'];
    message = json['message'];
    errorCode = json['errorCode'];
    note = json['note'];
  }
  String? senderName;
  String? senderMobile;
  double? availbleLimit;
  double? totalLimit;
  int? kycStatus;
  String? referenceID;
  bool? isOTPRequired;
  bool? isSenderNotExists;
  bool? isEKYCAvailable;
  bool? isActive;
  int? statuscode;
  String? message;
  int? errorCode;
  String? note;
Sender copyWith({  String? senderName,
  String? senderMobile,
  double? availbleLimit,
  double? totalLimit,
  int? kycStatus,
  String? referenceID,
  bool? isOTPRequired,
  bool? isSenderNotExists,
  bool? isEKYCAvailable,
  bool? isActive,
  int? statuscode,
  String? message,
  int? errorCode,
  String? note,
}) => Sender(  senderName: senderName ?? this.senderName,
  senderMobile: senderMobile ?? this.senderMobile,
  availbleLimit: availbleLimit ?? this.availbleLimit,
  totalLimit: totalLimit ?? this.totalLimit,
  kycStatus: kycStatus ?? this.kycStatus,
  referenceID: referenceID ?? this.referenceID,
  isOTPRequired: isOTPRequired ?? this.isOTPRequired,
  isSenderNotExists: isSenderNotExists ?? this.isSenderNotExists,
  isEKYCAvailable: isEKYCAvailable ?? this.isEKYCAvailable,
  isActive: isActive ?? this.isActive,
  statuscode: statuscode ?? this.statuscode,
  message: message ?? this.message,
  errorCode: errorCode ?? this.errorCode,
  note: note ?? this.note,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderName'] = senderName;
    map['senderMobile'] = senderMobile;
    map['availbleLimit'] = availbleLimit;
    map['totalLimit'] = totalLimit;
    map['kycStatus'] = kycStatus;
    map['referenceID'] = referenceID;
    map['isOTPRequired'] = isOTPRequired;
    map['isSenderNotExists'] = isSenderNotExists;
    map['isEKYCAvailable'] = isEKYCAvailable;
    map['isActive'] = isActive;
    map['statuscode'] = statuscode;
    map['message'] = message;
    map['errorCode'] = errorCode;
    map['note'] = note;
    return map;
  }

}