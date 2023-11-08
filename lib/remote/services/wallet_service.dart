import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/wallet_entity.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'wallet_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class WalletService {
  factory WalletService(Dio dio, {String baseUrl}) = _WalletService;

  @GET("wallets/")
  Future<List<WalletEntity>> getWallets();

  @GET("users/{wallet_id}")
  Future<WalletEntity> getWallet(@Path("wallet_id") String walletId);


}
