import 'package:ltss/base/base.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';

part 'request_page_state.dart';

class RequestPageCubit extends BaseCubit<RequestPageState> {
  final FundRequestRepository _fundRequestRepository;


  RequestPageCubit(this._fundRequestRepository) : super(RequestPageInitial());

  List<FundRequestEntity> sentRequests = [];
  List<FundRequestEntity> receivedRequests = [];

  Future<void> initUI() async{

  }

  Future<void> fetchSentRequests() async {
    emit(LoadingData());
    if(sentRequests.isEmpty){
      var result = await _fundRequestRepository.getSenderRequests();

      result.when(success: (result) {
        sentRequests.clear();
        sentRequests.addAll(result);
        if(sentRequests.isNotEmpty){
          emit(OnDataLoaded(sentRequests));
        }else{
          emit(EmptyData());
        }

      }, failure: (e) {
        emit(DataLoadFailed(e.message));
        logger.e("Exception: $e");
      });
    }else{
      emit(OnDataLoaded(sentRequests));
    }
  }

  Future<void> fetchReceivedRequests() async {
    emit(LoadingData());
    if(receivedRequests.isEmpty){
      var result = await _fundRequestRepository.getReceiverRequests();

      result.when(success: (result) {
        receivedRequests.clear();
        receivedRequests.addAll(result);
        if(receivedRequests.isNotEmpty){
          emit(OnDataLoaded(receivedRequests));
        }else{
          emit(EmptyData());
        }
      }, failure: (e) {
        emit(DataLoadFailed(e.message));
        logger.e("Exception: $e");
      });
    }else{
      emit(OnDataLoaded(receivedRequests));
    }
  }
}
