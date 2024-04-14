part of 'account_page_cubit.dart';

sealed class AccountPageState {}

class AccountPageInitial extends AccountPageState {}

class LoadingUI extends AccountPageState {}
class LogOutSuccessful extends AccountPageState {}

class UILoaded extends AccountPageState {
  final int userId;
  final String name;
  final String mobileNumber;
  final int roleId;
  final String role;
  final String profileUrl;
  final String appVersion;

  UILoaded(this.userId, this.name, this.mobileNumber, this.roleId, this.role,
      this.profileUrl, this.appVersion);
}

class LoadUIFailed extends AccountPageState {
  final String msg;

  LoadUIFailed(this.msg);
}
