import 'package:ltss/base/base.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'account_page_state.dart';

class AccountPageCubit extends BaseCubit<AccountPageState> {
  final SessionManager _sessionManager;

  AccountPageCubit(this._sessionManager) : super(AccountPageInitial());

  Future<void> loadUI() async {
    emit(LoadingUI());
    try{

      var userId = await _sessionManager.getUserId();
      var name = await _sessionManager.getFirstName();
      var roleId = await _sessionManager.getRoleId();
      var role = UserRole.getUserRoleName(roleId);
      var profileImage = await _sessionManager.getProfile();
      var mobileNumber = await _sessionManager.getMobileNumber();

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      emit(UILoaded(
          userId,name, mobileNumber, roleId, role ?? "", profileImage, "v$version"));
    }catch(e){
      emit(LoadUIFailed("Something went wrong!!!"));
    }
  }
}
