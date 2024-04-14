
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/sampurna/sampurna.dart';
import 'package:ltss/models/enums.dart';
import 'package:ltss/ui/users/dmt2/pages/dmt_checkout/range_val_entity.dart';

part 'dmt_checkout_state.dart';

class DmtCheckoutCubit extends BaseCubit<DmtCheckoutState> {
  final ChargeRepository _chargeRepository;
  final DMTRepository _dmtRepository;
  final BankRepository _bankRepository;

  DmtCheckoutCubit(
      this._chargeRepository, this._dmtRepository, this._bankRepository)
      : super(const DmtCheckoutState());

  final List<ChargeEntity> charges = List.empty(growable: true);
  final List<BankEntity> banks = List.empty(growable: true);
  double applicableCharges = 0;
  double amount = 0;
  double total = 0;
  double minAmount = 0;
  double maxAmount = 0;
  int bankId= 0;
  late Sender sender;
  late Beneficiary beneficiary;

  void init(Sender sender, Beneficiary beneficiary) {
    this.sender = sender;
    this.beneficiary = beneficiary;
    fetchServiceChargesNBanks();
  }

  Future<void> fetchServiceChargesNBanks() async {
    emit(state.copyWith(status: DmtCheckoutStatus.loading));
    var result =
        await _chargeRepository.getAllCharges(serviceId: AppService.dmt.id);
    var bankList = await _bankRepository.getAllBanks();

    result.when(success: (s) {
      charges.clear();
      charges.addAll(s);
      bankList.when(success: (list) {
        banks.clear();
        banks.addAll(list);
        calculateMinMaxAmount();
        emit(state.copyWith(status: DmtCheckoutStatus.initializationSuccess));
      }, failure: (e) {
        emit(state.copyWith(
            status: DmtCheckoutStatus.initializationFailed, msg: e.message));
        logger.e("Exception: $e");
      });
    }, failure: (e) {
      emit(state.copyWith(
          status: DmtCheckoutStatus.initializationFailed, msg: e.message));
      logger.e("Exception: $e");
    });
  }

  void calculateMinMaxAmount() {
    var bank = banks
        .where(
            (element) => element.name?.toUpperCase().contains(beneficiary.bankName!) == true)
        .first;
    bankId = bank.bankId ?? 0;
    minAmount = bank.min!;
    maxAmount = bank.max!;
  }

  void updateAmount(double amount) {
    this.amount = amount;

    applicableCharges = 0;
    total = 0;
    if (amount < minAmount || amount > maxAmount) {
      emit(state.copyWith(
          amountValidationError: "Min. ₹$minAmount and Max. ₹$maxAmount!!",
          amount: amount,
          applicableCharges: applicableCharges,
          total: total,
          canProceed: false));
      return;
    }
    for (var c in charges) {
      var ranges = c.getValues().map((element) {
        return RangeValEntity.fromPair(element);
      }).toList();
      for (var r in ranges) {
        if (amount == r.start ||
            (amount > r.start && amount < r.end) ||
            amount == r.end) {
          if (r.inPercent) {
            var n = amount * r.value;
            applicableCharges += n;
          } else {
            var n = r.value;
            applicableCharges += n;
          }
        }
      }
    }

    total = amount + applicableCharges;
    emit(state.copyWith(
        amount: amount,
        applicableCharges: applicableCharges,
        total: total,
        canProceed: amount > 0,
        amountValidationError: null));
  }

  Future<void> addDmtTransaction() async {
    var result = await _dmtRepository.addNewTransaction(DmtTransaction(
      serviceId: 1,
      senderName: sender.senderName,
      senderMobileNo: sender.senderMobile,
      beneficiaryId:beneficiary.beneID ?? "0",
      beneficiaryName: beneficiary.beneName,
      accountNumber: beneficiary.accountNo,
      ifsc: beneficiary.ifsc,
      bankId: bankId,
      bankName: beneficiary.bankName,
      transMode: beneficiary.transMode,
      amount: amount,
    ));

    result.when(success: (s) {
      emit(state.copyWith(status: DmtCheckoutStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: DmtCheckoutStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
