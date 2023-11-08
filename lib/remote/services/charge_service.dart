
import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:ltss/models/api/request/create_charge_request_model.dart';
import 'package:ltss/models/api/request/create_commission_request_model.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'charge_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class ChargeService {
  factory ChargeService(Dio dio, {String baseUrl}) = _ChargeService;

  @GET("charges/")
  Future<List<ChargeEntity>> getAllCharges();


  @POST("charges/")
  Future<ChargeEntity> addNewCharge(@Body() CreateChargeRequestModel requestModel);

  @GET("charges/{charge_id}")
  Future<ChargeEntity> getCharge(@Path("charge_id") int chargeId);


  @PUT("charges/{charge_id}")
  Future<ChargeEntity> updateCharge(@Path("charge_id") int chargeId,@Body() CreateChargeRequestModel requestModel);


  @DELETE("charges/{charge_id}")
  Future<void> deleteCharge(@Path("charge_id") int chargeId);

}
