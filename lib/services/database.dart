import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {

  Future addUserDetails(Map<String,dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).set(userInfoMap);
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    //Firestore'daki E-mail verisi giriş yapan email'e eşitse diyoruz çünkü user'a göre işlem yapıcaz
    return await FirebaseFirestore.instance.collection("users").where("E-mail", isEqualTo: email).get();
  }

   signOut() async{
     return await FirebaseAuth.instance.signOut();
  }
}