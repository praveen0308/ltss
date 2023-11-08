import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/domain/user_action.dart';
import 'package:ltss/utils/user_type.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';

class HomePageCubit extends BaseCubit<HomePageState> {
  final SessionManager _sessionManager;
  final UserRepository _userRepository;

  HomePageCubit(
      this._sessionManager, this._userRepository)
      : super(HomePageInitial());

  Future<void> loadData() async {
    emit(LoadingHome());
    var userId = await _sessionManager.getUserId();
    var name = await _sessionManager.getName();
    var roleId = await _sessionManager.getRoleId();
    var role = UserRole.getUserRole(roleId);

    List<UserAction> actions = List.empty(growable: true);

    if (role == UserRole.retailer) {
      actions.add(UserAction.serviceDMT);
      actions.add(UserAction.requestFund);
      actions.add(UserAction.transactions);
      actions.add(UserAction.searchUser);
      actions.add(UserAction.addCustomer);
    }

    if (role == UserRole.distributor) {
      actions.add(UserAction.requestFund);
      actions.add(UserAction.searchUser);
    }

    if (role == UserRole.vendor) {
      actions.add(UserAction.transactions);
    }
    var result = await _userRepository.getWalletBalance();
    result.when(success: (result) {
      emit(HomeDataLoaded(result, name, false, actions));
    }, failure: (e) {
      emit(LoadingFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
