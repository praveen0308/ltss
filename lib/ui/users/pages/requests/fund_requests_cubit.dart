import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/utils/user_type.dart';
import 'package:meta/meta.dart';

part 'fund_requests_state.dart';

class FundRequestsCubit extends BaseCubit<FundRequestsState> {
  final SessionManager _sessionManager;

  FundRequestsCubit(this._sessionManager) : super(FundRequestsInitial());

  Future<void> initUI() async {
    emit(InitiatingUI());

    var roleId = await _sessionManager.getRoleId();

    if (roleId == UserRole.distributor.roleId) {
      emit(UILoaded(true, true));
    } else if (roleId == UserRole.retailer.roleId) {
      emit(UILoaded(true, false));
    } else if (roleId == UserRole.vendor.roleId) {
      emit(UILoaded(false, true));
    }
  }
}
