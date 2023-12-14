import 'package:flutter/material.dart';

class LoadingButtonView extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final bool? enabled;

  const LoadingButtonView(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.isLoading,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
            visible: !isLoading,
            child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                    onPressed: enabled == true ? onPressed : null,
                    child: Text(text)))),
        Visibility(
            visible: isLoading,
            child: const Center(
              child: FittedBox(child: CircularProgressIndicator()),
            ))
      ],
    );
  }
}
