import 'package:ltss/base/base.dart';

part 'add_service_state.dart';

class AddServiceCubit extends BaseCubit<AddServiceState> {
  final ServiceRepository _serviceRepository;
  AddServiceCubit(this._serviceRepository) : super(const AddServiceState());

  Future<void> addNewService(String name,bool isActive) async {
    emit(state.copyWith(status:AddServiceStatus.loading));
    var result = await _serviceRepository.addNewService(name,isActive);

    result.when(success: (result) {

      emit(state.copyWith(status: AddServiceStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddServiceStatus.error,msg: e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateService(int serviceId,String name,bool isActive) async {
    emit(state.copyWith(status:AddServiceStatus.loading));
    var result = await _serviceRepository.updateService(serviceId,name,isActive);

    result.when(success: (result) {

      emit(state.copyWith(status: AddServiceStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddServiceStatus.error,msg: e.message));
      logger.e("Exception: $e");
    });
  }

}
