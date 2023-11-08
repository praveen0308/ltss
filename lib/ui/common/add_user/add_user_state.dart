part of 'add_user_cubit.dart';

@immutable
abstract class AddUserState {}

class AddUserInitial extends AddUserState {}

class AddingUserData extends AddUserState {}

class AddUserSuccessful extends AddUserState {}

class AddUserFailed extends AddUserState {
  final String msg;

  AddUserFailed(this.msg);
}

class AddingUserKYC extends AddUserState {}

class AddKYCSuccessful extends AddUserState {}

class AddKYCFailed extends AddUserState {
  final String msg;

  AddKYCFailed(this.msg);
}

class StepUpdated extends AddUserState{
  final int step;

  StepUpdated(this.step);
}