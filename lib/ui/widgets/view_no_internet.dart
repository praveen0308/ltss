import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.signal_wifi_connected_no_internet_4_rounded,size: 60,),
        const SizedBox(height: 16,),
        Text("OOPS!",style: Theme.of(context).textTheme.displayMedium,),
        const Text("Slow or No Internet Connection"),
        const Text("Please check your internet connection and then try again."),
        FilledButton(onPressed: (){}, child:const Text("Try Again!!!"))
      ],
    );
  }
}
