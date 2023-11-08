import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';
import 'package:ltss/models/api/request/fund_request_request_model.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'fund_request_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class FundRequestService {
  factory FundRequestService(Dio dio, {String baseUrl}) = _FundRequestService;

  @GET("fund_requests/")
  Future<List<FundRequestEntity>> getAllFundRequests();

  @GET("fund_requests/sender/{id}")
  Future<List<FundRequestEntity>> getSentRequests(@Path("id") int userId);

  @GET("fund_requests/receiver/{id}")
  Future<List<FundRequestEntity>> getReceivedRequests(@Path("id") int userId);

  @POST("fund_requests/")
  Future<FundRequestEntity> raiseFundRequest(
      @Body() FundRequestRequestModel fundRequestRequestModel);

  @GET("fund_requests/{request_id}")
  Future<FundRequestEntity> getFundRequest(@Path("request_id") int requestId);

  @PUT("fund_requests/{request_id}")
  Future<FundRequestEntity> updateFundRequest(@Path("request_id") int requestId,
      @Query("amount") int amount, @Query("request_status") String status);

  @DELETE("fund_requests/{request_id}")
  Future<void> deleteFundRequest(@Path("request_id") int requestId);
}
