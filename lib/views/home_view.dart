import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chat_view.dart';
import 'package:chat_app/views/sign_in_view.dart';
import 'package:chat_app/views/sign_up_view.dart';
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
    if(value.length ==0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    setState(() {
      search = true;
    });
    var capitalizedValue = value.substring(0,1).toUpperCase() + value.substring(1);
    if(queryResultSet.length == 0 && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) 
      {
              for (int i=0; i<docs.docs.length; ++i) {
                queryResultSet.add(docs.docs[i].data());
              }
      });
       
    }else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
       if(element['Username'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
       }
      }
      
      );
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF553370),
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
                      ?  Expanded(
                          child: TextField(
                            onChanged: (value) {
                              initiateSearch(value.toUpperCase());
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Kullanıcı ara..",
                                hintStyle: TextStyle(color: Colors.black)),
                                style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w500),
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
                      setState(() {
                      
                      });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color(0xFF3a2144),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChatView()));
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
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Text(
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
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            "assets/girl2.jpg",
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Ezgi Aydın",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
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
                  const SizedBox(
                    height: 30.0,
                  ),
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
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Beyza Dikmen",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
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
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset(
                            "assets/boy2.jpg",
                            height: 60,
                            width: 60,
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(
                        width: 10.0,
                      ),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Osman Tekin",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.0,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
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
            )
          ],
        ),
      ),
    );
  }
}
