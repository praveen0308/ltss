import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/repository/repository.dart';
import 'package:meta/meta.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends BaseCubit<VerifyOtpState> {
  final AuthRepository _authRepository;

  VerifyOtpCubit(this._authRepository) : super(VerifyOtpInitial());

  Future<void> verifyOtp(String mobileNumber, String otp) async {
    emit(VerifyingOTP());
    var result = await _authRepository.verifyOTP(mobileNumber, otp);
    result.when(success: (result) {
      emit(OTPVerificationSuccess());
    }, failure: (e) {
      emit(OTPVerificationFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> requestOTP(String mobileNumber) async {
    emit(ResendingOTP());
    var result = await _authRepository.requestOTP(mobileNumber);

    result.when(success: (result) {
      emit(OTPResentSuccessfully());
    }, failure: (e) {
      emit(OTPResendFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> fetchProfileData() async {
    emit(LoadingProfile());
    var result = await _authRepository.getProfile();

    result.when(success: (result) {
      emit(ProfileLoaded(result.role_id ?? 0));
    }, failure: (e) {
      emit(LoadProfileFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
