import 'package:flutter/material.dart';

class LoadingButtonView extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const LoadingButtonView(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
            visible: !isLoading,
            child: SizedBox(width: double.infinity,child: FilledButton(onPressed: onPressed, child: Text(text)))),
        Visibility(
            visible: isLoading,
            child: const Center(
              child: FittedBox(child: CircularProgressIndicator()),
            ))
      ],
    );
  }
}
