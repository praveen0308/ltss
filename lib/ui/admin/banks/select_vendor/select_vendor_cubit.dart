import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';

part 'select_vendor_state.dart';

class SelectVendorCubit extends BaseCubit<SelectVendorState> {
  final UserRepository _userRepository;
  final BankRepository _bankRepository;

  SelectVendorCubit(this._userRepository, this._bankRepository)
      : super(SelectVendorInitial());

  final List<BankVendor> bankVendors = List.empty(growable: true);
  BankVendor? selectedVendor;

  Future<void> fetchBankVendors(int? assignedVendor) async {
    emit(Initializing());

    var vendorsResult =
        await _userRepository.getUsersByRoleId(UserRole.vendor.roleId);
    var bankVendorsResult = await _userRepository.getDmtVendors();
    vendorsResult.when(success: (vendors) {
      bankVendorsResult.when(
          success: (bvList) {
            bankVendors.clear();
            for (var v in vendors) {
              var bv = bvList
                  .where((element) => element.vendorId == v.id)
                  .firstOrNull;
              if (bv != null) {
                bankVendors.add(bv);
                if (assignedVendor != null) {
                  if (bv.vendorId == assignedVendor) {
                    selectedVendor = bv;
                  }
                }
              } else {
                bankVendors.add(BankVendor(vendorId: v.id, vendor: v));
                if (assignedVendor != null) {
                  if (v.id == assignedVendor) {
                    selectedVendor = BankVendor(vendorId: v.id, vendor: v);
                  }
                }
              }
            }
            emit(ReceivedVendors(bankVendors));
          },
          failure: (e) {});
    }, failure: (e) {
      emit(InitializationFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateBankVendor(int bankId) async {
    emit(Updating());

    var result = await _bankRepository.updateBankVendor(
        bankId, selectedVendor?.vendorId);

    result.when(success: (bankVendor) {
      emit(UpdateSuccessful());
    }, failure: (e) {
      emit(UpdateFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  void assignToNone(int bankId) {
    selectedVendor = null;
    updateBankVendor(bankId);
  }

  void filterResult(String q) {
    List<BankVendor> filteredItems = List.empty(growable: true);
    for (var element in bankVendors) {
      if (element.vendor?.getName().contains(q) == true) {
        filteredItems.add(element);
      }
    }

    emit(ReceivedVendors(filteredItems));
  }

  void setSelectedVendor(BankVendor vendor){
    selectedVendor = vendor;
    emit(state);
  }
}
