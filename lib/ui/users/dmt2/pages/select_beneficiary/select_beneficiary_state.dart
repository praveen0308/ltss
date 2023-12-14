part of 'select_beneficiary_cubit.dart';

sealed class SelectBeneficiaryState {}

class SelectBeneficiaryInitial extends SelectBeneficiaryState {}
class LoadingData extends SelectBeneficiaryState {}
class NoBeneficiariesFound extends SelectBeneficiaryState {}
class ReceivedData extends SelectBeneficiaryState {
  final List<Beneficiary> data;

  ReceivedData(this.data);
}
class LoadDataFailed extends SelectBeneficiaryState {
  final String msg;

  LoadDataFailed(this.msg);
}
