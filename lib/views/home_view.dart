import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_radius.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/services/shared_pref.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/login_view.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool search = false;

  String? myName, myProfilePic, myUserName, myEmail;
  Stream? chatRoomStream;

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

  @override
  void initState() {
    super.initState();
    onTheLoad();
  }

  //users connection for chat
  getChatRoomIdByUser(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  var queryResultSet = [];
  var tempSearchStore = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ProjectColors.primary,
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 50.0, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                search
                    ? Expanded(
                        child: TextField(
                            onChanged: (value) {
                              initiateSearch(value.toUpperCase());
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Kullanıcı ara..",
                                hintStyle: context
                                    .projectTheme()
                                    .labelLarge
                                    ?.copyWith(color: ProjectColors.black)),
                            style: context.projectTheme().labelLarge?.copyWith(
                                color: ProjectColors.black,
                                fontWeight: FontWeight.w500)),
                      )
                    : GestureDetector(
                        onTap: () {
                          DatabaseMethods().signOut();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()));
                        },
                        child: const Icon(
                          Icons.output_outlined,
                          size: 30,
                          color: ProjectColors.white,
                        ),
                      ),
                GestureDetector(
                  onTap: () {
                    search = true;
                    setState(() {});
                  },
                  child: Container(
                      padding: const ProjectPaddings.allSmall(),
                      decoration: BoxDecoration(
                          color: ProjectColors.customBrown,
                          borderRadius: ProjectBorders.circularSmall() * 2),
                      child: search
                          ? GestureDetector(
                              onTap: () {
                                search = false;
                                setState(() {});
                              },
                              child: const Icon(Icons.close,
                                  color: ProjectColors.iconPurple),
                            )
                          : const Icon(Icons.search,
                              color: ProjectColors.iconPurple)),
                )
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            width: MediaQuery.of(context).size.width,
            height: search
                ? MediaQuery.of(context).size.height / 1.20
                : MediaQuery.of(context).size.height / 1.15,
            decoration: const BoxDecoration(
                color: ProjectColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: ProjectRadius.circularNormal(),
                  topRight: ProjectRadius.circularNormal(),
                )),
            child: Column(children: [
              search
                  ? ListView(
                      padding: const ProjectPaddings.onlyLeftRight(),
                      primary: false,
                      shrinkWrap: true,
                      children: tempSearchStore.map((element) {
                        return buildResultCard(element);
                      }).toList())
                  : ChatRoomList()
            ]),
          ),
        ])));
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () async {
        search = false;
        // setState(() {});
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

class ChatRoomListTile extends StatefulWidget {
  final String lastMessage, chatRoomId, myUserName, time;
  const ChatRoomListTile(
      {super.key,
      required this.lastMessage,
      required this.chatRoomId,
      required this.myUserName,
      required this.time});

  @override
  State<ChatRoomListTile> createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = "", name = "", username = "", id = "";
  bool isMounted = false;

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll("_", "").replaceAll(widget.myUserName, "");
    QuerySnapshot querySnapshot =
        await DatabaseMethods().getUserInfo(username.toUpperCase());
    if (isMounted) {
      setState(() {
        name = "${querySnapshot.docs[0]["Name"]}";
        profilePicUrl = "${querySnapshot.docs[0]["Photo"]}";
        id = "${querySnapshot.docs[0]["id"]}";
      });
    }
  }

  @override
  void initState() {
    isMounted = true;
    getThisUserInfo();
    super.initState();
  }

  @override
  void dispose() {
    isMounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatView(
                    name: name,
                    profileUrl: profilePicUrl,
                    username: username)));
      },
      child: Container(
        margin: const ProjectPaddings.symmetricMedium(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profilePicUrl == ""
                ? const CircularProgressIndicator()
                : ClipRRect(
                    borderRadius: ProjectBorders.circularSmall() * 6,
                    child: Image.network(
                      profilePicUrl,
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    )),
            ConstantSizedBoxs.lowWidthSizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstantSizedBoxs.lowHeightSizedBox(),
                Text(
                  username,
                  style: context.projectTheme().titleMedium?.copyWith(
                        color: ProjectColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                Text(
                  widget.lastMessage,
                  style: context.projectTheme().titleMedium?.copyWith(
                        color: ProjectColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              widget.time,
              style: context.projectTheme().titleMedium?.copyWith(
                            color: ProjectColors.black,
                            fontWeight: FontWeight.w400,
                          ),
            ),
          ],
        ),
      ),
    );
  }
}
