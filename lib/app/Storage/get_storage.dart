import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static const String _tokenKey = 'token';
  static const String _userId = 'user_id';
  static const String _name = 'name';
  static const String _userunicid = 'uniqid';
  static const String _hostelname = 'hostelname';
  static const String _loginid = 'loginid';
  static const String _Password = 'password';
  static const String _userimage = 'image';
  static const String _userLogedonce = 'userlogonce';

  static const String _mobile = 'mobile';

  static Future<void> saveToken(String token) async {
    await GetStorage().write(_tokenKey, token);
  }

  static Future<void> removeToken() async {
    await GetStorage().remove(_tokenKey);
  }

  static String? getToken() {
    return GetStorage().read<String>(_tokenKey);
  }

  // user id\
  static Future<void> removeuserid() async {
    await GetStorage().remove(_userId);
  }

  static Future<void> saveUserId(String id) async {
    await GetStorage().write(_userId, id);
  }

  static String? getUserId() {
    return GetStorage().read<String>(_userId);
  }

  // user image
  static Future<void> removeuserimage() async {
    await GetStorage().remove(_userimage);
  }

  static Future<void> saveUserimage(String id) async {
    await GetStorage().write(_userimage, id);
  }

  static String? getUserimage() {
    return GetStorage().read<String>(_userimage);
  }

  // Hostel name
  static Future<void> removeHostelname() async {
    await GetStorage().remove(_hostelname);
  }

  static Future<void> saveHostelname(String id) async {
    await GetStorage().write(_hostelname, id);
  }

  static String? getHostelname() {
    return GetStorage().read<String>(_hostelname);
  }

  // user uniqe id
  static Future<void> removeuseruniqueId() async {
    await GetStorage().remove(_userunicid);
  }

  static Future<void> saveUseruniqueId(String id) async {
    await GetStorage().write(_userunicid, id);
  }

  static String? getUseruniqueId() {
    return GetStorage().read<String>(_userunicid);
  }

  // user name
  static Future<void> removeusername() async {
    await GetStorage().remove(_name);
  }

  static Future<void> saveUsername(String name) async {
    await GetStorage().write(_name, name);
  }

  static String? getUsername() {
    return GetStorage().read<String>(_name);
  }

  // save mobile number

  static Future<void> removesaveMobile() async {
    await GetStorage().remove(_mobile);
  }

  static Future<void> saveMobile(String mobile) async {
    await GetStorage().write(_mobile, mobile);
  }

  static String? getMobilee() {
    return GetStorage().read<String>(_mobile);
  }

  // Login id

  static Future<void> removeLoginid() async {
    await GetStorage().remove(_loginid);
  }

  static Future<void> saveLoginid(String Loginid) async {
    await GetStorage().write(_loginid, Loginid);
  }

  static String? getLoginid() {
    return GetStorage().read<String>(_loginid);
  }

  // Password

  static Future<void> removePassword() async {
    await GetStorage().remove(_Password);
  }

  static Future<void> savePassword(String Password) async {
    await GetStorage().write(_Password, Password);
  }

  static String? getPassword() {
    return GetStorage().read<String>(_Password);
  }

  // user loged once

  static Future<void> Userloged() async {
    await GetStorage().remove(_userLogedonce);
  }

  static Future<void> saveloged(String saveloged) async {
    await GetStorage().write(_userLogedonce, saveloged);
  }

  static String? getLoged() {
    return GetStorage().read<String>(_userLogedonce);
  }
}
