import 'dart:io';

import 'package:ltss/base/base.dart';
import 'package:ltss/models/api/entity/user_entity.dart';
import 'package:ltss/repository/repository.dart';
import 'package:ltss/utils/user_type.dart';
import 'package:meta/meta.dart';

part 'add_user_state.dart';

class AddUserCubit extends BaseCubit<AddUserState> {
  final UserRepository _userRepository;
  final KYCRepository _kycRepository;

  AddUserCubit(this._userRepository, this._kycRepository)
      : super(AddUserInitial());

  int activeStep = 0;
  int? userId;
  UserRole? userType;

  String? firstName;
  String? lastName;
  String? email;
  String? mobileNo;
  String? address;
  String? pincode;
  String? pan;
  String? aadhaar;
  File? shopImage;
  File? profileImage;

  void saveUserData(UserRole userType, String firstName, String lastName,
      String mobileNo, String email, String address, String pincode) {
    this.userType = userType;
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    this.mobileNo = mobileNo;
    this.address = address;
    this.pincode = pincode;
    updateActiveStep(1);
  }

  void saveKYCDetails(
      String pan, String aadhaar, File shopImage, File profileImage) {
    this.pan = pan;
    this.aadhaar = aadhaar;
    this.shopImage = shopImage;
    this.profileImage = profileImage;

    addUser(UserEntity(
        firstName: firstName,
        lastName: lastName,
        mobileNo: mobileNo,
        email: email,
        roleId: userType?.roleId ?? 0,
        isActive: true,
        restrictions: ""));
  }

  void updateActiveStep(int step) {
    activeStep = step;
    emit(StepUpdated(activeStep));
  }

  Future<void> addUser(UserEntity userEntity) async {
    emit(AddingUserData());
    var result = await _userRepository.addNewUser(userEntity);
    result.when(success: (user) {
      userId = user.id;
      emit(AddUserSuccessful());
    }, failure: (e) {
      emit(AddUserFailed(e.message));
      logger.e("Exception: $e");
    });
  }

  Future<void> addKYCDetail() async {
    emit(AddingUserKYC());
    var result = await _kycRepository.postKYC(
        userId: userId!, pan!, aadhaar!, shopImage!, profileImage!);
    result.when(success: (user) {
      emit(AddKYCSuccessful());
    }, failure: (e) {
      emit(AddKYCFailed(e.message));
      logger.e("Exception: $e");
    });
  }
}
