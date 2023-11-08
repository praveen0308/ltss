import 'package:flutter/material.dart';
import 'package:ltss/res/res.dart';

class HighlightedLabel extends StatelessWidget {
  final String text;
  final Color? color;

  const HighlightedLabel({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color ?? AppColors.primaryLightest,
            borderRadius: BorderRadius.circular(5)),
        padding: const EdgeInsets.all(5),
        child: Text(text.toUpperCase(), style: const TextStyle(fontSize: 13,color: Colors.black,fontWeight: FontWeight.w500)));
  }
}
