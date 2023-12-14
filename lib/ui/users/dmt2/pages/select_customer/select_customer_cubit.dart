import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';

part 'select_customer_state.dart';

class SelectCustomerCubit extends BaseCubit<SelectCustomerState> {
  final UserRepository _userRepository;
  final SessionManager _sessionManager;
  SelectCustomerCubit(this._userRepository, this._sessionManager) : super(SelectCustomerInitial());

  Future<void> fetchData() async {
    emit(LoadingData());

    var result = await _userRepository.getUsersByRoleId(UserRole.customer.roleId);

    result.when(success: (result) {
      emit(ReceivedData(result));
    }, failure: (e) {
      emit(LoadDataFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
