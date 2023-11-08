import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/wallet_entity.dart';
import 'package:ltss/remote/services/wallet_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletRepository with BaseRepository {
  final Dio _dio;
  late WalletService _walletService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  WalletRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _walletService = WalletService(_dio);
  }

  Future<ApiResult<List<WalletEntity>>> getAllWallets() async {
    try {
      var result = await _walletService.getWallets();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<WalletEntity>> getWallet(String walletId) async {
    try {
      var result = await _walletService.getWallet(walletId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
