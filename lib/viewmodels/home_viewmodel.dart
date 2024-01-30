import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/home_view.dart';
import 'package:chat_app/widgets/home/chat_room_list_tile.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HomeViewModel extends State<HomeView> {
  bool search = false;

  String? myName, myProfilePic, myUserName, myEmail;
  Stream? chatRoomStream;

  var queryResultSet = [];
  var tempSearchStore = [];

  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  getSharedPref() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserPic();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  onTheLoad() async {
    await getSharedPref();
    chatRoomStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  //users connection for chat
  getChatRoomIdByUser(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });
    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Username'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  Widget ChatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print("Error in StreamBuilder: ${snapshot.error}");
          return const Center(
            child: Text(ProjectStrings.streamError),
          );
        }

        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return ChatRoomListTile(
                    chatRoomId: ds.id,
                    lastMessage: ds["lastMessage"],
                    myUserName: myUserName!,
                    time: ds["lastMessageSendTs"],
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  
  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () async {
        search = false;
      
        var chatRoomId = getChatRoomIdByUser(myUserName!, data["Username"]);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, data["Username"]],
        };
        await DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatView(
                    name: data["Name"],
                    profileUrl: data["Photo"],
                    username: data["Username"])));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Material(
          elevation: ProjectElevations.normal.value,
          borderRadius: ProjectBorders.circularSmall(),
          child: Container(
            padding: const ProjectPaddings.allMedium(),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: ProjectBorders.circularSmall()),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: ProjectBorders.circularSmall() * 6,
                    child: Image.network(
                      data["Photo"],
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    )),
                ConstantSizedBoxs.normalWidthSizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data["Name"],
                      style: context.projectTheme().titleMedium?.copyWith(
                            color: ProjectColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    ConstantSizedBoxs.lowHeightSizedBox(),
                    Text(
                      data["Username"],
                      style: context.projectTheme().titleMedium?.copyWith(
                            color: ProjectColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
