import 'package:ltss/base/base_cubit.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';

part 'manage_charge_state.dart';

class ManageChargeCubit extends BaseCubit<ManageChargeState> {
  final ChargeRepository _chargeRepository;
  ManageChargeCubit(this._chargeRepository) : super(ManageChargeInitial());

    Future<void> fetchCharges(int serviceId) async {
        emit(LoadingData());
        var result = await _chargeRepository.getAllCharges(serviceId: serviceId);

        result.when(success: (s) {
          emit(ReceivedData(s));
        }, failure: (e) {
          emit(LoadDataFailed(e.message));
          logger.e("Exception: $e");
        });
      }

}
