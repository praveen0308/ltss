import 'package:flutter/material.dart';

enum AppStatus {
  requested("REQUESTED", 1, Colors.white,Colors.deepOrange),
  initiated("INITIATED", 1, Colors.white,Colors.deepOrange),
  approved("APPROVED", 2, Colors.white, Color(0xff009933)),
  rejected("REJECTED", 3, Colors.white, Color(0xffff0000)),
  revoked("REVOKED", 4, Colors.white, Color(0xffff0000)),
  done("DONE", 5, Colors.white, Color(0xff181A17)),
  doneNVerified("DONE & VERIFIED", 6, Colors.white, Color(0xff181A17));

  final String name;
  final int id;
  final Color textColor;
  final Color bgColor;

  const AppStatus(this.name, this.id, this.textColor, this.bgColor);

  factory AppStatus.fromString(String? status) {
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
