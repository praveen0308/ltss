import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';

part 'manage_banks_state.dart';

class ManageBanksCubit extends BaseCubit<ManageBanksState> {
  final BankRepository _bankRepository;

  ManageBanksCubit(this._bankRepository) : super(ManageBanksInitial());
  List<BankEntity> banks = List.empty(growable: true);
  Future<void> loadBanks() async {
    emit(LoadingData());
    var result = await _bankRepository.getAllBanks();

    result.when(success: (s) {
      banks.clear();
      banks.addAll(s);
      emit(ReceivedData(banks));
    }, failure: (e) {
      emit(LoadDataFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> deleteBank(int bankId) async {
    emit(Deleting());
    var result = await _bankRepository.deleteBank(bankId);

    result.when(success: (result) {
      emit(DeletionSuccessful());
    }, failure: (e) {
      emit(DeletionFailed(e.message));
      logger.e("Exception: $e");
    });
  }


  void searchBank(String query){
    List<BankEntity> filteredItems = List.empty(growable: true);

    for (var element in banks) {
      if(element.name?.contains(query) == true){
        filteredItems.add(element);
      }
    }

    emit(ReceivedData(filteredItems));
  }

}
