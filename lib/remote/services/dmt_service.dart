
import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/request/create_commission_request_model.dart';
import 'package:ltss/utils/constants.dart';
import 'package:retrofit/http.dart';

part 'dmt_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class DMTService {
  factory DMTService(Dio dio, {String baseUrl}) = _DMTService;

  @GET("dmt/transactions/")
  Future<List<DmtTransaction>> getTransactions();


  @POST("dmt/")
  Future<DmtTransaction> addNewTransaction(@Body() DmtTransaction requestModel);

  @GET("dmt/{transaction_id}")
  Future<DmtTransaction> getTransaction(@Path("transaction_id") int transactionId);


  @PUT("dmt/{transaction_id}")
  Future<DmtTransaction> updateTransaction(@Path("transaction_id") int transactionId,@Body() DmtTransaction requestModel);

  @PUT("dmt/{transaction_id}")
  Future<DmtTransaction> updateTransactionStatus(@Path("transaction_id") int transactionId,@Body() String status);


  @DELETE("dmt/{transaction_id}")
  Future<void> deleteTransaction(@Path("transaction_id") int transactionId);

}
