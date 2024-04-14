import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/service_entity.dart';

part 'service_page_state.dart';

class ServicePageCubit extends BaseCubit<ServicePageState> {
  final ServiceRepository _serviceRepository;
  ServicePageCubit(this._serviceRepository) : super(ServicePageInitial());

  Future<void> loadData() async {
    emit(LoadingData());
    var result = await _serviceRepository.getAllServices();

    result.when(success: (result) {

      emit(ReceivedData(result));
    }, failure: (e) {
      emit(LoadDataFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> deleteService(int serviceId) async {
    emit(Deleting());
    var result = await _serviceRepository.deleteService(serviceId);

    result.when(success: (result) {
      emit(DeletionSuccessful());
    }, failure: (e) {
      emit(DeletionFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
