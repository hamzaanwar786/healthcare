import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore? firebaseFirestore;
  CollectionReference? collectionReference;

  initilize() {
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

  // Future<void> addApointment(
  //     String name, String location, String desciption) async {
  //   CollectionReference collectionReference =
  //       await firebaseFirestore!.collection('appointments');
  //   return collectionReference
  //       .add({"name": name, "email": location, "phone_no": desciption})
  //       .then((value) => print("User Added Successfully"))
  //       .catchError((onError) => print("failed to add user : $onError"));
  // }

  // Future<void> addApointment() {
  //   collectionReference = FirebaseFirestore.instance.collection('appointments');
  //   // Call the user's CollectionReference to add a new user
  //   return collectionReference!
  //       .add({
  //         'name': name, // John Doe
  //         'location': location, // Stokes and Sons
  //         'desciption': desciption // 42
  //       })
  //       .then((value) => print("User Added"))
  //       .catchError((error) => print("Failed to add user: $error"));
  // }
}
