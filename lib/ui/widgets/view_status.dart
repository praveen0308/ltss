import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  final bool status;
  const StatusView({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: status
              ? Colors.green
              : Colors.red,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        status ? "ACTIVE" : "INACTIVE",
        style: const TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }
}
