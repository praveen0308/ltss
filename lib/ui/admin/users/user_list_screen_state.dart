part of 'user_list_screen_cubit.dart';

@immutable
abstract class UserListScreenState {}

class UserListScreenInitial extends UserListScreenState {}


class LoadingUserStats extends UserListScreenState {}

class ReceivedUserStats extends UserListScreenState {
  final int userCount;
  final int requestCount;

  ReceivedUserStats(this.userCount, this.requestCount);
}

class UserStatsFailed extends UserListScreenState {
  final String msg;

  UserStatsFailed(this.msg);
}

class LoadingUsers extends UserListScreenState {}

class ReceivedUsers extends UserListScreenState {
  final List<UserEntity> users;

  ReceivedUsers(this.users);
}

class LoadUsersFailed extends UserListScreenState {
  final String msg;

  LoadUsersFailed(this.msg);
}

