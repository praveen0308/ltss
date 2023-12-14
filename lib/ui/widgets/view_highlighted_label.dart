import 'package:flutter/material.dart';
import 'package:ltss/models/enums.dart';
import 'package:ltss/res/res.dart';

class HighlightedLabel extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;

  const HighlightedLabel(
      {super.key, required this.text, this.bgColor, this.textColor});



  @override
  Widget build(BuildContext context) {
    var status = AppStatus.getStatus(text);

    return Container(
        decoration: BoxDecoration(
            color: bgColor ?? status.bgColor,
            borderRadius: BorderRadius.circular(5),border: Border.all(color:textColor ?? status.textColor, )),
        padding: const EdgeInsets.all(5),
        child: Text(text.toUpperCase(),
            style: TextStyle(
                fontSize: 13,
                color: textColor ?? status.textColor,
                fontWeight: FontWeight.w500)));
  }
}
