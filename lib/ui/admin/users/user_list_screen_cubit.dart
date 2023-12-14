import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';

part 'user_list_screen_state.dart';

class UserListScreenCubit extends BaseCubit<UserListScreenState> {
  final UserRepository _userRepository;

  UserListScreenCubit(this._userRepository) : super(UserListScreenInitial());
  List<UserEntity> users = List.empty(growable: true);
  Future<void> fetchUserStats(int roleId) async {
    emit(LoadingUserStats());
    var result = await _userRepository.getUserStats(roleId);
    result.when(success: (result) {
      emit(ReceivedUserStats(result.userCount ?? 0, result.requestCount ?? 0));
    }, failure: (e) {
      emit(UserStatsFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> loadUsers(int roleId) async {
    emit(LoadingUsers());
    var result = await _userRepository.getUsersByRoleId(roleId);

    result.when(success: (result) {
      users.clear();
      users.addAll(result);
      emit(ReceivedUsers(users));
    }, failure: (e) {
      emit(LoadUsersFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  void searchUser(String query){
    List<UserEntity> filteredItems = List.empty(growable: true);

    for (var element in users) {
      if(element.firstName?.contains(query) == true || element.lastName?.contains(query) == true){
        filteredItems.add(element);
      }
    }

    emit(ReceivedUsers(filteredItems));
  }


}
