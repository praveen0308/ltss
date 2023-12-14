import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:meta/meta.dart';

part 'dmt_transactions_state.dart';

class DmtTransactionsCubit extends BaseCubit<DmtTransactionsState> {
  final DMTRepository _dmtRepository;

  DmtTransactionsCubit(this._dmtRepository) : super(DmtTransactionsInitial());

  Future<void> loadTransactions() async {
    emit(LoadingTransactions());
    var result = await _dmtRepository.getTransactions();

    result.when(success: (result) {
      emit(LoadTransactionsSuccessful(result));
    }, failure: (e) {
      emit(LoadTransactionsFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
