import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/generated/assets.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/routes/routes.dart';
import 'package:ltss/ui/common/splash/splash_screen_cubit.dart';
import 'package:ltss/utils/utils.dart';

@RoutePage()
class SplashScreen extends StatefulWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SplashScreenCubit(RepositoryProvider.of<SessionManager>(context)),
      child: this,
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashScreenCubit>().loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashScreenCubit, SplashScreenState>(
        listener: (context, state) {
          if (state is NotLoggedIn) {
            AutoRouter.of(context).replace(const EnterMobileNumberRoute());
          }

          if (state is DataLoaded) {
            if (state.roleId == UserRole.admin.roleId) {
              AutoRouter.of(context).navigate(const DashboardRoute());
            } else {
              AutoRouter.of(context).navigate(const UserDashboardRoute());
            }
          }
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var mWidth = constraints.maxWidth;
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    const Spacer(),
                    Image.asset(
                      Assets.assetsIcLogo,
                    ),
                    const Spacer(),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      "Developed by FAL",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
