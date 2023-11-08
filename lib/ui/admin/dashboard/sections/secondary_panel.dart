import 'package:flutter/material.dart';

class SecondaryPanel extends StatelessWidget {
  final Widget? body;
  const SecondaryPanel({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: body ?? const Center(
        child: Text("Empty"),
      ),
    );
  }
}
