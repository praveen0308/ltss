import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';

part 'add_dmt_vendor_state.dart';

class AddDmtVendorCubit extends BaseCubit<AddDmtVendorState> {
  final UserRepository _userRepository;
  final BankRepository _bankRepository;
  AddDmtVendorCubit(this._userRepository, this._bankRepository) : super(const AddDmtVendorState());

  Future<void> loadBanks() async {
    emit(state.copyWith(status: AddDmtVendorStatus.initializing));
    var result = await _bankRepository.getAllBanks();

    result.when(success: (result) {
      emit(state.copyWith(
          status: AddDmtVendorStatus.initializationSuccess, banks: result));
    }, failure: (e) {
      emit(state.copyWith(status: AddDmtVendorStatus.initializationFailed));
      logger.e("Exception: $e");
    });
  }

  Future<void> addNewVendor(UserEntity userEntity,int bankId) async {
    emit(state.copyWith(status: AddDmtVendorStatus.loading));
    var result = await _userRepository.addNewUser(userEntity.copyWith(roleId: UserRole.vendor.roleId,isActive: true),bankId: bankId);

    result.when(success: (result) {
      emit(state.copyWith(status: AddDmtVendorStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddDmtVendorStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateVendor(
      int userId, UserEntity userEntity,int bankId) async {
    emit(state.copyWith(status: AddDmtVendorStatus.loading));
    var result = await _userRepository.updateUser(
        userId,userEntity,bankId: bankId);

    result.when(success: (result) {
      emit(state.copyWith(status: AddDmtVendorStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddDmtVendorStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }

}
