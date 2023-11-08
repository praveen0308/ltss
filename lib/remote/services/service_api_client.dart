
import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'service_api_client.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class ServiceApiClient {
  factory ServiceApiClient(Dio dio, {String baseUrl}) = _ServiceApiClient;

  @GET("services/")
  Future<List<ServiceEntity>> getAllServices();


  @POST("services/")
  Future<ServiceEntity> addNewService(@Query("name") String name,@Query("is_active") bool isActive);

  @GET("services/{service_id}")
  Future<ServiceEntity> getService(@Path("service_id") int serviceId);


  @PUT("services/{service_id}")
  Future<ServiceEntity> updateService(@Path("service_id") int serviceId,@Query("name") String name,@Query("is_active") bool isActive);

  @DELETE("services/{service_id}")
  Future<void> deleteService(@Path("service_id") int serviceId);

}
