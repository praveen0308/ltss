import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/models/api/request/update_profile_request_model.dart';
import 'package:ltss/models/api/response/request_otp_response.dart';
import 'package:ltss/models/api/response/token_response.dart';
import 'package:retrofit/http.dart';

part 'auth_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @GET("auth/me")
  Future<UserEntity> getProfile(@Header("Authorization") String token);

  @PUT("auth/update")
  Future<UserEntity> updateProfile(@Header("Authorization") String token,
      @Body() UpdateProfileRequestModel payload);

  @GET("auth/request_otp")
  Future<RequestOtpResponse> requestOTP(@Query("mobile_no") String mobileNo);

  @POST("auth/verify_otp")
  Future<TokenResponse> verifyOTP(
      @Query("mobile_no") String mobileNo, @Query("otp") String otp);
}
