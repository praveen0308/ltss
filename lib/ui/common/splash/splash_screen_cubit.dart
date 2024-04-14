import 'dart:async';
import 'dart:io';
import 'package:ltss/base/base.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends BaseCubit<SplashScreenState> {
  final SessionManager _sessionManager;
  final AuthRepository _authRepository;
  SplashScreenCubit(this._sessionManager, this._authRepository) : super(SplashScreenInitial());

  void loadUserData() {
    emit(LoadingUserData());

    Timer(const Duration(seconds: 2), () async {
      var roleId = await _sessionManager.getRoleId();
      var isLoggedIn = await _sessionManager.isLoggedIn();
      var isConnected = await checkInternet();
      if(isConnected){
        var profileResponse = await _authRepository.getProfile();
        profileResponse.when(success: (user) {
          if(user.isActive==true){
            if(roleId !=0 && isLoggedIn){
              emit(DataLoaded(roleId));

            }else{
              emit(NotLoggedIn());
            }
          }else{
            emit(NotLoggedIn());
          }
        }, failure: (e) {
          emit(NotLoggedIn());

          logger.e("Exception: $e");
        });

      }


    });

  }

  Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}
