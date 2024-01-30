
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/widgets/sizedboxs/constant_sized_boxs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/project_borders.dart';

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

