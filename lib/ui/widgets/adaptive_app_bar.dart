import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../admin/dashboard/bloc/dashboard_screen_bloc.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const AdaptiveAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: Platform.isAndroid,
      actions: [
        if(Platform.isWindows)IconButton(
            onPressed: () {
              context.read<DashboardScreenBloc>().add(Empty());
            },
            icon: const Icon(Icons.close))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
