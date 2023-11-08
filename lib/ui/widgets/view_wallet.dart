import 'package:flutter/material.dart';
import 'package:ltss/res/colors.dart';

class WalletView extends StatelessWidget {
  final num balance;
  const WalletView({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryLightest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.primaryColor,width: 1.5)

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Wallet Balance : ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          Text("₹$balance",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 24),)
        ],
      ),
    );
  }
}
