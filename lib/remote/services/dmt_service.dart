import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ltss/models/api/entity/beneficiary_entity.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';

import 'package:ltss/models/api/request/add_dmt_transaction_request.dart';
import 'package:retrofit/http.dart';
import 'package:ltss/models/api/sampurna/sampurna.dart';

part 'dmt_service.g.dart';

// @RestApi(baseUrl: AppConstants.baseApiUrl)
@RestApi()
abstract class DMTService {
  factory DMTService(Dio dio, {String baseUrl}) = _DMTService;

  @GET("dmt/transactions/")
  Future<List<DmtTransaction>> getTransactions(
      @Query("retailer_id") int? retailerId, @Query("vendor_id") int? vendorId);

  @GET("dmt/get_beneficiaries/")
  Future<List<BeneficiaryEntity>> getBeneficiaries(
      @Query("mobile_no") String mobileNo,
      @Query("reference_id") String referenceId);

  @POST("dmt/")
  Future<DmtTransaction> addNewTransaction(@Body() DmtTransaction requestModel);

  @GET("dmt/{transaction_id}")
  Future<DmtTransaction> getTransaction(
      @Path("transaction_id") int transactionId);

  @PUT("dmt/{transaction_id}")
  Future<DmtTransaction> updateTransaction(
      @Path("transaction_id") int transactionId,
      @Body() DmtTransaction requestModel);

  @PUT("dmt/{transaction_id}")
  @MultiPart()
  Future<DmtTransaction> updateTransactionStatus(
    @Query("transaction_id") int transactionId,
    @Query("status") String status,
    @Part(name: "screenshot") File? screenshot,
    @Query("comment") String? comment,
  );

  @DELETE("dmt/{transaction_id}")
  Future<void> deleteTransaction(@Path("transaction_id") int transactionId);

  @GET("sampurna_api/get_sender")
  Future<Sender> getSender(@Query("mobile_no") String mobileNo);

  @POST("sampurna_api/create_sender")
  Future<CreateSenderResponse> createSender(
      @Body() CreateSenderRequest senderRequest);

  @POST("sampurna_api/verify_sender")
  Future<VerifySenderResponse> verifySender(
      @Body() VerifySenderRequest request);

  @POST("sampurna_api/verify_account")
  Future<VerifyAccountResponse> verifyAccount(
      @Body() VerifyAccountRequest request);

  @POST("sampurna_api/add_beneficiary")
  Future<AddBeneficiaryResponse> addBeneficiary(
      @Body() AddBeneficiaryRequest request);

  @POST("sampurna_api/get_beneficiary")
  Future<GetBeneficiaryResponse> getBeneficiary(
      @Query("mobile_no") String mobileNo,
      @Query("reference_id") String referenceId);
}
