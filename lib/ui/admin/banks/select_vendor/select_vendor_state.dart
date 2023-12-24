part of 'select_vendor_cubit.dart';

sealed class SelectVendorState {}

class SelectVendorInitial extends SelectVendorState {}
class Initializing extends SelectVendorState {}
class ReceivedVendors extends SelectVendorState {
  final List<BankVendor> vendors;

  ReceivedVendors(this.vendors);
}
class InitializationFailed extends SelectVendorState {
  final String msg;

  InitializationFailed(this.msg);
}

class Updating extends SelectVendorState {}
class UpdateSuccessful extends SelectVendorState {}
class UpdateFailed extends SelectVendorState {
  final String msg;

  UpdateFailed(this.msg);

}
