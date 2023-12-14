import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';

part 'commission_view_state.dart';

class CommissionViewCubit extends BaseCubit<CommissionViewState> {
  final CommissionRepository _commissionRepository;
  CommissionViewCubit(this._commissionRepository) : super(CommissionViewInitial());
  Future<void> updateCommission(
      int commissionId, int serviceId, String name, String value,bool isActive) async {
    emit(Updating());
    var result = await _commissionRepository.updateCommission(
        commissionId, serviceId, name, value,isActive);

    result.when(success: (result) {
      emit(UpdateSuccessful(result));
    }, failure: (e) {
      emit(UpdateFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  void resetUI(){
    emit(CommissionViewInitial());
  }
}
