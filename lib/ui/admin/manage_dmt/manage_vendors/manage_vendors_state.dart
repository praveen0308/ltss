part of 'manage_vendors_cubit.dart';

@immutable
abstract class ManageVendorsState {}

class ManageVendorsInitial extends ManageVendorsState {}
class LoadingVendors extends ManageVendorsState {}
class LoadVendorsSuccessful extends ManageVendorsState {
  final List<BankVendor> items;

  LoadVendorsSuccessful(this.items);
}
class LoadVendorsFailed extends ManageVendorsState {
  final String msg;

  LoadVendorsFailed(this.msg);

}

