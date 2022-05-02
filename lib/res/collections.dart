import 'package:cloud_firestore/cloud_firestore.dart';

class Collections {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static final CollectionReference usersCollection =
      firestore.collection('companionUsers');
  static final CollectionReference requestsCollection =
      firestore.collection('requests');
}
