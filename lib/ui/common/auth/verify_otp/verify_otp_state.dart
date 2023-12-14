part of 'verify_otp_cubit.dart';

@immutable
abstract class VerifyOtpState {}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyingOTP extends VerifyOtpState {}
class OTPVerificationSuccess extends VerifyOtpState {}
class OTPVerificationFailed extends VerifyOtpState {
  final String msg;

  OTPVerificationFailed(this.msg);

}


class ResendingOTP extends VerifyOtpState {}
class OTPResentSuccessfully extends VerifyOtpState {}
class OTPResendFailed extends VerifyOtpState {
  final String msg;

  OTPResendFailed(this.msg);

}

class LoadingProfile extends VerifyOtpState {}
class ProfileLoaded extends VerifyOtpState {
  final int roleId;
  final bool kycDone;

  ProfileLoaded(this.roleId, this.kycDone);
}
class LoadProfileFailed extends VerifyOtpState {
  final String msg;

  LoadProfileFailed(this.msg);

}

