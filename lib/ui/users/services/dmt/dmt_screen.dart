import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/ui/users/services/dmt/dmt_cubit.dart';

@RoutePage()
class DMTScreen extends StatefulWidget implements AutoRouteWrapper {
  const DMTScreen({super.key});

  @override
  State<DMTScreen> createState() => _DMTScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => DmtCubit(),
      child: this,
    );
  }
}

class _DMTScreenState extends State<DMTScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("DMT"),
      ),
    ));
  }
}
