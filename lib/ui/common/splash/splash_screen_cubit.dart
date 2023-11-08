import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ltss/local/session_manager.dart';
import 'package:ltss/ui/common/auth/enter_mobile_number/enter_mobile_number_cubit.dart';
import 'package:meta/meta.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  final SessionManager _sessionManager;
  SplashScreenCubit(this._sessionManager) : super(SplashScreenInitial());

  void loadUserData() {
    emit(LoadingUserData());

    Timer(const Duration(seconds: 3), () async {
      var roleId = await _sessionManager.getRoleId();
      var isLoggedIn = await _sessionManager.isLoggedIn();

      if(roleId !=0 && isLoggedIn){
        emit(DataLoaded(roleId));

      }else{
        emit(NotLoggedIn());
      }
    });

  }
}
