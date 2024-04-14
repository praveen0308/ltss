import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base_cubit.dart';
import 'package:ltss/models/api/entity/bank_entity.dart';
import 'package:ltss/models/api/entity/bank_vendor.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:ltss/models/api/entity/dmt_transaction.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/ui/admin/banks/add_bank/add_bank_cubit.dart';
import 'package:ltss/ui/admin/banks/add_bank/add_bank_screen.dart';
import 'package:ltss/ui/admin/manage_dmt/add_dmt_vendor/add_dmt_vendor.dart';
import 'package:ltss/ui/admin/manage_dmt/add_dmt_vendor/add_dmt_vendor_cubit.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_charge/manage_charge.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_charge/manage_charge_cubit.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_commission/manage_commission.dart';
import 'package:ltss/ui/admin/manage_dmt/manage_commission/manage_commission_cubit.dart';
import 'package:ltss/ui/admin/manage_dmt/transactions/edit_transaction/edit_transaction_screen.dart';
import 'package:ltss/ui/admin/services/pages/charges/add_charge/add_charge.dart';
import 'package:ltss/ui/admin/services/pages/commission/add_commission/add_commission_cubit.dart';
import 'package:ltss/ui/admin/services/pages/service/add/add_service.dart';
import 'package:ltss/ui/admin/services/pages/service/add/add_service_cubit.dart';
import 'package:ltss/ui/common/add_user/add_user.dart';
import 'package:ltss/ui/common/add_user/add_user_cubit.dart';
import 'package:ltss/ui/common/transaction_action/transaction_action.dart';
import 'package:ltss/ui/common/transaction_detail/transaction_detail.dart';
import 'package:ltss/ui/common/user_detail/user_detail_cubit.dart';
import 'package:ltss/ui/common/user_detail/user_detail_screen.dart';

import '../../services/pages/charges/add_charge/add_charge_cubit.dart';
import '../../services/pages/commission/add_commission/add_commission.dart';

part 'dashboard_screen_event.dart';

part 'dashboard_screen_state.dart';

class DashboardScreenBloc extends Bloc<DashboardScreenEvent, DashboardScreenState> {

  final SessionManager _sessionManager;

  DashboardScreenBloc(this._sessionManager) : super(const DashboardScreenState()) {
    on<DashboardScreenEvent>((event, emit) async {
      if (event is LogOut) {
        await _sessionManager.clearData();
        emit(LogOutSuccessfully());
      }
      if (event is ToggleAddServicePage) {
        emit(DashboardScreenState(
            view: BlocProvider(
          create: (context) => AddServiceCubit(
              RepositoryProvider.of<ServiceRepository>(context)),
          child: AddServicePage(
            service: event.data,
          ),
        )));
      }
      if (event is ToggleAddCommissionPage) {
        emit(DashboardScreenState(
            view: BlocProvider(
          create: (context) => AddCommissionCubit(
              RepositoryProvider.of<CommissionRepository>(context),
              RepositoryProvider.of<ServiceRepository>(context)),
          child: AddCommissionPage(
            commissionEntity: event.commission,
          ),
        )));
      }
      if (event is ToggleAddChargePage) {
        emit(DashboardScreenState(
            view: BlocProvider(
                create: (context) => AddChargeCubit(
                    RepositoryProvider.of<ChargeRepository>(context),
                    RepositoryProvider.of<ServiceRepository>(context)),
                child: AddChargePage(
                  chargeEntity: event.data,
                ))));
      }
      if (event is ToggleAddBankPage) {
        emit(DashboardScreenState(
            view: BlocProvider(
                create: (context) => AddBankCubit(
                    RepositoryProvider.of<BankRepository>(context),
                    RepositoryProvider.of<UserRepository>(context)),
                child: AddBankPage(
                  bankEntity: event.data,
                ))));
      }
      if (event is ToggleUserDetailPage) {
        emit(DashboardScreenState(
            view: BlocProvider(
                create: (context) => UserDetailCubit(
                      RepositoryProvider.of<UserRepository>(context),
                      RepositoryProvider.of<SessionManager>(context),
                    ),
                child: UserDetailScreen(
                  userId: event.userId,
                ))));
      }
      if (event is ToggleAddDmtVendorPage) {
        emit(DashboardScreenState(
            view: BlocProvider(
                create: (context) => AddDmtVendorCubit(
                    RepositoryProvider.of<UserRepository>(context),
                    RepositoryProvider.of<BankRepository>(context)),
                child: AddDMTVendor(
                  bankVendor: event.bankVendor,
                ))));
      }
      if (event is ToggleAddUserPage) {
        emit(DashboardScreenState(
            view: BlocProvider(
          create: (context) => AddUserCubit(
              RepositoryProvider.of<UserRepository>(context),
              RepositoryProvider.of<KYCRepository>(context)),
          child: AddUserScreen(
            userTypeAdding: event.role,
            userEntity: event.user,
          ),
        )));
      }
      if (event is ToggleManageCommission) {
        emit(DashboardScreenState(
            view: BlocProvider(
          create: (context) => ManageCommissionCubit(
              RepositoryProvider.of<CommissionRepository>(context)),
          child: ManageCommissionScreen(serviceId: event.serviceId),
        )));
      }
      if (event is ToggleManageCharges) {
        emit(DashboardScreenState(
            view: BlocProvider(
          create: (context) => ManageChargeCubit(
              RepositoryProvider.of<ChargeRepository>(context)),
          child: ManageChargeScreen(serviceId: event.serviceId),
        )));
      }
      if (event is ToggleTransactionDetails) {
        emit(DashboardScreenState(
            view: TransactionDetailScreen.create(event.dmtTransaction)));
      }
      if (event is ToggleTransactionAction) {
        emit(DashboardScreenState(
            view: TransactionActionScreen.create(
                event.dmtTransaction, event.action)));
      }
      if (event is ToggleEditTransaction) {
        emit(DashboardScreenState(
            view: EditTransactionScreen.create(event.dmtTransaction)));
      }
      if (event is Empty) {
        emit(const DashboardScreenState(view: null));
      }
    });
  }
}
