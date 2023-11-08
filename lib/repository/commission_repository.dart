import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:ltss/models/api/request/create_commission_request_model.dart';
import 'package:ltss/remote/services/commission_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommissionRepository with BaseRepository {
  final Dio _dio;
  late CommissionService _commissionService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  CommissionRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _commissionService = CommissionService(_dio);
  }

  Future<ApiResult<List<CommissionEntity>>> getAllCommissions() async {
    try {
      var result = await _commissionService.getAllCommissions();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<CommissionEntity>> addNewCommission(
      int serviceId, String name, String value, bool isActive) async {
    try {
      var result = await _commissionService.addNewCommission(
          CreateCommissionRequestModel(
              serviceId: serviceId,
              name: name,
              value: value,
              isActive: isActive));
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<CommissionEntity>> getCommission(int commissionId) async {
    try {
      var result = await _commissionService.getCommission(commissionId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<CommissionEntity>> updateCommission(int commissionId,
      int serviceId, String name, String value, bool isActive) async {
    try {
      var result = await _commissionService.updateCommission(
          commissionId,
          CreateCommissionRequestModel(
              serviceId: serviceId,
              name: name,
              value: value,
              isActive: isActive));

      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<void>> deleteCommission(int commissionId) async {
    try {
      var result = await _commissionService.deleteCommission(commissionId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
