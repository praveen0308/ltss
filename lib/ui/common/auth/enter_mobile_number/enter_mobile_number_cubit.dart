import 'package:flutter/material.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/repository/auth_repository.dart';

part 'enter_mobile_number_state.dart';

class EnterMobileNumberCubit extends BaseCubit<EnterMobileNumberState> {
  final AuthRepository _authRepository;

  EnterMobileNumberCubit(this._authRepository) : super(EnterMobileNumberBase());

  Future<void> requestOTP(String mobileNumber) async {
    var prevState = state as EnterMobileNumberBase;
    emit(prevState.copyWith(isLoading: true));
    var result = await _authRepository.requestOTP(mobileNumber);

    result.when(success: (result) {
      emit(prevState.copyWith(
          isLoading: false,
          status: EnterMobileNumberStatus.success,
          msg: "OTP sent successfully !!!"));
    }, failure: (e) {
      emit(prevState.copyWith(
          isLoading: false,
          status: EnterMobileNumberStatus.error,
          msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
