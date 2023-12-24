import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:meta/meta.dart';

part 'manage_bank_vendor_state.dart';

class ManageBankVendorCubit extends BaseCubit<ManageBankVendorState> {
  final BankRepository _bankRepository;
  final UserRepository _userRepository;

  ManageBankVendorCubit(this._bankRepository, this._userRepository)
      : super(ManageBankVendorInitial());

  final List<BankEntity> banks = List.empty(growable: true);
  final List<BankVendor> bankVendors = List.empty(growable: true);
  final List<UserEntity> vendors = List.empty(growable: true);

  /*Future<void> fetchBankVendors() async {
    emit(LoadingBankVendors());
    var result = await _userRepository.getDmtVendors();

    result.when(success: (s) {
      emit(ReceivedBankVendors(s));
    }, failure: (e) {
      emit(LoadBankVendorsFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> fetchBanks() async {
    emit(LoadingBanks());
    var result = await _bankRepository.getAllBanks();

    result.when(success: (s) {
      emit(ReceivedBanks(s));
    }, failure: (e) {
      emit(LoadBanksFailed(e.message));
      logger.e("Exception: $e");
    });
  }
  Future<void> fetchVendors() async {
    emit(LoadingVendors());
    var result = await _userRepository.getUsersByRoleId(UserRole.vendor.roleId);

    result.when(success: (s) {
      emit(ReceivedVendors(s));
    }, failure: (e) {
      emit(LoadVendorsFailed(e.message));
      logger.e("Exception: $e");
    });
  }
*/
}
