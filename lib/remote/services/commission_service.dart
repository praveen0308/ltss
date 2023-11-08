
import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:ltss/models/api/request/create_commission_request_model.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'commission_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class CommissionService {
  factory CommissionService(Dio dio, {String baseUrl}) = _CommissionService;

  @GET("commissions/")
  Future<List<CommissionEntity>> getAllCommissions();


  @POST("commissions/")
  Future<CommissionEntity> addNewCommission(@Body() CreateCommissionRequestModel requestModel);

  @GET("commissions/{commission_id}")
  Future<CommissionEntity> getCommission(@Path("commission_id") int commissionId);


  @PUT("commissions/{commission_id}")
  Future<CommissionEntity> updateCommission(@Path("commission_id") int commissionId,@Body() CreateCommissionRequestModel requestModel);


  @DELETE("commissions/{commission_id}")
  Future<void> deleteCommission(@Path("commission_id") int commissionId);

}
