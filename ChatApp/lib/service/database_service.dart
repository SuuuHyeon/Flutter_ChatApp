import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({this.uid});

  //reference for our collections
  final CollectionReference userCollections =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference groupCollections =
      FirebaseFirestore.instance.collection('groups');

  // saving the userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollections.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'groups': [],
      'profilePic': "",
      'uid': uid,
    });
  }

  // getting the user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollections.where('email', isEqualTo: email).get();
    return snapshot;
  }
}
