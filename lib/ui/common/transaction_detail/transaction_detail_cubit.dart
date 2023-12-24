import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/enums.dart';

part 'transaction_detail_state.dart';

class TransactionDetailCubit extends BaseCubit<TransactionDetailState> {
  final SessionManager _sessionManager;

  TransactionDetailCubit(this._sessionManager)
      : super(TransactionDetailInitial());

  Future<void> init(DmtTransaction transaction) async {
    emit(Initializing());
    final roleId = await _sessionManager.getRoleId();

    if (roleId == UserRole.retailer.roleId ||
        roleId == UserRole.distributor.roleId) {
      emit(InitializationSuccessful(false, false, false));
    } else if (roleId == UserRole.vendor.roleId) {
      if(AppStatus.fromString(transaction.status) == AppStatus.requested){
        emit(InitializationSuccessful(true, true, false));
      }else{
        emit(InitializationSuccessful(false, false, false));
      }

    } else if (roleId == UserRole.admin.roleId) {
      if(AppStatus.fromString(transaction.status) == AppStatus.done){
        emit(InitializationSuccessful(false, false, true));
      }else{
        emit(InitializationSuccessful(false, false, false));
      }

    }
  }
}
