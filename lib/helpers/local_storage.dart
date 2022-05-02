import 'dart:convert';
import 'package:companionapp/models/user_model.dart';
import 'package:companionapp/res/keys.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  static final GetStorage getStorage = GetStorage();

  static Future<void> saveUser(UserModel userModel) async {
    await getStorage.write(
      Keys.currentUserKey,
      json.encode(UserModel.toMap(userModel)),
    );
  }

  static UserModel readUser() {
    return UserModel.fromMap(json.decode(getStorage.read(Keys.currentUserKey)));
  }

  static bool hasCurrentUser() {
    return getStorage.hasData(Keys.currentUserKey);
  }

  static Future<void> removeCurrentUser() async {
    await getStorage.remove(Keys.currentUserKey);
  }
}
