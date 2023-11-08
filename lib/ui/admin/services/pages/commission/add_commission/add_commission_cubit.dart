import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/service_entity.dart';
import 'package:meta/meta.dart';

part 'add_commission_state.dart';

class AddCommissionCubit extends BaseCubit<AddCommissionState> {
  final ServiceRepository _serviceRepository;
  final CommissionRepository _commissionRepository;

  AddCommissionCubit(this._commissionRepository, this._serviceRepository)
      : super(const AddCommissionState());

  Future<void> loadServices() async {
    emit(state.copyWith(status: AddCommissionStatus.initializing));
    var result = await _serviceRepository.getAllServices();

    result.when(success: (result) {
      emit(state.copyWith(
          status: AddCommissionStatus.initializationSuccess, services: result));
    }, failure: (e) {
      emit(state.copyWith(status: AddCommissionStatus.initializationFailed));
      logger.e("Exception: $e");
    });
  }

  Future<void> addNewCommission(
      int serviceId, String name, String value, bool isActive) async {
    emit(state.copyWith(status: AddCommissionStatus.loading));
    var result = await _commissionRepository.addNewCommission(
        serviceId, name, value, isActive);

    result.when(success: (result) {
      emit(state.copyWith(status: AddCommissionStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddCommissionStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> updateCommission(
      int commissionId, int serviceId, String name, String value,bool isActive) async {
    emit(state.copyWith(status: AddCommissionStatus.loading));
    var result = await _commissionRepository.updateCommission(
        commissionId, serviceId, name, value,isActive);

    result.when(success: (result) {
      emit(state.copyWith(status: AddCommissionStatus.success));
    }, failure: (e) {
      emit(state.copyWith(status: AddCommissionStatus.error, msg: e.message));
      logger.e("Exception: $e");
    });
  }
}
