import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'transactions_page_state.dart';

class TransactionsPageCubit extends Cubit<TransactionsPageState> {
  TransactionsPageCubit() : super(TransactionsPageInitial());
}
