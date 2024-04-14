import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/entity/wallet_entity.dart';
import 'package:ltss/models/api/entity/wallet_ledger_entity.dart';

part 'wallet_screen_state.dart';

class WalletScreenCubit extends BaseCubit<WalletScreenState> {
  final WalletRepository _walletRepository;
  final DMTRepository _dmtRepository;

  WalletScreenCubit(this._walletRepository, this._dmtRepository)
      : super(WalletScreenInitial());

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

  Future<void> loadWalletLedger(int skip, int limit) async {
    emit(LoadingRecentTransactions());
    var result = await _walletRepository.getWalletLedger(skip, limit);

    result.when(success: (result) {
      emit(ReceivedRecentTransactions(
          result.items.orEmpty(), result.totalCount ?? 0, result.skip ?? 0));
    }, failure: (e) {
      emit(LoadRecentTransactionsFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
