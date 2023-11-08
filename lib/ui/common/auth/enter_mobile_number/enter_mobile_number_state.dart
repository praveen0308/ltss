part of 'enter_mobile_number_cubit.dart';

@immutable
abstract class EnterMobileNumberState {}

class EnterMobileNumberBase extends EnterMobileNumberState {
  final bool isLoading;
  final String msg;
  final EnterMobileNumberStatus status;

  EnterMobileNumberBase(
      {this.isLoading = false,
      this.msg = "",
      this.status = EnterMobileNumberStatus.idle});

  EnterMobileNumberBase copyWith({
    bool? isLoading,
    String? msg,
    EnterMobileNumberStatus? status,
  }) {
    return EnterMobileNumberBase(
      isLoading: isLoading ?? this.isLoading,
      msg: msg ?? this.msg,
      status: status ?? this.status,
    );
  }
}

class Loading extends EnterMobileNumberState {}

class OTPSent extends EnterMobileNumberState {}

class UserDoesNotExist extends EnterMobileNumberState {}

class Error extends EnterMobileNumberState {
  final String msg;

  Error(this.msg);
}

enum EnterMobileNumberStatus { idle, loading, error, success }
