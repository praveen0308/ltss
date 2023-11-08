import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SessionManager {
  final _storage = const FlutterSecureStorage();

  final _userId = "userId";
  final _roleId = "roleId";
  final _name = "name";
  final _email = "email";
  final _mobileNo = "mobileNo";
  final _profileImage = "profileImage";
  final _address = "address";
  final _token = "xToken";

  Future updateUserId(int userId) async {
    var writeData =
        await _storage.write(key: _userId, value: userId.toString());
    return writeData;
  }

  Future<int> getUserId() async {
    var readData = await _storage.read(key: _userId);

    return int.parse(readData ?? "0");
  }

  Future updateRoleId(int roleId) async {
    var writeData =
        await _storage.write(key: _roleId, value: roleId.toString());
    return writeData;
  }

  Future<int> getRoleId() async {
    var readData = await _storage.read(key: _roleId);

    return int.parse(readData ?? "0");
  }

  Future updateName(String name) async {
    var writeData = await _storage.write(key: _name, value: name.toString());
    return writeData;
  }

  Future<String> getName() async {
    var readData = await _storage.read(key: _name);

    return readData ?? "";
  }

  Future updateEmail(String email) async {
    var writeData = await _storage.write(key: _email, value: email.toString());
    return writeData;
  }

  Future<String> getEmail() async {
    var readData = await _storage.read(key: _email);
    return readData ?? "";
  }

  Future updateMobileNumber(String number) async {
    var writeData =
        await _storage.write(key: _mobileNo, value: number.toString());
    return writeData;
  }

  Future<String> getMobileNumber() async {
    var readData = await _storage.read(key: _mobileNo);

    return readData ?? "";
  }

  Future updateToken(String token) async {
    var writeData = await _storage.write(key: _token, value: token.toString());
    return writeData;
  }

  Future<String> getToken() async {
    var readData = await _storage.read(key: _token);
    return readData ?? "";
  }

  Future updateProfile(String url) async {
    var writeData =
        await _storage.write(key: _profileImage, value: url.toString());
    return writeData;
  }

  Future<String> getProfile() async {
    var readData = await _storage.read(key: _profileImage);
    return readData ?? "";
  }

  Future updateAddress(String address) async {
    var writeData =
        await _storage.write(key: _address, value: address.toString());
    return writeData;
  }

  Future<String> getAddress() async {
    var readData = await _storage.read(key: _address);
    return readData ?? "";
  }

  Future<bool> isLoggedIn() async {
    var token = await getToken();
    return token.isNotEmpty && !JwtDecoder.isExpired(token);
  }
}
