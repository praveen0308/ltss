import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';

part 'add_bank_state.dart';

class AddBankCubit extends BaseCubit<AddBankState> {
  final BankRepository _bankRepository;

  AddBankCubit(this._bankRepository) : super(const AddBankState());

  Future<void> addNewBank(BankEntity bankEntity) async {
    emit(state.copyWith(status: AddBankStatus.loading));
    var result = await _bankRepository.addNewBank(bankEntity);

    result.when(success: (result) {
      emit(state.copyWith(status: AddBankStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddBankStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateBank(BankEntity bankEntity) async {
    emit(state.copyWith(status: AddBankStatus.loading));
    var result =
        await _bankRepository.updateBank(bankEntity.bankId!, bankEntity);

    result.when(success: (result) {
      emit(state.copyWith(status: AddBankStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddBankStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
