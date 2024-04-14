import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/action_entity.dart';
import 'package:retrofit/http.dart';

part 'action_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class ActionService {
  factory ActionService(Dio dio, {String baseUrl}) = _ActionService;

  @GET("actions/")
  Future<List<ActionEntity>> getAllActions();

  @POST("actions/")
  Future<ActionEntity> addNewAction(@Query("name") String name);

  @GET("actions/{action_id}")
  Future<ActionEntity> getAction(@Path("action_id") int actionId);

  @PUT("actions/{action_id}")
  Future<ActionEntity> updateAction(@Path("action_id") int actionId,@Query("name") String name,@Query("is_active") bool isActive);

  @DELETE("actions/{action_id}")
  Future<void> deleteAction(@Path("action_id") int actionId);

}
