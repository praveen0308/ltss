import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/sampurna/sampurna.dart';

part 'search_customer_state.dart';

class SearchCustomerCubit extends BaseCubit<SearchCustomerState> {
  final DMTRepository _dmtRepository;

  SearchCustomerCubit(this._dmtRepository) : super(SearchCustomerState());

  String mobileNo = "";
  Sender? sender;
  Beneficiary? selectedBeneficiary;
  Future<void> searchCustomer() async {
    emit(state.copyWith(sender: DataStatus.loading()));

    var result = await _dmtRepository.getSender(mobileNo);
    result.when(success: (result) {
      if (result.errorCode == 216) {
        sender = result;
        emit(state.copyWith(status: SearchCustomerStatus.customerDataLoaded,sender: DataStatus.data(result)));

      } else {
        emit(state.copyWith(sender: DataStatus.error("Customer not found!!")));
      }
    }, failure: (e) {
      emit(state.copyWith(
          status: SearchCustomerStatus.error,
          msg: e.message,
          sender: DataStatus.empty()));
      logger.e("Exception: $e");
    });
  }

  Future<void> fetchBeneficiaries() async {
    emit(state.copyWith(beneficiaries: DataStatus.loading()));

    var result = await _dmtRepository.getBeneficiary(mobileNo);

    result.when(success: (result) {
      if (result.beneficiaries != null && result.beneficiaries!.isNotEmpty) {
        selectedBeneficiary = result.beneficiaries!.first;
        emit(state.copyWith(
            beneficiaries: DataStatus.data(result.beneficiaries!),canProceed: true));
      } else {
        emit(state.copyWith(
            beneficiaries: DataStatus.error("No beneficiaries found!!")));
      }
    }, failure: (e) {
      emit(state.copyWith(
          status: SearchCustomerStatus.error,
          msg: e.message,
          beneficiaries: DataStatus.empty()));
      logger.e("Exception: $e");
    });
  }

  void resetData(String mobileNo) {
    this.mobileNo =mobileNo;
    sender = null;
    selectedBeneficiary = null;
    emit(state.copyWith(
      sender: DataStatus.empty(),
      beneficiaries: DataStatus.empty(),
      canProceed: false,
    ));
  }

  void setBeneficiary(Beneficiary beneficiary){
    selectedBeneficiary = beneficiary;
    emit(state);
  }
}
