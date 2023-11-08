part of 'wallet_screen_cubit.dart';

@immutable
abstract class WalletScreenState {}

class WalletScreenInitial extends WalletScreenState {}
class LoadingWalletStats extends WalletScreenState {}
class ReceivedWalletStats extends WalletScreenState {
  final List<WalletEntity> wallets;

  ReceivedWalletStats(this.wallets);

  WalletEntity? companyWallet() => wallets.where((element) => element.id=="cw").firstOrNull;
  WalletEntity? userWallet() => wallets.where((element) => element.id=="uw").firstOrNull;
  WalletEntity? serviceWallet() => wallets.where((element) => element.id=="sw").firstOrNull;
  WalletEntity? vendorWallet() => wallets.where((element) => element.id=="vw").firstOrNull;
}
class LoadWalletStatsFailed extends WalletScreenState {
  final String msg;

  LoadWalletStatsFailed(this.msg);
}
class LoadingRecentTransactions extends WalletScreenState {}
class ReceivedRecentTransactions extends WalletScreenState {
  final List<DmtTransaction> transactions;

  ReceivedRecentTransactions(this.transactions);

}
class LoadRecentTransactionsFailed extends WalletScreenState {
  final String msg;

  LoadRecentTransactionsFailed(this.msg);
}
