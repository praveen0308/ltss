
class RequestOtpResponse {
  RequestOtpResponse({
    this.expireOn,
    this.remainingAttempts,
  });

  RequestOtpResponse.fromJson(dynamic json) {
    expireOn = json['expire_on'];
    remainingAttempts = json['remaining_attempts'];
  }

  String? expireOn;
  int? remainingAttempts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['expire_on'] = expireOn;
    map['remaining_attempts'] = remainingAttempts;
    return map;
  }
}
