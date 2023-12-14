part of 'kyc_form_cubit.dart';

@immutable
abstract class KycFormState {}

class KycFormInitial extends KycFormState {}
class SubmittingKYCForm extends KycFormState {}
class KYCFormDone extends KycFormState {}
class KYCFormFailed extends KycFormState {
  final String msg;

  KYCFormFailed(this.msg);
}
