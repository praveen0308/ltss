import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ltss/base/base_cubit.dart';
import 'package:ltss/models/api/entity/charge_entity.dart';
import 'package:ltss/models/api/entity/commission_entity.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:ltss/ui/admin/services/pages/charges/add_charge/add_charge.dart';
import 'package:ltss/ui/admin/services/pages/commission/add_commission/add_commission_cubit.dart';
import 'package:ltss/ui/admin/services/pages/service/add/add_service.dart';
import 'package:ltss/ui/admin/services/pages/service/add/add_service_cubit.dart';

import '../../services/pages/charges/add_charge/add_charge_cubit.dart';
import '../../services/pages/commission/add_commission/add_commission.dart';

part 'dashboard_screen_event.dart';

part 'dashboard_screen_state.dart';

class DashboardScreenBloc
    extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  DashboardScreenBloc() : super(const DashboardScreenState()) {
    on<DashboardScreenEvent>((event, emit) {
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
      if (event is Empty) {
        emit(const DashboardScreenState(view: null));
      }
    });
  }
}
