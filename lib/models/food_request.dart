import 'package:cloud_firestore/cloud_firestore.dart';

class FoodRequest {
  late String uid;
  late String name;
  late String email;
  late String foodCategory;
  late Timestamp dateAdded;

  FoodRequest({
    required this.uid,
    required this.name,
    required this.email,
    required this.foodCategory,
    required this.dateAdded,
  });

  static Map<String, dynamic> toMap(FoodRequest foodRequest) {
    var data = <String, dynamic>{};
    data['uid'] = foodRequest.uid;
    data['name'] = foodRequest.name;
    data['email'] = foodRequest.email;
    data['foodCategory'] = foodRequest.foodCategory;
    data['dateAdded'] = foodRequest.dateAdded;
    return data;
  }

  FoodRequest.fromMap(Map<String, dynamic> mapData) {
    uid = mapData['uid'];
    name = mapData['name'];
    email = mapData['email'];
    foodCategory = mapData['foodCategory'];
    dateAdded = mapData['dateAdded'];
  }
}
