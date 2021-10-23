import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database {
  FirebaseAuth? firebaseUser;
  FirebaseFirestore? firebaseFirestore;

  initilize() {
    firebaseUser = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;
  }

  Future<List?> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firebaseFirestore!.collection("profile").get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "name": doc["name"],
            "phone_no": doc["phone_no"],
            "email": doc["email"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> addUser(String name, String email, String phone_no) async {
    CollectionReference collectionReference =
        await firebaseFirestore!.collection('users');
    return collectionReference
        .add({"name": name, "email": email, "phone_no": phone_no})
        .then((value) => print("User Added Successfully"))
        .catchError((onError) => print("failed to add user : $onError"));
  }
}
