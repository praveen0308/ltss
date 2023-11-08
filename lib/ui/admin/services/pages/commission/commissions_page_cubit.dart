import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:meta/meta.dart';

part 'commissions_page_state.dart';

class CommissionsPageCubit extends BaseCubit<CommissionsPageState> {
  final CommissionRepository _commissionRepository;

  CommissionsPageCubit(this._commissionRepository)
      : super(CommissionsPageInitial());

  Future<void> loadData() async {
    emit(LoadingData());
    var result = await _commissionRepository.getAllCommissions();

    result.when(success: (result) {
      emit(ReceivedData(result));
    }, failure: (e) {
      emit(LoadDataFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> deleteCommission(int commissionId) async {
    emit(Deleting());
    var result = await _commissionRepository.deleteCommission(commissionId);

    result.when(success: (result) {
      emit(DeletionSuccessful());
    }, failure: (e) {
      emit(DeletionFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
