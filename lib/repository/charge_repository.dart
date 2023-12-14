import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:ltss/models/api/request/create_charge_request_model.dart';
import 'package:ltss/remote/services/charge_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChargeRepository with BaseRepository {
  final Dio _dio;
  late ChargeService _chargeService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  ChargeRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _chargeService = ChargeService(_dio);
  }

  Future<ApiResult<List<ChargeEntity>>> getAllCharges({int serviceId=0}) async {
    try {
      var result = await _chargeService.getAllCharges(serviceId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ChargeEntity>> addNewCharge(
      int serviceId, String name, String value, bool isActive) async {
    try {
      var result = await _chargeService.addNewCharge(CreateChargeRequestModel(
          serviceId: serviceId, name: name, value: value, isActive: isActive));
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ChargeEntity>> getCharge(int chargeId) async {
    try {
      var result = await _chargeService.getCharge(chargeId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ChargeEntity>> updateCharge(int chargeId, int serviceId,
      String name, String value, bool isActive) async {
    try {
      var result = await _chargeService.updateCharge(
          chargeId,
          CreateChargeRequestModel(
              serviceId: serviceId,
              name: name,
              value: value,
              isActive: isActive));
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<void>> deleteCharge(int chargeId) async {
    try {
      var result = await _chargeService.deleteCharge(chargeId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
