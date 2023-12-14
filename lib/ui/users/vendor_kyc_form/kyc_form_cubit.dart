import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:meta/meta.dart';

part 'kyc_form_state.dart';

class KycFormCubit extends BaseCubit<KycFormState> {
  final KYCRepository _kycRepository;
  KycFormCubit(this._kycRepository) : super(KycFormInitial());

  Future<void> submitKYCForm(String pan,String aadhaar,File shopImage,File profileImage) async {
    emit(SubmittingKYCForm());
    var result = await _kycRepository.postKYC( pan, aadhaar, shopImage, profileImage);
    result.when(success: (user) {
      emit(KYCFormDone());
    }, failure: (e) {
      emit(KYCFormFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
