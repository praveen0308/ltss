
import '../../../utils/date_time_helper.dart';

class FundRequestEntity {
  FundRequestEntity({
      this.requestId, 
      this.senderId, 
      this.receiverId, 
      this.amount, 
      this.status, 
      this.addedOn, 
      this.sender, 
      this.receiver,});

  FundRequestEntity.fromJson(dynamic json) {
    requestId = json['request_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    amount = json['amount'];
    status = json['status'];
    addedOn = json['added_on'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
  }
  int? requestId;
  num? senderId;
  num? receiverId;
  num? amount;
  String? status;
  String? addedOn;
  Sender? sender;
  Receiver? receiver;
FundRequestEntity copyWith({  int? requestId,
  num? senderId,
  num? receiverId,
  num? amount,
  String? status,
  String? addedOn,
  Sender? sender,
  Receiver? receiver,
}) => FundRequestEntity(  requestId: requestId ?? this.requestId,
  senderId: senderId ?? this.senderId,
  receiverId: receiverId ?? this.receiverId,
  amount: amount ?? this.amount,
  status: status ?? this.status,
  addedOn: addedOn ?? this.addedOn,
  sender: sender ?? this.sender,
  receiver: receiver ?? this.receiver,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['request_id'] = requestId;
    map['sender_id'] = senderId;
    map['receiver_id'] = receiverId;
    map['amount'] = amount;
    map['status'] = status;
    map['added_on'] = addedOn;
    if (sender != null) {
      map['sender'] = sender?.toJson();
    }
    if (receiver != null) {
      map['receiver'] = receiver?.toJson();
    }
    return map;
  }

  String getFormattedAddedOn(){
    if(addedOn!=null && addedOn!.isNotEmpty){
      return DateTimeHelper.formatISOTime(addedOn!);
    }else{
      return "NIL";
    }

  }
  bool isRequested()=>status == "REQUESTED";
}

class Receiver {
  Receiver({
      this.firstName,
      this.lastName,
      this.mobileNo,
      this.roleId,});

  Receiver.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    roleId = json['role_id'];
  }
  String? firstName;
  String? lastName;
  String? mobileNo;
  int? roleId;
Receiver copyWith({
  String? firstName,
  String? lastName,
  String? mobileNo,
  int? roleId,
}) => Receiver(
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  mobileNo: mobileNo ?? this.mobileNo,
  roleId: roleId ?? this.roleId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['mobile_no'] = mobileNo;
    map['role_id'] = roleId;
    return map;
  }

  @override
  String toString() {
    return "$firstName $lastName".toString();
  }

}

class Sender {
  Sender({
    this.firstName,
    this.lastName,
    this.mobileNo,
    this.roleId,});

  Sender.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    roleId = json['role_id'];
  }
  String? firstName;
  String? lastName;
  String? mobileNo;
  int? roleId;
  Sender copyWith({
    String? firstName,
    String? lastName,
    String? mobileNo,
    int? roleId,
  }) => Sender(
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    mobileNo: mobileNo ?? this.mobileNo,
    roleId: roleId ?? this.roleId,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['mobile_no'] = mobileNo;
    map['role_id'] = roleId;
    return map;
  }

  @override
  String toString() {
    return "$firstName $lastName".toString();
  }


}