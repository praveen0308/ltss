import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ltss/models/api/response/post_kyc_response.dart';
import 'package:retrofit/http.dart';

part 'kyc_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class KYCService {
  factory KYCService(Dio dio, {String baseUrl}) = _KYCService;

  @POST("kyc/")
  @MultiPart()
  Future<PostKycResponse> addKYCDetail(
      @Header("Authorization") String token,
      @Part(name: "user_id") int userId,
      @Part(name: "pan") String pan,
      @Part(name: "aadhaar") String aadhaar,
      @Part(name: "shop_image") File shopImage,
      @Part(name: "profile_image") File profileImage);

  @GET("kyc/status")
  Future<bool> kycStatus(@Header("Authorization") String token,);
}
