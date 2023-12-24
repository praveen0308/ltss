import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';

part 'add_bank_state.dart';

class AddBankCubit extends BaseCubit<AddBankState> {
  final BankRepository _bankRepository;
  final UserRepository _userRepository;

  AddBankCubit(this._bankRepository, this._userRepository)
      : super(const AddBankState());

/*
  Future<void> loadVendors(int bankId) async {
    emit(state.copyWith(status: AddBankStatus.initialising));
    var result = await _userRepository.getUsersByRoleId(UserRole.vendor.roleId);
    var vendorResult = await _userRepository.getVendor(bankId);

    result.when(success: (result) {
      vendorResult.when(success: (v){
        if(v!=null){
          emit(state.copyWith(status: AddBankStatus.initialisationSuccessful,vendors: result,assignedVendor: v));
        }else{
          emit(state.copyWith(status: AddBankStatus.initialisationSuccessful,vendors: result));
        }

      }, failure: (e){
        emit(state.copyWith(status: AddBankStatus.initialisationSuccessful,vendors: result));
        logger.e("Exception: $e");
      });
    }, failure: (e) {
      emit(state.copyWith(status: AddBankStatus.initialisationFailed, msg: e.message));
      logger.e("Exception: $e");
    });
  }*/

  Future<void> addNewBank(BankEntity bankEntity, {int? vendorId}) async {
    emit(state.copyWith(status: AddBankStatus.loading));
    var result = await _bankRepository.addNewBank(bankEntity, vendorId);

    result.when(success: (result) {
      emit(state.copyWith(status: AddBankStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddBankStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateBank(BankEntity bankEntity, {int? vendorId}) async {
    emit(state.copyWith(status: AddBankStatus.loading));
    var result = await _bankRepository.updateBank(
        bankEntity.bankId!, bankEntity, vendorId);

    result.when(success: (result) {
      emit(state.copyWith(status: AddBankStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddBankStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
