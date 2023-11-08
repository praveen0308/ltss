import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/action_entity.dart';
import 'package:ltss/remote/services/action_service.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionRepository with BaseRepository {
  final Dio _dio;
  late ActionService _actionService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  ActionRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _actionService = ActionService(_dio);
  }

  Future<ApiResult<List<ActionEntity>>> getAllActions() async {
    try {
      var result = await _actionService.getAllActions();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ActionEntity>> createNewAction(String name) async {
    try {
      var result = await _actionService.addNewAction(name);
      return Future.value(ApiResult.success(result));
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ActionEntity>> getAction(int actionId) async {
    try {
      var result = await _actionService.getAction(actionId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<ActionEntity>> updateAction(
      int actionId, String name, bool isActive) async {
    try {
      var result = await _actionService.updateAction(actionId, name, isActive);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<void>> deleteAction(int actionId) async {
    try {
      var result = await _actionService.deleteAction(actionId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
