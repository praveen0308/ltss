import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltss/models/enums.dart';

class HighlightedLabel extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;

  const HighlightedLabel(
      {super.key, required this.text, this.bgColor, this.textColor});

  factory HighlightedLabel.fromAppStatus(AppStatus appStatus) =>
      HighlightedLabel(
          text: appStatus.name,
          bgColor: appStatus.bgColor,
          textColor: appStatus.textColor);

  @override
  Widget build(BuildContext context) {
    var status = AppStatus.fromString(text);

    return Container(
        decoration: BoxDecoration(
          color: bgColor ?? status.bgColor,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.all(5),
        child: Text(text.toUpperCase(),
            style: GoogleFonts.aBeeZee(
                fontSize: 12,
                color: textColor ?? status.textColor,
                fontWeight: FontWeight.bold)));
  }
}
