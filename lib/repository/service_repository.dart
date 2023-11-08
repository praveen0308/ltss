import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:ltss/remote/services/service_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceRepository with BaseRepository {
  final Dio _dio;
  late ServiceApiClient _serviceApiClient;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  ServiceRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _serviceApiClient = ServiceApiClient(_dio);
  }

  Future<ApiResult<List<ServiceEntity>>> getAllServices() async {
    try {
      var result = await _serviceApiClient.getAllServices();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ServiceEntity>> addNewService(String name,bool isActive) async {
    try {
      var result = await _serviceApiClient.addNewService(name,isActive);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ServiceEntity>> getService(int serviceId) async {
    try {
      var result = await _serviceApiClient.getService(serviceId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ServiceEntity>> updateService(
      int serviceId, String name, bool isActive) async {
    try {
      var result =
          await _serviceApiClient.updateService(serviceId, name, isActive);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<void>> deleteService(int serviceId) async {
    try {
      var result = await _serviceApiClient.deleteService(serviceId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
