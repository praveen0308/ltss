import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/request/fund_request_request_model.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'bank_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class BankService {
  factory BankService(Dio dio, {String baseUrl}) = _BankService;

  @GET("banks/")
  Future<List<BankEntity>> getAllBanks();

  @POST("banks/")
  Future<BankEntity> addNewBank(@Query("name") String name);

  @GET("banks/{bank_id}")
  Future<BankEntity> getBank(@Path("bank_id") int bankId);

  @PUT("banks/{bank_id}")
  Future<BankEntity> updateBank(@Path("bank_id") int bankId,@Query("name") String name,@Query("is_active") bool isActive);

  @DELETE("banks/{bank_id}")
  Future<void> deleteBank(@Path("bank_id") int bankId);

}
