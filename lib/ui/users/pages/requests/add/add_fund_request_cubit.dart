import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';

part 'add_fund_request_state.dart';

class AddFundRequestCubit extends BaseCubit<AddFundRequestState> {
  final FundRequestRepository _fundRequestRepository;
  final UserRepository _userRepository;

  AddFundRequestCubit(this._fundRequestRepository, this._userRepository)
      : super(AddFundRequestInitial());

  Future<void> loadDistributors() async {
    emit(LoadingDistributors());

    var result = await _userRepository.getDistributors();

    result.when(success: (result) {
      if (result.isNotEmpty) {
        emit(DistributorsLoaded(result));
      } else {
        emit(LoadDistributorsFailed("No Distributors!!"));
      }
    }, failure: (e) {
      emit(LoadDistributorsFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> addFundRequest(int distributor,double amount,String comment) async {
    emit(AddingRequest());

    var result = await _fundRequestRepository.addNewFundRequest( distributor, amount,comment);

    result.when(success: (result) {
      emit(AddedSuccessfully());
    }, failure: (e) {
      emit(AddFundRequestFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
