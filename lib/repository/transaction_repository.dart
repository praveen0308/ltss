import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/beneficiary_entity.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/entity/transaction_entity.dart';
import 'package:ltss/models/api/sampurna/sampurna.dart';
import 'package:ltss/remote/services/dmt_service.dart';
import 'package:ltss/remote/services/transaction_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api/sampurna/sender.dart';

class TransactionRepository with BaseRepository {
  final Dio _dio;
  late TransactionService _transactionService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  TransactionRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _transactionService = TransactionService(_dio);
  }

  Future<ApiResult<TransactionEntity>> getServiceTransaction(int serviceId,int transactionId) async {
    try {
      var result = await _transactionService.getTransaction(serviceId,transactionId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

}
