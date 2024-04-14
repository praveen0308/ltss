import 'package:ltss/base/base.dart';

part 'edit_transaction_state.dart';

class EditTransactionCubit extends BaseCubit<EditTransactionState> {
  final DMTRepository _dmtRepository;

  EditTransactionCubit(this._dmtRepository)
      : super(const EditTransactionState());

  Future<void> updateTransaction(int transactionId, int vendorId) async {
    emit(state.copyWith(status: EditTransactionStatus.loading));
    var result =
        await _dmtRepository.updateTransactionVendor(transactionId, vendorId);

    result.when(success: (s) {
      emit(state.copyWith(status: EditTransactionStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: EditTransactionStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
