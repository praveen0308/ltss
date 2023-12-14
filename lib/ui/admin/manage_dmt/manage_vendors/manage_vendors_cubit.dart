import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';

part 'manage_vendors_state.dart';

class ManageVendorsCubit extends BaseCubit<ManageVendorsState> {
  final UserRepository _userRepository;
  ManageVendorsCubit(this._userRepository) : super(ManageVendorsInitial());

  Future<void> loadVendors() async {
    emit(LoadingVendors());
    var result = await _userRepository.getDmtVendors();

    result.when(success: (result) {

      emit(LoadVendorsSuccessful(result));
    }, failure: (e) {
      emit(LoadVendorsFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
