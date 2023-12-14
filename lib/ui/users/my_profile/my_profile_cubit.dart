import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_detail_entity.dart';

part 'my_profile_state.dart';

class MyProfileCubit extends BaseCubit<MyProfileState> {
  final SessionManager _sessionManager;
  final UserRepository _userRepository;

  MyProfileCubit(this._sessionManager, this._userRepository)
      : super(MyProfileInitial());

  Future<void> fetchUserDetail() async {
    emit(LoadingData());

    int userId = await _sessionManager.getUserId();

    var result = await _userRepository.getUserDetail(userId);

    result.when(success: (result) {
      emit(
        OnDataLoaded(
            data: result,
            blockEnabled: userId != result.id && result.isActive == true,
            unblockEnabled: userId != result.id && result.isActive == false,
            editProfileEnabled: userId == result.id),
      );
    }, failure: (e) {
      emit(DataLoadFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
