import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/response/post_kyc_response.dart';
import 'package:ltss/remote/services/kyc_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KYCRepository with BaseRepository {
  final Dio _dio;
  late KYCService _kycService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  KYCRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _kycService = KYCService(_dio);
  }

  Future<ApiResult<PostKycResponse>> postKYC(int userId, String pan,
      String aadhaar, File shopImage, File profileImage) async {
    try {
      var result = await _kycService.addKYCDetail(
          userId, pan, aadhaar, shopImage, profileImage);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
