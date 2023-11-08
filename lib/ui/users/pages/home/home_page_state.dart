part of 'home_page_cubit.dart';

sealed class HomePageState {}

class HomePageInitial extends HomePageState {}

class LoadingHome extends HomePageState {}

class HomeDataLoaded extends HomePageState {
  final num walletBalance;
  final String userName;
  final bool anyNotifications;
  final List<UserAction> actions;

  HomeDataLoaded(
      this.walletBalance, this.userName, this.anyNotifications, this.actions);
}

class LoadingFailed extends HomePageState {
  final String msg;

  LoadingFailed(this.msg);
}
