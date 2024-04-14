import 'package:ltss/base/base_cubit.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';

part 'manage_commission_state.dart';

class ManageCommissionCubit extends BaseCubit<ManageCommissionState> {
  final CommissionRepository _commissionRepository;
  ManageCommissionCubit(this._commissionRepository) : super(ManageCommissionInitial());

    Future<void> fetchCommissions(int serviceId) async {
        emit(LoadingData());
        var result = await _commissionRepository.getAllCommissions(serviceId: serviceId);

        result.when(success: (s) {
          emit(ReceivedData(s));
        }, failure: (e) {
          emit(LoadDataFailed(e.message));
          logger.e("Exception: $e");
        });
      }

}
