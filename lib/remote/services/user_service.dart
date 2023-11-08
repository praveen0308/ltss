import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/user_detail_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/models/api/entity/user_stats.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'user_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET("users/all")
  Future<List<UserEntity>> getAllUsers();

  @GET("users/wallet_balance")
  Future<num> getWalletBalance();

  @GET("users/distributors")
  Future<List<UserEntity>> getDistributors();

  @POST("users/")
  Future<UserEntity> createUser(@Body() UserEntity userEntity);

  @GET("users/")
  Future<List<UserEntity>> getAddedUsers(@Query("role_id") int roleId,
      {@Query("user_id") int userId = 0});

  @GET("users/detail/{user_id}")
  Future<UserDetailEntity> getUserDetail(@Path("user_id") int userId);

  @GET("users/{user_id}")
  Future<UserEntity> getUser(@Path("user_id") int userId);

  @PUT("users/{user_id}")
  Future<UserEntity> updateUserProfile(
      @Path("user_id") int userId, @Body() UserEntity userEntity);

  @GET("users/mobile_no/{mobile_no}")
  Future<UserEntity> getUserByMobileNo(@Path("mobile_no") String mobileNo);

  @GET("users/stats/{role_id}")
  Future<UserStats> getStatsByRoleId(@Path("role_id") int roleId);

  @PUT("users/block/{user_id}")
  Future<void> blockUser(
      @Path("user_id") int userId, @Query("user_status") bool status);
}
