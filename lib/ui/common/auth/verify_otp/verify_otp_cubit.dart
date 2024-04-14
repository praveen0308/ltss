import 'package:ltss/base/base.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends BaseCubit<VerifyOtpState> {
  final AuthRepository _authRepository;
  final KYCRepository _kycRepository;

  VerifyOtpCubit(this._authRepository, this._kycRepository)
      : super(VerifyOtpInitial());

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
    var kycStatus = await _kycRepository.getKYCStatus();

    result.when(success: (result) {
      kycStatus.when(success: (status) {
        emit(ProfileLoaded(result.roleId ?? 0, status));
      }, failure: (e) {
        emit(LoadProfileFailed(e.message));
        logger.e("Exception: $e");
      });
    }, failure: (e) {
      emit(LoadProfileFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
