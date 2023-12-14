part of 'dashboard_screen_bloc.dart';

class DashboardScreenEvent {}

class Empty extends DashboardScreenEvent {}

class ToggleAddServicePage extends DashboardScreenEvent {
  final ServiceEntity? data;

  ToggleAddServicePage({this.data});
}

class ToggleAddCommissionPage extends DashboardScreenEvent {
  final CommissionEntity? commission;

  ToggleAddCommissionPage({this.commission});
}

class ToggleAddChargePage extends DashboardScreenEvent {
  final ChargeEntity? data;

  ToggleAddChargePage({this.data});
}

class ToggleAddBankPage extends DashboardScreenEvent {
  final BankEntity? data;

  ToggleAddBankPage({this.data});
}
class ToggleUserDetailPage extends DashboardScreenEvent {
  final int userId;

  ToggleUserDetailPage({required this.userId});
}
class ToggleAddDmtVendorPage extends DashboardScreenEvent {
  final BankVendor? bankVendor;

  ToggleAddDmtVendorPage({this.bankVendor});
}

class ToggleAddUserPage extends DashboardScreenEvent {
  final UserRole role;
  final UserEntity? user;

  ToggleAddUserPage( {required this.role,this.user});
}

class ToggleManageCommission extends DashboardScreenEvent {
  final int serviceId;

  ToggleManageCommission(this.serviceId);

}
class ToggleManageCharges extends DashboardScreenEvent {
  final int serviceId;

  ToggleManageCharges(this.serviceId);

}
