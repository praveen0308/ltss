part of 'dashboard_screen_bloc.dart';

class DashboardScreenEvent{}

class Empty extends DashboardScreenEvent{}
class ToggleAddServicePage extends DashboardScreenEvent{
  final ServiceEntity? data;

  ToggleAddServicePage({this.data});
}
class ToggleAddCommissionPage extends DashboardScreenEvent{
  final CommissionEntity? commission;

  ToggleAddCommissionPage({this.commission});
}
class ToggleAddChargePage extends DashboardScreenEvent{
  final ChargeEntity? data;

  ToggleAddChargePage({this.data});
}
