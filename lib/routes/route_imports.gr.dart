// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:flutter/material.dart' as _i26;
import 'package:ltss/base/base.dart' as _i27;
import 'package:ltss/models/api/entity/fund_request_entity.dart' as _i31;
import 'package:ltss/models/api/entity/user_entity.dart' as _i28;
import 'package:ltss/models/api/sampurna/get_beneficiary_response.dart' as _i30;
import 'package:ltss/models/api/sampurna/sender.dart' as _i29;
import 'package:ltss/ui/admin/dashboard/dashboard_screen.dart' as _i7;
import 'package:ltss/ui/admin/manage_dmt/manage_charge/manage_charge.dart'
    as _i12;
import 'package:ltss/ui/admin/manage_dmt/manage_commission/manage_commission.dart'
    as _i13;
import 'package:ltss/ui/common/add_user/add_user.dart' as _i4;
import 'package:ltss/ui/common/auth/enter_mobile_number/enter_mobile_number_screen.dart'
    as _i9;
import 'package:ltss/ui/common/auth/verify_otp/verify_otp_screen.dart' as _i24;
import 'package:ltss/ui/common/notifications/notifications_screen.dart' as _i15;
import 'package:ltss/ui/common/splash/splash_screen.dart' as _i19;
import 'package:ltss/ui/common/user_detail/user_detail_screen.dart' as _i23;
import 'package:ltss/ui/users/dashboard/user_dashboard_screen.dart' as _i22;
import 'package:ltss/ui/users/dmt/add_beneficiary/add_beneficiary.dart' as _i1;
import 'package:ltss/ui/users/dmt/add_customer/add_customer.dart' as _i2;
import 'package:ltss/ui/users/dmt/dmt_screen.dart' as _i6;
import 'package:ltss/ui/users/dmt2/pages/dmt_checkout/dmt_checkout.dart' as _i5;
import 'package:ltss/ui/users/dmt2/pages/dmt_checkout/transaction_successful.dart'
    as _i21;
import 'package:ltss/ui/users/dmt2/pages/search_customer/search_customer.dart'
    as _i16;
import 'package:ltss/ui/users/dmt2/pages/select_beneficiary/select_beneficiary.dart'
    as _i17;
import 'package:ltss/ui/users/dmt2/pages/select_customer/select_customer.dart'
    as _i18;
import 'package:ltss/ui/users/edit_profile/edit_profile.dart' as _i8;
import 'package:ltss/ui/users/fund_request_detail/fund_request_detail_screen.dart'
    as _i10;
import 'package:ltss/ui/users/my_profile/my_profile_screen.dart' as _i14;
import 'package:ltss/ui/users/pages/requests/add/add_fund_request_screen.dart'
    as _i3;
import 'package:ltss/ui/users/vendor_kyc_form/kyc_form.dart' as _i11;
import 'package:ltss/ui/users/vendor_kyc_form/tnc_form.dart' as _i20;

abstract class $AppRouter extends _i25.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i25.PageFactory> pagesMap = {
    AddBeneficiaryRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i1.AddBeneficiaryScreen()),
      );
    },
    AddCustomerRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i2.AddCustomerScreen()),
      );
    },
    AddFundRequestRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i3.AddFundRequestScreen()),
      );
    },
    AddUserRoute.name: (routeData) {
      final args = routeData.argsAs<AddUserRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(
            child: _i4.AddUserScreen(
          key: args.key,
          userTypeAdding: args.userTypeAdding,
          userEntity: args.userEntity,
        )),
      );
    },
    DMTCheckoutRoute.name: (routeData) {
      final args = routeData.argsAs<DMTCheckoutRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(
            child: _i5.DMTCheckoutScreen(
          key: args.key,
          sender: args.sender,
          beneficiary: args.beneficiary,
        )),
      );
    },
    DMTRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i6.DMTScreen()),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i7.DashboardScreen()),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i8.EditProfileScreen()),
      );
    },
    EnterMobileNumberRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i9.EnterMobileNumberScreen()),
      );
    },
    FundRequestDetailRoute.name: (routeData) {
      final args = routeData.argsAs<FundRequestDetailRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(
            child: _i10.FundRequestDetailScreen(
          key: args.key,
          data: args.data,
        )),
      );
    },
    KYCFormPage.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i11.KYCFormPage()),
      );
    },
    ManageChargeRoute.name: (routeData) {
      final args = routeData.argsAs<ManageChargeRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.ManageChargeScreen(
          key: args.key,
          serviceId: args.serviceId,
        ),
      );
    },
    ManageCommissionRoute.name: (routeData) {
      final args = routeData.argsAs<ManageCommissionRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.ManageCommissionScreen(
          key: args.key,
          serviceId: args.serviceId,
        ),
      );
    },
    MyProfileRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i14.MyProfileScreen()),
      );
    },
    NotificationsRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i15.NotificationsScreen(),
      );
    },
    SearchCustomerRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i16.SearchCustomerScreen()),
      );
    },
    SelectBeneficiaryRoute.name: (routeData) {
      final args = routeData.argsAs<SelectBeneficiaryRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(
            child: _i17.SelectBeneficiaryScreen(
          key: args.key,
          mobileNo: args.mobileNo,
        )),
      );
    },
    SelectCustomerRoute.name: (routeData) {
      final args = routeData.argsAs<SelectCustomerRouteArgs>(
          orElse: () => const SelectCustomerRouteArgs());
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(
            child: _i18.SelectCustomerScreen(
          key: args.key,
          selectedCustomer: args.selectedCustomer,
        )),
      );
    },
    SplashRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i19.SplashScreen()),
      );
    },
    TNCFormRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i20.TNCFormScreen(),
      );
    },
    TransactionSuccessRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i21.TransactionSuccessScreen(),
      );
    },
    UserDashboardRoute.name: (routeData) {
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(child: const _i22.UserDashboardScreen()),
      );
    },
    UserDetailRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(
            child: _i23.UserDetailScreen(
          key: args.key,
          userId: args.userId,
        )),
      );
    },
    VerifyOtpRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyOtpRouteArgs>();
      return _i25.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i25.WrappedRoute(
            child: _i24.VerifyOtpScreen(
          key: args.key,
          mobileNumber: args.mobileNumber,
        )),
      );
    },
  };
}

/// generated route for
/// [_i1.AddBeneficiaryScreen]
class AddBeneficiaryRoute extends _i25.PageRouteInfo<void> {
  const AddBeneficiaryRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AddBeneficiaryRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddBeneficiaryRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddCustomerScreen]
class AddCustomerRoute extends _i25.PageRouteInfo<void> {
  const AddCustomerRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AddCustomerRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddCustomerRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AddFundRequestScreen]
class AddFundRequestRoute extends _i25.PageRouteInfo<void> {
  const AddFundRequestRoute({List<_i25.PageRouteInfo>? children})
      : super(
          AddFundRequestRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddFundRequestRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AddUserScreen]
class AddUserRoute extends _i25.PageRouteInfo<AddUserRouteArgs> {
  AddUserRoute({
    _i26.Key? key,
    required _i27.UserRole userTypeAdding,
    _i28.UserEntity? userEntity,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          AddUserRoute.name,
          args: AddUserRouteArgs(
            key: key,
            userTypeAdding: userTypeAdding,
            userEntity: userEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'AddUserRoute';

  static const _i25.PageInfo<AddUserRouteArgs> page =
      _i25.PageInfo<AddUserRouteArgs>(name);
}

class AddUserRouteArgs {
  const AddUserRouteArgs({
    this.key,
    required this.userTypeAdding,
    this.userEntity,
  });

  final _i26.Key? key;

  final _i27.UserRole userTypeAdding;

  final _i28.UserEntity? userEntity;

  @override
  String toString() {
    return 'AddUserRouteArgs{key: $key, userTypeAdding: $userTypeAdding, userEntity: $userEntity}';
  }
}

/// generated route for
/// [_i5.DMTCheckoutScreen]
class DMTCheckoutRoute extends _i25.PageRouteInfo<DMTCheckoutRouteArgs> {
  DMTCheckoutRoute({
    _i26.Key? key,
    required _i29.Sender sender,
    required _i30.Beneficiary beneficiary,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          DMTCheckoutRoute.name,
          args: DMTCheckoutRouteArgs(
            key: key,
            sender: sender,
            beneficiary: beneficiary,
          ),
          initialChildren: children,
        );

  static const String name = 'DMTCheckoutRoute';

  static const _i25.PageInfo<DMTCheckoutRouteArgs> page =
      _i25.PageInfo<DMTCheckoutRouteArgs>(name);
}

class DMTCheckoutRouteArgs {
  const DMTCheckoutRouteArgs({
    this.key,
    required this.sender,
    required this.beneficiary,
  });

  final _i26.Key? key;

  final _i29.Sender sender;

  final _i30.Beneficiary beneficiary;

  @override
  String toString() {
    return 'DMTCheckoutRouteArgs{key: $key, sender: $sender, beneficiary: $beneficiary}';
  }
}

/// generated route for
/// [_i6.DMTScreen]
class DMTRoute extends _i25.PageRouteInfo<void> {
  const DMTRoute({List<_i25.PageRouteInfo>? children})
      : super(
          DMTRoute.name,
          initialChildren: children,
        );

  static const String name = 'DMTRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i7.DashboardScreen]
class DashboardRoute extends _i25.PageRouteInfo<void> {
  const DashboardRoute({List<_i25.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i8.EditProfileScreen]
class EditProfileRoute extends _i25.PageRouteInfo<void> {
  const EditProfileRoute({List<_i25.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i9.EnterMobileNumberScreen]
class EnterMobileNumberRoute extends _i25.PageRouteInfo<void> {
  const EnterMobileNumberRoute({List<_i25.PageRouteInfo>? children})
      : super(
          EnterMobileNumberRoute.name,
          initialChildren: children,
        );

  static const String name = 'EnterMobileNumberRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i10.FundRequestDetailScreen]
class FundRequestDetailRoute
    extends _i25.PageRouteInfo<FundRequestDetailRouteArgs> {
  FundRequestDetailRoute({
    _i26.Key? key,
    required _i31.FundRequestEntity data,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          FundRequestDetailRoute.name,
          args: FundRequestDetailRouteArgs(
            key: key,
            data: data,
          ),
          initialChildren: children,
        );

  static const String name = 'FundRequestDetailRoute';

  static const _i25.PageInfo<FundRequestDetailRouteArgs> page =
      _i25.PageInfo<FundRequestDetailRouteArgs>(name);
}

class FundRequestDetailRouteArgs {
  const FundRequestDetailRouteArgs({
    this.key,
    required this.data,
  });

  final _i26.Key? key;

  final _i31.FundRequestEntity data;

  @override
  String toString() {
    return 'FundRequestDetailRouteArgs{key: $key, data: $data}';
  }
}

/// generated route for
/// [_i11.KYCFormPage]
class KYCFormPage extends _i25.PageRouteInfo<void> {
  const KYCFormPage({List<_i25.PageRouteInfo>? children})
      : super(
          KYCFormPage.name,
          initialChildren: children,
        );

  static const String name = 'KYCFormPage';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i12.ManageChargeScreen]
class ManageChargeRoute extends _i25.PageRouteInfo<ManageChargeRouteArgs> {
  ManageChargeRoute({
    _i26.Key? key,
    required int serviceId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ManageChargeRoute.name,
          args: ManageChargeRouteArgs(
            key: key,
            serviceId: serviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'ManageChargeRoute';

  static const _i25.PageInfo<ManageChargeRouteArgs> page =
      _i25.PageInfo<ManageChargeRouteArgs>(name);
}

class ManageChargeRouteArgs {
  const ManageChargeRouteArgs({
    this.key,
    required this.serviceId,
  });

  final _i26.Key? key;

  final int serviceId;

  @override
  String toString() {
    return 'ManageChargeRouteArgs{key: $key, serviceId: $serviceId}';
  }
}

/// generated route for
/// [_i13.ManageCommissionScreen]
class ManageCommissionRoute
    extends _i25.PageRouteInfo<ManageCommissionRouteArgs> {
  ManageCommissionRoute({
    _i26.Key? key,
    required int serviceId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          ManageCommissionRoute.name,
          args: ManageCommissionRouteArgs(
            key: key,
            serviceId: serviceId,
          ),
          initialChildren: children,
        );

  static const String name = 'ManageCommissionRoute';

  static const _i25.PageInfo<ManageCommissionRouteArgs> page =
      _i25.PageInfo<ManageCommissionRouteArgs>(name);
}

class ManageCommissionRouteArgs {
  const ManageCommissionRouteArgs({
    this.key,
    required this.serviceId,
  });

  final _i26.Key? key;

  final int serviceId;

  @override
  String toString() {
    return 'ManageCommissionRouteArgs{key: $key, serviceId: $serviceId}';
  }
}

/// generated route for
/// [_i14.MyProfileScreen]
class MyProfileRoute extends _i25.PageRouteInfo<void> {
  const MyProfileRoute({List<_i25.PageRouteInfo>? children})
      : super(
          MyProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyProfileRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i15.NotificationsScreen]
class NotificationsRoute extends _i25.PageRouteInfo<void> {
  const NotificationsRoute({List<_i25.PageRouteInfo>? children})
      : super(
          NotificationsRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationsRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i16.SearchCustomerScreen]
class SearchCustomerRoute extends _i25.PageRouteInfo<void> {
  const SearchCustomerRoute({List<_i25.PageRouteInfo>? children})
      : super(
          SearchCustomerRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchCustomerRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i17.SelectBeneficiaryScreen]
class SelectBeneficiaryRoute
    extends _i25.PageRouteInfo<SelectBeneficiaryRouteArgs> {
  SelectBeneficiaryRoute({
    _i26.Key? key,
    required String mobileNo,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          SelectBeneficiaryRoute.name,
          args: SelectBeneficiaryRouteArgs(
            key: key,
            mobileNo: mobileNo,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectBeneficiaryRoute';

  static const _i25.PageInfo<SelectBeneficiaryRouteArgs> page =
      _i25.PageInfo<SelectBeneficiaryRouteArgs>(name);
}

class SelectBeneficiaryRouteArgs {
  const SelectBeneficiaryRouteArgs({
    this.key,
    required this.mobileNo,
  });

  final _i26.Key? key;

  final String mobileNo;

  @override
  String toString() {
    return 'SelectBeneficiaryRouteArgs{key: $key, mobileNo: $mobileNo}';
  }
}

/// generated route for
/// [_i18.SelectCustomerScreen]
class SelectCustomerRoute extends _i25.PageRouteInfo<SelectCustomerRouteArgs> {
  SelectCustomerRoute({
    _i26.Key? key,
    _i28.UserEntity? selectedCustomer,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          SelectCustomerRoute.name,
          args: SelectCustomerRouteArgs(
            key: key,
            selectedCustomer: selectedCustomer,
          ),
          initialChildren: children,
        );

  static const String name = 'SelectCustomerRoute';

  static const _i25.PageInfo<SelectCustomerRouteArgs> page =
      _i25.PageInfo<SelectCustomerRouteArgs>(name);
}

class SelectCustomerRouteArgs {
  const SelectCustomerRouteArgs({
    this.key,
    this.selectedCustomer,
  });

  final _i26.Key? key;

  final _i28.UserEntity? selectedCustomer;

  @override
  String toString() {
    return 'SelectCustomerRouteArgs{key: $key, selectedCustomer: $selectedCustomer}';
  }
}

/// generated route for
/// [_i19.SplashScreen]
class SplashRoute extends _i25.PageRouteInfo<void> {
  const SplashRoute({List<_i25.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i20.TNCFormScreen]
class TNCFormRoute extends _i25.PageRouteInfo<void> {
  const TNCFormRoute({List<_i25.PageRouteInfo>? children})
      : super(
          TNCFormRoute.name,
          initialChildren: children,
        );

  static const String name = 'TNCFormRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i21.TransactionSuccessScreen]
class TransactionSuccessRoute extends _i25.PageRouteInfo<void> {
  const TransactionSuccessRoute({List<_i25.PageRouteInfo>? children})
      : super(
          TransactionSuccessRoute.name,
          initialChildren: children,
        );

  static const String name = 'TransactionSuccessRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i22.UserDashboardScreen]
class UserDashboardRoute extends _i25.PageRouteInfo<void> {
  const UserDashboardRoute({List<_i25.PageRouteInfo>? children})
      : super(
          UserDashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserDashboardRoute';

  static const _i25.PageInfo<void> page = _i25.PageInfo<void>(name);
}

/// generated route for
/// [_i23.UserDetailScreen]
class UserDetailRoute extends _i25.PageRouteInfo<UserDetailRouteArgs> {
  UserDetailRoute({
    _i26.Key? key,
    required int userId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          UserDetailRoute.name,
          args: UserDetailRouteArgs(
            key: key,
            userId: userId,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailRoute';

  static const _i25.PageInfo<UserDetailRouteArgs> page =
      _i25.PageInfo<UserDetailRouteArgs>(name);
}

class UserDetailRouteArgs {
  const UserDetailRouteArgs({
    this.key,
    required this.userId,
  });

  final _i26.Key? key;

  final int userId;

  @override
  String toString() {
    return 'UserDetailRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [_i24.VerifyOtpScreen]
class VerifyOtpRoute extends _i25.PageRouteInfo<VerifyOtpRouteArgs> {
  VerifyOtpRoute({
    _i26.Key? key,
    required String mobileNumber,
    List<_i25.PageRouteInfo>? children,
  }) : super(
          VerifyOtpRoute.name,
          args: VerifyOtpRouteArgs(
            key: key,
            mobileNumber: mobileNumber,
          ),
          initialChildren: children,
        );

  static const String name = 'VerifyOtpRoute';

  static const _i25.PageInfo<VerifyOtpRouteArgs> page =
      _i25.PageInfo<VerifyOtpRouteArgs>(name);
}

class VerifyOtpRouteArgs {
  const VerifyOtpRouteArgs({
    this.key,
    required this.mobileNumber,
  });

  final _i26.Key? key;

  final String mobileNumber;

  @override
  String toString() {
    return 'VerifyOtpRouteArgs{key: $key, mobileNumber: $mobileNumber}';
  }
}
