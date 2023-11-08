import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/service_entity.dart';


part 'add_charge_state.dart';

class AddChargeCubit extends BaseCubit<AddChargeState> {
  final ChargeRepository _chargeRepository;
  final ServiceRepository _serviceRepository;
  AddChargeCubit(this._chargeRepository, this._serviceRepository) : super(const AddChargeState());

  Future<void> loadServices() async {
    emit(state.copyWith(status: AddChargeStatus.initializing));
    var result = await _serviceRepository.getAllServices();

    result.when(success: (result) {

      emit(state.copyWith(status: AddChargeStatus.initializationSuccess,services: result));
    }, failure: (e) {
      emit(state.copyWith(status: AddChargeStatus.initializationFailed));
      logger.e("Exception: $e");
    });
  }
  Future<void> addNewCharge(int serviceId,String name,String value,bool isActive) async {
    emit(state.copyWith(status:AddChargeStatus.loading));
    var result = await _chargeRepository.addNewCharge(serviceId, name, value,isActive);

    result.when(success: (result) {

      emit(state.copyWith(status: AddChargeStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddChargeStatus.error,msg: e.message));
      logger.e("Exception: $e");
    });
  }


  Future<void> updateCharge(int chargeId,int serviceId,String name,String value,bool isActive) async {
    emit(state.copyWith(status:AddChargeStatus.loading));
    var result = await _chargeRepository.updateCharge(chargeId,serviceId, name, value,isActive);

    result.when(success: (result) {

      emit(state.copyWith(status: AddChargeStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddChargeStatus.error,msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
