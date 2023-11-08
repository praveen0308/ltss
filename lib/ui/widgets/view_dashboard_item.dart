import 'package:flutter/material.dart';

import '../../res/colors.dart';

class DashboardItemView extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onClick;

  const DashboardItemView(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppColors.primaryLightest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primaryColor, width: 1.5)),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              subTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
