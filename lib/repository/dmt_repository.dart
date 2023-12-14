import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/beneficiary_entity.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/sampurna/sampurna.dart';
import 'package:ltss/remote/services/dmt_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api/sampurna/sender.dart';

class DMTRepository with BaseRepository {
  final Dio _dio;
  late DMTService _dmtService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  DMTRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _dmtService = DMTService(_dio);
  }

  Future<ApiResult<List<DmtTransaction>>> getTransactions() async {
    try {
      var result = await _dmtService.getTransactions();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }


  Future<ApiResult<List<BeneficiaryEntity>>> getBeneficiaries(
      String mobileNo, {String referenceId = ""}) async {

    try {
      var result = await _dmtService.getBeneficiaries(mobileNo,"");

      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<DmtTransaction>> addNewTransaction(
      DmtTransaction transaction) async {
    try {
      var result = await _dmtService.addNewTransaction(transaction);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<DmtTransaction>> getTransaction(int transactionId) async {
    try {
      var result = await _dmtService.getTransaction(transactionId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<DmtTransaction>> updateTransaction(
      int transactionId, DmtTransaction transaction) async {
    try {
      var result =
          await _dmtService.updateTransaction(transactionId, transaction);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<DmtTransaction>> updateTransactionStatus(
      int transactionId, String status) async {
    try {
      var result =
          await _dmtService.updateTransactionStatus(transactionId, status);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<void>> deleteDMT(int transactionId) async {
    try {
      var result = await _dmtService.deleteTransaction(transactionId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<Sender>> getSender(String mobileNo) async {
    try {
      var result = await _dmtService.getSender(mobileNo);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<CreateSenderResponse>> createSender(
      CreateSenderRequest request) async {
    try {
      var result = await _dmtService.createSender(request);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<VerifySenderResponse>> verifySender(
      VerifySenderRequest request) async {
    try {
      var result = await _dmtService.verifySender(request);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<VerifyAccountResponse>> verifyAccount(
      VerifyAccountRequest request) async {
    try {
      var result = await _dmtService.verifyAccount(request);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<AddBeneficiaryResponse>> addBeneficiary(
      AddBeneficiaryRequest request) async {
    try {
      var result = await _dmtService.addBeneficiary(request);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<GetBeneficiaryResponse>> getBeneficiary(
      String mobileNo, {String referenceId=""}) async {
    try {
      var result = await _dmtService.getBeneficiary(mobileNo, referenceId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
}
