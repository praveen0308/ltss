import 'dart:async';

import 'package:dio/dio.dart';
import 'package:ltss/base/base_repository.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/local/token_manager.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/models/api/entity/user_detail_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/models/api/entity/user_stats.dart';
import 'package:ltss/remote/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository with BaseRepository {
  final Dio _dio;
  late UserService _userService;
  final SessionManager _sessionManager;
  final SharedPreferences _preferences;

  UserRepository(this._sessionManager, this._dio, this._preferences) {
    var token = TokenManager.getToken(_preferences);
    _dio.options.headers["Authorization"] = "Bearer $token";
    _userService = UserService(_dio);
  }

  Future<ApiResult<List<UserEntity>>> getAllUsers() async {
    try {
      var result = await _userService.getAllUsers();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<List<BankVendor>>> getDmtVendors() async {
    try {
      var result = await _userService.getDMTVendors();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<num>> getWalletBalance() async {
    try {
      var result = await _userService.getWalletBalance();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<List<UserEntity>>> getDistributors() async {
    try {
      var result = await _userService.getDistributors();
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<List<UserEntity>>> getUsersByRoleId(int roleId,
      {int? userId, bool loggedInUser = false}) async {
    try {
      if (loggedInUser && userId == null) {
        userId = await _sessionManager.getUserId();
      }
      var result =
          await _userService.getAddedUsers(roleId, userId: userId ?? 0);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<UserEntity>> addNewUser(UserEntity userEntity,{int? bankId}) async {
    try {
      var result = await _userService.createUser(userEntity,bankId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<UserEntity>> getUser(int userId) async {
    try {
      var result = await _userService.getUser(userId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<UserDetailEntity>> getUserDetail(int userId) async {
    try {
      var result = await _userService.getUserDetail(userId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<UserEntity>> getUserByMobile(String mobileNo) async {
    try {
      var result = await _userService.getUserByMobileNo(mobileNo);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<UserEntity>> updateUser(
      int userId, UserEntity userEntity,{int? bankId}) async {
    try {
      var result = await _userService.updateUserProfile(userId, userEntity,bankId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  Future<ApiResult<UserStats>> getUserStats(int roleId) async {
    try {
      var result = await _userService.getStatsByRoleId(roleId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

  /// status = true -> To unblock user
  /// and false -> to block user
  Future<ApiResult<void>> blockUser(int userId, {bool status = false}) async {
    try {
      var result = await _userService.blockUser(userId, status);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
  Future<ApiResult<BankEntity?>> getBank(int vendorId) async {
    try {
      var result = await _userService.getBank(vendorId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }
  Future<ApiResult<UserEntity?>> getVendor(int bankId) async {
    try {
      var result = await _userService.getVendor(bankId);
      return ApiResult.success(result);
    } on Exception catch (e) {
      return ApiResult.failure(NetworkExceptions.getApiError(e));
    }
  }

}
