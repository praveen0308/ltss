import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/beneficiary_entity.dart';
import 'package:ltss/models/api/sampurna/sampurna.dart';

part 'select_beneficiary_state.dart';

class SelectBeneficiaryCubit extends BaseCubit<SelectBeneficiaryState> {
  final DMTRepository _dmtRepository;
  final SessionManager _sessionManager;
  SelectBeneficiaryCubit(this._dmtRepository, this._sessionManager) : super(SelectBeneficiaryInitial());

  Future<void> fetchData(String mobileNo) async {
    emit(LoadingData());

    var result = await _dmtRepository.getBeneficiary(mobileNo);

    result.when(success: (result) {
      if(result.beneficiaries!=null && result.beneficiaries!.isNotEmpty){
        emit(ReceivedData(result.beneficiaries!));
      }else{
        emit(NoBeneficiariesFound());
      }

    }, failure: (e) {
      emit(LoadDataFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
