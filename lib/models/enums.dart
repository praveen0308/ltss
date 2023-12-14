import 'package:flutter/material.dart';

enum AppStatus {
  requested("REQUESTED", 1, Colors.deepOrange, Color(0xffffc2b3)),
  initiated("INITIATED", 1, Colors.deepOrange, Color(0xffffc2b3)),
  approved("APPROVED", 2, Color(0xff009933), Color(0xffb3ffcc)),
  rejected("REJECTED", 3, Color(0xffff0000), Color(0xffffb3b3)),
  revoked("REVOKED", 4, Color(0xff4d4d4d), Color(0xffd9d9d9));

  final String name;
  final int id;
  final Color textColor;
  final Color bgColor;

  const AppStatus(this.name, this.id, this.textColor, this.bgColor);

  factory AppStatus.getStatus(String? status) {
    for (AppStatus e in AppStatus.values) {
      if (e.name == status) {
        return e;
      }
    }

    return AppStatus.requested;
  }
}

enum AppService {
  dmt(1, "DMT", "dmt");

  final int id;
  final String name;
  final String code;

  const AppService(this.id, this.name, this.code);
}
