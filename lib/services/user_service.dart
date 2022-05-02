import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companionapp/models/user_model.dart';
import 'package:companionapp/res/collections.dart';

class UserService {
  static Future<void> saveUser(UserModel userModel) async {
    await Collections.usersCollection
        .doc(userModel.uid)
        .set(UserModel.toMap(userModel));
  }

  static Future<UserModel?> getUserDetails(String uid) async {
    DocumentSnapshot documentSnapshot =
        await Collections.usersCollection.doc(uid).get();
    if (documentSnapshot.exists) {
      UserModel userModel =
          UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return userModel;
    } else {
      return null;
    }
  }
}
