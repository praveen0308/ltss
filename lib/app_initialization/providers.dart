import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/remote/utils/api_constats.dart';
import 'package:ltss/repository/transaction_repository.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:ltss/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProviders {
  static getAppProviders(SharedPreferences preferences,String baseUrl) async {
    final sessionManager = SessionManager();
    final dio = Dio();
    final options = BaseOptions(
      connectTimeout:
          const Duration(seconds: ApiConstants.connectTimeoutInSecs),
      receiveTimeout:
          const Duration(seconds: ApiConstants.receiveTimeoutInSecs),
    );

    dio.options = options;

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false));
    options.baseUrl = baseUrl;

    return [
      RepositoryProvider(create: (context) => sessionManager),
      RepositoryProvider(
          create: (context) =>
              ActionRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              AuthRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              BankRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              ChargeRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              CommissionRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) => DMTRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) => TransactionRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              FundRequestRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) => KYCRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              ServiceRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              UserRepository(sessionManager, dio, preferences)),
      RepositoryProvider(
          create: (context) =>
              WalletRepository(sessionManager, dio, preferences)),
    ];
  }
}
