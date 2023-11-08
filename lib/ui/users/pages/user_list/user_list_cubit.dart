import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/utils/utils.dart';

part 'user_list_state.dart';

class UserListCubit extends BaseCubit<UserListState> {
  final UserRepository _userRepository;
  final SessionManager _sessionManager;

  UserListCubit(this._userRepository, this._sessionManager) : super(UserListInitial());

  Future<void> loadUsers() async {
    emit(LoadingData());
    var roleId = await _sessionManager.getRoleId();
    var mRoleId = 0;
    if(roleId == UserRole.distributor.roleId){
      mRoleId = UserRole.retailer.roleId;
    }else if(roleId == UserRole.retailer.roleId){
      mRoleId = UserRole.customer.roleId;
    }
    var result = await _userRepository.getUsersByRoleId(mRoleId,loggedInUser: true);

    result.when(success: (result) {
      if(result.isNotEmpty){
        emit(OnDataLoaded(result));
      }else{
        emit(NoData());
      }


    }, failure: (e) {
      emit(DataLoadFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
