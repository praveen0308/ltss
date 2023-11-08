class UserStats {
  UserStats({
      this.userCount, 
      this.requestCount,});

  UserStats.fromJson(dynamic json) {
    userCount = json['user_count'];
    requestCount = json['request_count'];
  }
  int? userCount;
  int? requestCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_count'] = userCount;
    map['request_count'] = requestCount;
    return map;
  }

}