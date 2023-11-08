import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:meta/meta.dart';

part 'charges_page_state.dart';

class ChargesPageCubit extends BaseCubit<ChargesPageState> {

  final ChargeRepository _chargeRepository;
  ChargesPageCubit(this._chargeRepository) : super(ChargesPageInitial());


  Future<void> loadData() async {
    emit(LoadingData());
    var result = await _chargeRepository.getAllCharges();

    result.when(success: (result) {

      emit(ReceivedData(result));
    }, failure: (e) {
      emit(LoadDataFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> deleteCharge(int chargeId) async {
    emit(Deleting());
    var result = await _chargeRepository.deleteCharge(chargeId);

    result.when(success: (result) {
      emit(DeletionSuccessful());
    }, failure: (e) {
      emit(DeletionFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
