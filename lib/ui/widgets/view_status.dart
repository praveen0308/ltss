import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  final bool status;
  final String? text;

  const StatusView({super.key, required this.status, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: status ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        text != null
            ? text.toString()
            : status
                ? "ACTIVE"
                : "INACTIVE",
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
