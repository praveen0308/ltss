import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/transaction_entity.dart';
import 'package:retrofit/http.dart';

part 'transaction_service.g.dart';

@RestApi()
abstract class TransactionService {
  factory TransactionService(Dio dio, {String baseUrl}) = _TransactionService;

  @GET("transactions/service_transaction/")
  Future<TransactionEntity> getTransaction(@Query("service_id") int serviceId,
      @Query("transaction_id") int transactionId);
}
