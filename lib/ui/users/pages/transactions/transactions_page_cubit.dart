import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';

part 'transactions_page_state.dart';

class TransactionsPageCubit extends BaseCubit<TransactionsPageState> {
  final DMTRepository _dmtRepository;
  final SessionManager _sessionManager;

  TransactionsPageCubit(this._dmtRepository, this._sessionManager)
      : super(TransactionsPageInitial());

  Future<void> fetchTransactions() async {
    var userId = await _sessionManager.getUserId();
    var roleId = await _sessionManager.getRoleId();

    if (roleId == UserRole.vendor.roleId) {
      var result = await _dmtRepository.getTransactions(vendorId: userId);
      result.when(success: (data) {
        emit(ReceivedTransactions(data));
      }, failure: (e) {
        emit(LoadTransactionsFailed(e.message));
        logger.e("Exception: $e");
      });
    } else if (roleId == UserRole.retailer.roleId) {
      /// Will replace with generic transactions api when new services will be introduced
      var result = await _dmtRepository.getTransactions(retailerId: userId);
      result.when(success: (data) {
        emit(ReceivedTransactions(data));
      }, failure: (e) {
        emit(LoadTransactionsFailed(e.message));
        logger.e("Exception: $e");
      });
    }
  }
}
