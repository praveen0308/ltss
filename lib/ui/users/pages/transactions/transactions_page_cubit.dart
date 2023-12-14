import 'package:ltss/base/base.dart';

part 'transactions_page_state.dart';

class TransactionsPageCubit extends BaseCubit<TransactionsPageState> {
  final DMTRepository _dmtRepository;
  TransactionsPageCubit(this._dmtRepository) : super(TransactionsPageInitial());

}
