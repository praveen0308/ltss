import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends BaseCubit<EditProfileState> {
  final AuthRepository _authRepository;
  final SessionManager _sessionManager;

  EditProfileCubit(this._authRepository, this._sessionManager)
      : super(EditProfileState());

  Future<void> fetchUserData() async {
    emit(state.copyWith(status: EditProfileStatus.initializing));
    try {
      var name = await _sessionManager.getName();
      var address = await _sessionManager.getAddress();
      var email = await _sessionManager.getEmail();
      var mobileNumber = await _sessionManager.getMobileNumber();

      emit(state.copyWith(
          status: EditProfileStatus.initializationSuccess,
          name: name,
          address: address,
          email: email,
          mobileNumber: mobileNumber));
    } catch (e) {
      emit(state.copyWith(status: EditProfileStatus.initializationFailed));
    }
  }

  Future<void> updateProfile(
      String? name, String? email, String? address) async {
    emit(state.copyWith(status: EditProfileStatus.loading));

    var result = await _authRepository.updateProfile(
        name: name, email: email, address: address);

    result.when(success: (result) {
      emit(state.copyWith(
          status: EditProfileStatus.success,
          msg: "Profile updated successfully!!!"));
    }, failure: (e) {
      emit(state.copyWith(status: EditProfileStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
