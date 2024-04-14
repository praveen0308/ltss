import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_detail_entity.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends BaseCubit<UserDetailState> {
  final UserRepository _userRepository;
  final SessionManager _sessionManager;

  UserDetailCubit(this._userRepository, this._sessionManager)
      : super(UserDetailInitial());

  Future<void> fetchUserDetail({int userId = 0}) async {
    emit(LoadingData());
    if (userId == 0) {
      userId = await _sessionManager.getUserId();
    }

    var result = await _userRepository.getUserDetail(userId);

    result.when(success: (result) {
      emit(
        OnDataLoaded(
            data: result,
            blockEnabled:  result.isActive == true,
            unblockEnabled: result.isActive == false,
            editProfileEnabled: userId == result.id),
      );
    }, failure: (e) {
      emit(DataLoadFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> blockUser({int userId = 0, bool status = false}) async {
    emit(PerformingAction());
    if (userId == 0) {
       userId = await _sessionManager.getUserId();
    }
    var result = await _userRepository.blockUser(userId,status: status);

    result.when(success: (result) {
      emit(
        ActionSuccessful(status ? "User unblocked!!!": "User blocked!!!")
      );
    }, failure: (e) {
      emit(PerformActionFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
