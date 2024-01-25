import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_radius.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class ChatView extends StatefulWidget {
  String name, profileUrl, username;
  ChatView(
      {super.key,
      required this.name,
      required this.profileUrl,
      required this.username});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
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

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(

          padding: const ProjectPaddings.allMedium(),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
               color: sendByMe ? ProjectColors.receivedMessage: ProjectColors.sendMessage,
              borderRadius: BorderRadius.only(
                  topLeft: const ProjectRadius.customCircular(),
                  bottomRight: sendByMe
                      ? const Radius.circular(0)
                      : const ProjectRadius.customCircular(),
                  topRight: const ProjectRadius.customCircular(),
                  bottomLeft: sendByMe
                      ? const ProjectRadius.customCircular()
                      : const Radius.circular(0))),
          child: Text(
            message,
            style: const TextStyle(
                color: ProjectColors.black, fontSize: 15, fontWeight: FontWeight.w500),
          ),
        )),
      ],
    );
  }

  Widget chatMessage() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.only(bottom: 90, top: 130),
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTile(
                        ds["message"], myUserName == ds["sendBy"]);
                  })
              : const Center(child: CircularProgressIndicator());
        });
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

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProjectColors.chatBackground,
      body: Container(
        padding: const ProjectPaddings.onlyTop() * 6,
        child: Stack(
          children: [
            Container(
                margin: const ProjectPaddings.onlyTop() * 5,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.12,
                decoration: const BoxDecoration(
                    color: ProjectColors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: ProjectRadius.circularLarge(),
                        topRight: ProjectRadius.circularLarge(),)),
                child: chatMessage()),
            Padding(
              padding: const ProjectPaddings.onlyLeft(),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeView()));
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: ProjectColors.customWhite,
                    ),
                  ),
                  const SizedBox(
                    width: 90.0,
                  ),
                  Text(
                    widget.name,
                    style: const TextStyle(
                        color: ProjectColors.customWhite,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: ProjectElevations.normal.value,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const ProjectPaddings.allNormal(),
                  decoration: BoxDecoration(
                      color: ProjectColors.white,
                      borderRadius: ProjectBorders.circularSmall() * 3),
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Mesaj gönder...",
                        hintStyle: const TextStyle(color: Colors.black45),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              addMessage(true);
                            },
                            child: const Icon(Icons.send_rounded))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
