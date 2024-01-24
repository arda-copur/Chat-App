import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_radius.dart';
import 'package:chat_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class ChatView extends StatefulWidget {
  String name, profileUrl, userName;
  ChatView({super.key, required this.name, required this.profileUrl, required this.userName});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController messageController = TextEditingController();
  String? myUserName, myProfilePic, myName, myEmail, messageId, chatRoomId;

  getSharedPref() async{
   
   myUserName = await SharedPreferenceHelper().getUserName();
   myProfilePic = await SharedPreferenceHelper().getUserPic();
   myName = await SharedPreferenceHelper().getDisplayName();
   myEmail = await SharedPreferenceHelper().getUserEmail();

   chatRoomId = getChatRoomIdByUser(widget.userName, myUserName!);
   setState(() {
     
   });
  }

  onTheLoad() async{
     await getSharedPref();
     setState(() {
       
     });
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
   
  addMessage(bool sendClicked) {
    if(messageController.text != "") {
      String message = messageController.text;
      messageController.text = "";
      DateTime now = DateTime.now();
      String formattedDate = DateFormat("h:mma").format(now);
      Map<String,dynamic> messageInfoMap = {
        "message":message,
        "sendBy": myUserName,
        "ts": formattedDate,
        "time":FieldValue.serverTimestamp(),
        "imgUrl": myProfilePic,
      };
      
      messageId ??= randomAlphaNumeric(10);

      DatabaseMethods().addMessage(chatRoomId!, messageId!, messageInfoMap).then((value) {
        Map<String,dynamic> lastMessageInfoMap = {
           "lastMessage": message,
           "lastMessageSendTs": formattedDate,
           "time": FieldValue.serverTimestamp(),
           "lastMessageSendBy": myUserName,
        };
        DatabaseMethods().updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          messageId = "";
        }
      });
      
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF553370),
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            const Padding(
              padding: ProjectPaddings.onlyLeft(),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Color(0Xffc199cd),
                  ),
                  SizedBox(
                    width: 90.0,
                  ),
                  Text(
                    "Arda Çopur",
                    style: TextStyle(
                        color: Color(0Xffc199cd),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50.0, bottom: 40.0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.15,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: ProjectRadius.circularLarge(),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    padding: const ProjectPaddings.allNormal(),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2),
                    alignment: Alignment.bottomRight,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 236, 240),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: const Text(
                      "Nasılsın?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Container(
                    padding: const ProjectPaddings.allNormal(),
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 3),
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 211, 228, 243),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: const Text(
                      "İyi sen",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                   Container(
                    padding: const ProjectPaddings.allNormal(),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 4),
                    alignment: Alignment.bottomRight,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 236, 240),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: const Text(
                      "Akşam dışarı çıkar mıyız?",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                   const SizedBox(height: 20.0,),
                  Container(
                    padding: const ProjectPaddings.allNormal(),
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 1.7),
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 211, 228, 243),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: const Text(
                      "Olabilir",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                   const SizedBox(height: 20.0,),
                   Container(
                    padding: const ProjectPaddings.allNormal(),
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 4),
                    alignment: Alignment.bottomRight,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 234, 236, 240),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: const Text(
                      "Saat kaçta çıkalım",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                    const SizedBox(height: 20.0,),
                  Container(
                    padding: const ProjectPaddings.allNormal(),
                    margin: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 3),
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 211, 228, 243),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    child: const Text(
                      "Haber vericem",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(),
                  Material(
                    elevation: ProjectElevations.normal.value,
                     borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const ProjectPaddings.allNormal(),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Row(children: [
                       Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: const InputDecoration(border: InputBorder.none, hintText: "Mesaj gönder...", hintStyle: TextStyle(color: Colors.black45)),
                        ),
                      ),
                  GestureDetector(
                    onTap: () {
                      addMessage(true);
                    },
                    child: Container(
                      padding: const ProjectPaddings.allNormal(),
                      decoration: BoxDecoration(color: const Color(0xFFf3f3f3), borderRadius: BorderRadius.circular(60)),
                      child: const Center(child: Icon(Icons.send, color: Color(0xFF553370),))),
                  )
                    ],),),
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}