import 'package:ltss/base/base.dart';

part 'add_beneficiary_state.dart';

class AddBeneficiaryCubit extends BaseCubit<AddBeneficiaryState> {
  final DMTRepository _dmtRepository;
  final SessionManager _sessionManager;

  AddBeneficiaryCubit(this._dmtRepository, this._sessionManager)
      : super(AddBeneficiaryInitial());
}
