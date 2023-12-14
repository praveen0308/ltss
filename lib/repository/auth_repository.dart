import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/models/api/request/update_profile_request_model.dart';
import 'package:ltss/models/api/response/request_otp_response.dart';
import 'package:ltss/models/api/response/token_response.dart';
import 'package:ltss/remote/services/auth_service.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository with BaseRepository {
  final Dio _dio;
  final SessionManager _sessionManager;
  late AuthService _authService;
  final SharedPreferences _preferences;

  AuthRepository(this._sessionManager, this._dio, this._preferences) {
    _authService = AuthService(_dio);
    /*if (Platform.isWindows) {
      _authService = AuthService(_dio, baseUrl: AppConstants.localWindowsBaseUrl);
    } else {
      _authService = AuthService(_dio,baseUrl: AppConstants.emulatorBaseUrl);
    }*/
  }

  Future<ApiResult<UserEntity>> getProfile() async {
    var token = TokenManager.getToken(_preferences);

    try {
      var result = await _authService.getProfile("Bearer $token");
      await _sessionManager.updateUserId(result.id ?? 0);
      await _sessionManager.updateRoleId(result.roleId ?? 0);
      await _sessionManager.updateFirstName(result.firstName ?? "");
      await _sessionManager.updateLastName(result.lastName ?? "");
      await _sessionManager.updateEmail(result.email ?? "");
      await _sessionManager.updateMobileNumber(result.mobileNo ?? "");
      await _sessionManager.updateAddress(result.address ?? "");
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<UserEntity>> updateProfile(
      {String? firstName,String? lastName, String? email, String? address}) async {
    var token = TokenManager.getToken(_preferences);

    try {
      var result = await _authService.updateProfile(
          "Bearer $token",
          UpdateProfileRequestModel(
              firstName: firstName,lastName: lastName, email: email, address: address));
      await _sessionManager.updateFirstName(result.firstName ?? "");
      await _sessionManager.updateLastName(result.lastName ?? "");
      await _sessionManager.updateEmail(result.email ?? "");
      await _sessionManager.updateAddress(result.address ?? "");
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<RequestOtpResponse>> requestOTP(String mobileNo) async {
    try {
      var result = await _authService.requestOTP(mobileNo);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<TokenResponse>> verifyOTP(
      String mobileNo, String otp) async {
    try {
      var result = await _authService.verifyOTP(mobileNo, otp);
      if (result.access_token != null) {
        await _sessionManager.updateToken(result.access_token!);
        await TokenManager.saveToken(_preferences, result.access_token!);
      }
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
