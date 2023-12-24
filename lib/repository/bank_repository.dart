import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/remote/services/bank_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankRepository with BaseRepository {
  late BankService _bankService;
  final SessionManager _sessionManager;
  final Dio _dio;
  final SharedPreferences _preferences;

  BankRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _bankService = BankService(_dio);
  }

  Future<ApiResult<List<BankEntity>>> getAllBanks() async {
    try {
      var result = await _bankService.getAllBanks();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<BankEntity>> addNewBank(BankEntity bankEntity,int? vendorId) async {
    try {
      var result = await _bankService.addNewBank(bankEntity,vendorId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<BankEntity>> getBank(int bankId) async {
    try {
      var result = await _bankService.getBank(bankId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<BankEntity>> updateBank(
      int bankId, BankEntity bankEntity,int? vendorId) async {
    try {
      var result = await _bankService.updateBank(bankId, bankEntity,vendorId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }


  Future<ApiResult<BankVendor>> updateBankVendor(
      int bankId, int? vendorId) async {
    try {
      var result = await _bankService.updateBankVendor(bankId, vendorId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<void>> deleteBank(int bankId) async {
    try {
      var result = await _bankService.deleteBank(bankId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
