import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await _firestore
        .collection(ProjectStrings.usersCollection)
        .doc(id)
        .set(userInfoMap);
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return await _firestore
        .collection(ProjectStrings.usersCollection)
        .where("E-mail", isEqualTo: email)
        .get();
  }

  Future<QuerySnapshot> search(String username) async {
    return await _firestore
        .collection(ProjectStrings.usersCollection)
        .where("SearchKey", isEqualTo: username.substring(0, 1).toUpperCase())
        .get();
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  createChatRoom(
      String chatRoomId, Map<String, dynamic> chatRoomInfoMap) async {
    final snapshot = await _firestore
        .collection(ProjectStrings.chatRoomsCollection)
        .doc(chatRoomId)
        .get();
    if (snapshot.exists) {
      return true;
    } else {
      return _firestore
          .collection(ProjectStrings.chatRoomsCollection)
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future addMessage(String chatRoomId, String messageId,
      Map<String, dynamic> messageInfoMap) {
    return _firestore
        .collection(ProjectStrings.chatRoomsCollection)
        .doc(chatRoomId)
        .collection(ProjectStrings.chatsCollection)
        .doc(messageId)
        .set(messageInfoMap);
  }

  updateLastMessageSend(
      String chatRoomId, Map<String, dynamic> lastMessageInfoMap) {
    return _firestore
        .collection(ProjectStrings.chatRoomsCollection)
        .doc(chatRoomId)
        .update(lastMessageInfoMap);
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return _firestore
        .collection(ProjectStrings.chatRoomsCollection)
        .doc(chatRoomId)
        .collection(ProjectStrings.chatsCollection)
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await _firestore
        .collection(ProjectStrings.usersCollection)
        .where("Username", isEqualTo: username)
        .get();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String? myUserName = await SharedPreferenceHelper().getUserName();
    return _firestore
        .collection(ProjectStrings.chatRoomsCollection)
        .orderBy("time", descending: true)
        .where("users", arrayContains: myUserName!)
        .snapshots();
  }
}
