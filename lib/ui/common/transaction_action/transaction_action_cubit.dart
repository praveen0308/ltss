import 'dart:io';

import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/transaction_entity.dart';
import 'package:ltss/models/enums.dart';
import 'package:ltss/repository/transaction_repository.dart';
import 'package:ltss/ui/common/transaction_action/transaction_action.dart';

part 'transaction_action_state.dart';

class TransactionActionCubit extends BaseCubit<TransactionActionState> {
  final SessionManager _sessionManager;
  final DMTRepository _dmtRepository;
  final TransactionRepository _transactionRepository;

  TransactionActionCubit(
      this._sessionManager, this._dmtRepository, this._transactionRepository)
      : super(TransactionActionInitial());

  Future<void> init(int transactionId,TransactionAction action) async {
    emit(Initializing());
    var result = await _transactionRepository.getServiceTransaction(
        AppService.dmt.id, transactionId);


    result.when(success: (r) {
      switch(action){
        case TransactionAction.accept:
          emit(InitializationSuccessful(r, true, true, "Mark as Done", null));
        case TransactionAction.reject:
          emit(InitializationSuccessful(r, false, true, "Mark as Rejected", null));
        case TransactionAction.verify:
          emit(InitializationSuccessful(r, false, false, "Mark as Verified", r.tracking?.first));
      }
    }, failure: (e) {
      emit(InitializationFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateStatus(int transactionId, String status,
      {File? screenshot, String? comment}) async {
    emit(Updating());
    var result = await _dmtRepository.updateTransactionStatus(
        transactionId, status,
        screenshot: screenshot, comment: comment);

    result.when(success: (r) {
      emit(UpdateSuccessful());
    }, failure: (e) {
      emit(UpdateFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
