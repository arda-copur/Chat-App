import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_colors.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/constants/project_radius.dart';
import 'package:chat_app/constants/project_strings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/utils/text_theme_extension.dart';
import 'package:chat_app/viewmodels/home_viewmodel.dart';
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

class _HomeViewState extends HomeViewModel {
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

}
