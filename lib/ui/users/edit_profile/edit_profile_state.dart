part of 'edit_profile_cubit.dart';

enum EditProfileStatus {
  initial,
  loading,
  success,
  error,
  initializing,
  initializationSuccess,
  initializationFailed;
}

extension EditProfileStatusX on EditProfileStatus {
  bool get isInitial => this == EditProfileStatus.initial;

  bool get isSuccess => this == EditProfileStatus.success;

  bool get isError => this == EditProfileStatus.error;

  bool get isLoading => this == EditProfileStatus.loading;

  bool get isInitializing => this == EditProfileStatus.initializing;

  bool get isInitializationSuccessful =>
      this == EditProfileStatus.initializationSuccess;

  bool get isInitializationFailed =>
      this == EditProfileStatus.initializationFailed;
}

class EditProfileState {
  final EditProfileStatus status;
  final String? msg;
  final String? name;
  final String? email;
  final String? mobileNumber;
  final String? address;

  EditProfileState({this.status = EditProfileStatus
      .initial, this.msg, this.name, this.email, this.mobileNumber, this.address,});

  EditProfileState copyWith({
    EditProfileStatus? status,
    String? msg,
    String? name,
    String? email,
    String? mobileNumber,
    String? address,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      address: address ?? this.address,
    );
  }

}
