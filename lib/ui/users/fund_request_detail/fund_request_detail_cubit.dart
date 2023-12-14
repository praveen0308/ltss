import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';

part 'fund_request_detail_state.dart';

class FundRequestDetailCubit extends BaseCubit<FundRequestDetailState> {
  final FundRequestRepository _fundRequestRepository;
  final SessionManager _sessionManager;

  FundRequestDetailCubit(this._fundRequestRepository, this._sessionManager)
      : super(const FundRequestDetailState());

  Future<void> loadUI(FundRequestEntity data) async {
    emit(state.copyWith(status: FundRequestDetailStatus.initializing));
    try {
      var userId = await _sessionManager.getUserId();
      var canAcceptReject = data.isRequested() && data.receiverId == userId;
      var canRevoke = data.isRequested() && data.senderId == userId;

      emit(state.copyWith(
          status: FundRequestDetailStatus.initializationSuccess,
          canAcceptReject: canAcceptReject,
          canRevoke: canRevoke,
          data: data));
    } catch (e) {
      emit(state.copyWith(
          status: FundRequestDetailStatus.initializationFailed,
          msg: "Initialization failed!!!"));
    }
  }

  Future<void> updateFundRequest(int requestId, String status) async {
    emit(state.copyWith(status: FundRequestDetailStatus.loading));
    var result =
        await _fundRequestRepository.updateFundRequestStatus(requestId, status);

    result.when(success: (s) {
      emit(state.copyWith(
          status: FundRequestDetailStatus.success,
          msg: "Fund request $status successfully!!"));
    }, failure: (e) {
      emit(state.copyWith(
          status: FundRequestDetailStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> fetchRequestDetail(int requestId) async {
    emit(state.copyWith(status: FundRequestDetailStatus.initializing));
    var result = await _fundRequestRepository.getFundRequest(requestId);

    result.when(success: (s) {
      emit(state.copyWith(
          status: FundRequestDetailStatus.initializationSuccess, data: s));
    }, failure: (e) {
      emit(state.copyWith(
          status: FundRequestDetailStatus.initializationFailed,
          msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
