import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/fund_request_entity.dart';
import 'package:ltss/models/api/request/fund_request_request_model.dart';
import 'package:ltss/remote/services/fund_request_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FundRequestRepository with BaseRepository {
  final Dio _dio;
  late FundRequestService _fundRequestService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  FundRequestRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _fundRequestService = FundRequestService(_dio);
  }

  Future<ApiResult<List<FundRequestEntity>>> getAllFundRequests() async {
    try {
      var result = await _fundRequestService.getAllFundRequests();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<List<FundRequestEntity>>> getSenderRequests({int? userId}) async {
    try {
      int uid = 0;
      if (userId != null) {
        uid = userId;
      } else {
        uid = await _sessionManager.getUserId();
      }
      var result = await _fundRequestService.getSentRequests(uid);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<List<FundRequestEntity>>> getReceiverRequests(
      {int? userId}) async {
    try {
      int uid = 0;
      if (userId != null) {
        uid = userId;
      } else {
        uid = await _sessionManager.getUserId();
      }
      var result = await _fundRequestService.getReceivedRequests(uid);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<FundRequestEntity>> addNewFundRequest(
      int receiverId, double amount) async {
    try {
      var userId = await _sessionManager.getUserId();
      var result = await _fundRequestService.raiseFundRequest(
          FundRequestRequestModel(
              sender: userId, receiver: receiverId, amount: amount));
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<FundRequestEntity>> getFundRequest(int requestId) async {
    try {
      var result = await _fundRequestService.getFundRequest(requestId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<FundRequestEntity>> updateFundRequest(
      int requestId, int amount, String status) async {
    try {
      var result = await _fundRequestService.updateFundRequest(
          requestId, amount, status);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<void>> deleteFundRequest(int requestId) async {
    try {
      var result = await _fundRequestService.deleteFundRequest(requestId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
