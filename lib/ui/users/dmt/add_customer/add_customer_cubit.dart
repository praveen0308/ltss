import 'package:ltss/base/base.dart';

part 'add_customer_state.dart';

class AddCustomerCubit extends BaseCubit<AddCustomerState> {
  final DMTRepository _dmtRepository;
  final SessionManager _sessionManager;
  AddCustomerCubit(this._dmtRepository, this._sessionManager) : super(AddCustomerInitial());
}
