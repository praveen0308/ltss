import 'package:flutter/material.dart';

class ErrorPageView extends StatelessWidget {
  final String? msg;
  final VoidCallback? onRetry;

  const ErrorPageView({super.key, this.msg, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          const Icon(
            Icons.error_rounded,
            size: 80,
          ),
          Text(msg ?? "Something went wrong!!!"),
          const Spacer(),
          if (onRetry != null)
            FilledButton(onPressed: onRetry, child: const Text("Retry"))
        ],
      ),
    );
  }
}
