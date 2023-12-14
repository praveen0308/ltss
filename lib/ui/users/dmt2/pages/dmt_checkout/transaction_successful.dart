import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class TransactionSuccessScreen extends StatelessWidget {
  const TransactionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            const Icon(
              Icons.check_circle_rounded,
              size: 100,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("Transaction done successfully!!!",textAlign: TextAlign.center,style: TextStyle(fontSize: 18),),
            const Spacer(),
            FilledButton(onPressed: () {
              AutoRouter.of(context).pop();
            }, child: const Text("Continue"))
          ],
        ),
      ),
    ));
  }
}
