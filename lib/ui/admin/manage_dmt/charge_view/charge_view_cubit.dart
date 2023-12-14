import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';

part 'charge_view_state.dart';

class ChargeViewCubit extends BaseCubit<ChargeViewState> {
  final ChargeRepository _chargeRepository;
  ChargeViewCubit(this._chargeRepository) : super(ChargeViewInitial());
  Future<void> updateCharge(
      int chargeId, int serviceId, String name, String value,bool isActive) async {
    emit(Updating());
    var result = await _chargeRepository.updateCharge(
        chargeId, serviceId, name, value,isActive);

    result.when(success: (result) {
      emit(UpdateSuccessful(result));
    }, failure: (e) {
      emit(UpdateFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  void resetUI(){
    emit(ChargeViewInitial());
  }
}
