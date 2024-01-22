import 'package:chat_app/constants/project_borders.dart';
import 'package:chat_app/constants/project_elevations.dart';
import 'package:chat_app/constants/project_paddings.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/sign_in_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
import 'package:chat_app/widgets/constant_sized_boxs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool search = false;

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
    if (queryResultSet.length == 0 && value.length == 1) {
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
      backgroundColor: Colors.greenAccent[400],
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Kullanıcı ara..",
                                hintStyle: TextStyle(color: Colors.black)),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            DatabaseMethods().signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInView()));
                          },
                          child: const Icon(
                            Icons.output_outlined,
                            size: 30,
                            color: Colors.white,
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
                            color: const Color(0xFF3a2144),
                            borderRadius: ProjectBorders.circularSmall() * 2),
                        child: search
                            ? GestureDetector(
                              onTap: () {
                                search = false;
                                setState(() {
                                  
                                });
                              },
                              child: const Icon(
                                  Icons.close,
                                  color: Color(0Xffc199cd),
                                ),
                            )
                            : const Icon(
                                Icons.search,
                                color: Color(0Xffc199cd),
                              )),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  search
                      ? ListView(
                          padding: const ProjectPaddings.onlyLeftRight(),
                          primary: false,
                          shrinkWrap: true,
                          children: tempSearchStore.map((element) {
                            return buildResultCard(element);
                          }).toList())
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChatView()));
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.asset(
                                        "assets/boy.jpg",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      )),
                                  ConstantSizedBoxs.lowWidthSizedBox(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstantSizedBoxs.lowHeightSizedBox(),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Arda Çopur",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "Naber?",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Text(
                                    "04:30 PM",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            ConstantSizedBoxs.largeHeightSizedBox(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius:
                                        ProjectBorders.circularSmall() * 6,
                                    child: Image.asset(
                                      "assets/girl2.jpg",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    )),
                                ConstantSizedBoxs.lowWidthSizedBox(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantSizedBoxs.lowHeightSizedBox(),
                                    const Text(
                                      "Ezgi Aydın",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Text(
                                      "İyi misin?",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Text(
                                  "05:30 PM",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            ConstantSizedBoxs.largeHeightSizedBox(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.asset(
                                      "assets/girl.jpg",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.cover,
                                    )),
                                ConstantSizedBoxs.lowWidthSizedBox(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantSizedBoxs.lowHeightSizedBox(),
                                    const Text(
                                      "Beyza Dikmen",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Text(
                                      "Napıyosun",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Text(
                                  "10:30 AM",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            ConstantSizedBoxs.largeHeightSizedBox(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                    borderRadius:
                                        ProjectBorders.circularSmall() * 6,
                                    child: Image.asset(
                                      "assets/boy2.jpg",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fill,
                                    )),
                                ConstantSizedBoxs.lowWidthSizedBox(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ConstantSizedBoxs.lowHeightSizedBox(),
                                    const Text(
                                      "Osman Tekin",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Text(
                                      "Müsait misin",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                const Text(
                                  "12:30 AM",
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: ProjectElevations.normal.value,
        borderRadius: ProjectBorders.circularSmall(),
        child: Container(
          padding: const ProjectPaddings.allMedium(),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                  ConstantSizedBoxs.lowHeightSizedBox(),
                  Text(
                    data["Username"],
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
