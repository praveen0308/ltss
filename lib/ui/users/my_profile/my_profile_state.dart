part of 'my_profile_cubit.dart';

@immutable
abstract class MyProfileState {}

class MyProfileInitial extends MyProfileState {}

class LoadingData extends MyProfileState {}

class NoData extends MyProfileState {}

class OnDataLoaded extends MyProfileState {
  final UserDetailEntity data;
  final bool blockEnabled;
  final bool unblockEnabled;
  final bool editProfileEnabled;

  OnDataLoaded({
    required this.data,
    required this.blockEnabled,
    required this.unblockEnabled,
    required this.editProfileEnabled,

  });
}

class DataLoadFailed extends MyProfileState {
  final String msg;

  DataLoadFailed(this.msg);
}

