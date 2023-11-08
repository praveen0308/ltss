import 'package:bloc/bloc.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/entity/wallet_entity.dart';
import 'package:ltss/repository/repository.dart';
import 'package:meta/meta.dart';

part 'wallet_screen_state.dart';

class WalletScreenCubit extends BaseCubit<WalletScreenState> {
  final WalletRepository _walletRepository;
  final DMTRepository _dmtRepository;
  WalletScreenCubit(this._walletRepository, this._dmtRepository) : super(WalletScreenInitial());


  Future<void> loadWalletBalance() async {
    emit(LoadingWalletStats());
    var result = await _walletRepository.getAllWallets();

    result.when(success: (result) {

      emit(ReceivedWalletStats(result));
    }, failure: (e) {
      emit(LoadWalletStatsFailed(e.message));
      logger.e("Exception: $e");
    });
  }
  Future<void> loadTransactions() async {
    emit(LoadingRecentTransactions());
    var result = await _dmtRepository.getTransactions();

    result.when(success: (result) {

      emit(ReceivedRecentTransactions(result));
    }, failure: (e) {
      emit(LoadRecentTransactionsFailed(e.message));
      logger.e("Exception: $e");
    });
  }

}
