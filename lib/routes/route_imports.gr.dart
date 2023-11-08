// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:ltss/base/base.dart' as _i14;
import 'package:ltss/ui/admin/dashboard/dashboard_screen.dart' as _i4;
import 'package:ltss/ui/common/add_user/add_user.dart' as _i2;
import 'package:ltss/ui/common/auth/enter_mobile_number/enter_mobile_number_screen.dart'
    as _i6;
import 'package:ltss/ui/common/auth/verify_otp/verify_otp_screen.dart' as _i11;
import 'package:ltss/ui/common/notifications/notifications_screen.dart' as _i7;
import 'package:ltss/ui/common/splash/splash_screen.dart' as _i8;
import 'package:ltss/ui/common/user_detail/user_detail_screen.dart' as _i10;
import 'package:ltss/ui/users/dashboard/user_dashboard_screen.dart' as _i9;
import 'package:ltss/ui/users/edit_profile/edit_profile.dart' as _i5;
import 'package:ltss/ui/users/pages/requests/add/add_fund_request_screen.dart'
    as _i1;
import 'package:ltss/ui/users/services/dmt/dmt_screen.dart' as _i3;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    AddFundRequestRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(child: const _i1.AddFundRequestScreen()),
      );
    },
    AddUserRoute.name: (routeData) {
      final args = routeData.argsAs<AddUserRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(
            child: _i2.AddUserScreen(
          key: args.key,
          userTypeAdding: args.userTypeAdding,
        )),
      );
    },
    DMTRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(child: const _i3.DMTScreen()),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(child: const _i4.DashboardScreen()),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(child: const _i5.EditProfileScreen()),
      );
    },
    EnterMobileNumberRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(child: const _i6.EnterMobileNumberScreen()),
      );
    },
    NotificationsRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.NotificationsScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(child: const _i8.SplashScreen()),
      );
    },
    UserDashboardRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(child: const _i9.UserDashboardScreen()),
      );
    },
    UserDetailRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(
            child: _i10.UserDetailScreen(
          key: args.key,
          userId: args.userId,
        )),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.WrappedRoute(
            child: _i11.VerifyOtpScreen(
          key: args.key,
          mobileNumber: args.mobileNumber,
        )),
      );
    },
  };
}

/// generated route for
/// [_i1.AddFundRequestScreen]
class AddFundRequestRoute extends _i12.PageRouteInfo<void> {
  const AddFundRequestRoute({List<_i12.PageRouteInfo>? children})
      : super(
          AddFundRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddFundRequestRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddUserScreen]
class AddUserRoute extends _i12.PageRouteInfo<AddUserRouteArgs> {
  AddUserRoute({
    _i13.Key? key,
    required _i14.UserRole userTypeAdding,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          AddUserRoute.name,
          args: AddUserRouteArgs(
            key: key,
            userTypeAdding: userTypeAdding,
          ),
          initialChildren: children,
        );

  static const String name = 'AddUserRoute';

  static const _i12.PageInfo<AddUserRouteArgs> page =
      _i12.PageInfo<AddUserRouteArgs>(name);
}

class AddUserRouteArgs {
  const AddUserRouteArgs({
    this.key,
    required this.userTypeAdding,
  });

  final _i13.Key? key;

  final _i14.UserRole userTypeAdding;

  @override
  String toString() {
    return 'AddUserRouteArgs{key: $key, userTypeAdding: $userTypeAdding}';
  }
}

/// generated route for
/// [_i3.DMTScreen]
class DMTRoute extends _i12.PageRouteInfo<void> {
  const DMTRoute({List<_i12.PageRouteInfo>? children})
      : super(
          DMTRoute.name,
          initialChildren: children,
        );

  static const String name = 'DMTRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.DashboardScreen]
class DashboardRoute extends _i12.PageRouteInfo<void> {
  const DashboardRoute({List<_i12.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.EditProfileScreen]
class EditProfileRoute extends _i12.PageRouteInfo<void> {
  const EditProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.EnterMobileNumberScreen]
class EnterMobileNumberRoute extends _i12.PageRouteInfo<void> {
  const EnterMobileNumberRoute({List<_i12.PageRouteInfo>? children})
      : super(
          EnterMobileNumberRoute.name,
          initialChildren: children,
        );

  static const String name = 'EnterMobileNumberRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.NotificationsScreen]
class NotificationsRoute extends _i12.PageRouteInfo<void> {
  const NotificationsRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SplashScreen]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.UserDashboardScreen]
class UserDashboardRoute extends _i12.PageRouteInfo<void> {
  const UserDashboardRoute({List<_i12.PageRouteInfo>? children})
      : super(
          UserDashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserDashboardRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.UserDetailScreen]
class UserDetailRoute extends _i12.PageRouteInfo<UserDetailRouteArgs> {
  UserDetailRoute({
    _i13.Key? key,
    required int userId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          UserDetailRoute.name,
          args: UserDetailRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailRoute';

  static const _i12.PageInfo<UserDetailRouteArgs> page =
      _i12.PageInfo<UserDetailRouteArgs>(name);
}

class UserDetailRouteArgs {
  const UserDetailRouteArgs({
    this.key,
    required this.userId,
  });

  final _i13.Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserDetailRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i11.VerifyOtpScreen]
class VerifyOtpRoute extends _i12.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i13.Key? key,
    required String mobileNumber,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          VerifyOtpRoute.name,
          args: VerifyOtpRouteArgs(
            key: key,
            mobileNumber: mobileNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyOtpRoute';

  static const _i12.PageInfo<VerifyOtpRouteArgs> page =
      _i12.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.mobileNumber,
  });

  final _i13.Key? key;

  final String mobileNumber;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}
