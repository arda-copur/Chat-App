import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';


abstract class ChatViewModel extends State<ChatView> {
  final TextEditingController messageController = TextEditingController();

  String? myUserName, myProfilePic, myName, myEmail, messageId, chatRoomId;
  Stream? messageStream;

  
  getSharedPref() async {
    myUserName = await SharedPreferenceHelper().getUserName();
    myProfilePic = await SharedPreferenceHelper().getUserPic();
    myName = await SharedPreferenceHelper().getDisplayName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdByUser(widget.username, myUserName!);
    setState(() {});
  }

  onTheLoad() async {
    await getSharedPref();
    await getAndSetMessages();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  getChatRoomIdByUser(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  
  
  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

   addMessage(bool sendClicked) {
    if (messageController.text != "") {
      String message = messageController.text;
      messageController.text = "";
      DateTime now = DateTime.now();
      String formattedDate = DateFormat("h:mma").format(now);
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "ts": formattedDate,
        "time": FieldValue.serverTimestamp(),
        "imgUrl": myProfilePic,
      };

      messageId ??= randomAlphaNumeric(10);

      DatabaseMethods()
          .addMessage(chatRoomId!, messageId!, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": formattedDate,
          "time": FieldValue.serverTimestamp(),
          "lastMessageSendBy": myUserName,
        };
        DatabaseMethods()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          messageId = null;
        }
      });
    }
  }


}