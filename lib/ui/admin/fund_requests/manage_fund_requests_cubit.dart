import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';

part 'manage_fund_requests_state.dart';

class ManageFundRequestsCubit extends BaseCubit<ManageFundRequestsState> {
  final FundRequestRepository _fundRequestRepository;

  ManageFundRequestsCubit(this._fundRequestRepository)
      : super(ManageFundRequestsInitial());

  Future<void> fetchReceivedRequests() async {
    emit(LoadingData());

    var result = await _fundRequestRepository.getReceiverRequests();

    result.when(success: (data) {
      if (data.isNotEmpty) {
        var newRequests = data.where((element) => element.isRequested()).toList();
        var history = data.where((element) => !element.isRequested()).toList();

        emit(ReceivedData(newRequests,history));
      } else {
        emit(EmptyData());
      }
    }, failure: (e) {
      emit(LoadDataFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateFundRequest(int requestId, String status) async {
    emit(LoadingData());
    var result =
    await _fundRequestRepository.updateFundRequestStatus(requestId, status);

    result.when(success: (s) {
      emit(UpdateSuccessful());
    }, failure: (e) {
      emit(UpdateFailed(e.message));
      logger.e("Exception: $e");
    });
  }

}
