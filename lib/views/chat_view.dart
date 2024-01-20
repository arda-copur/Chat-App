import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF553370),
      body: Container(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
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
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
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
                    padding: const EdgeInsets.all(10),
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
                    elevation: 5.0,
                     borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: Row(children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(border: InputBorder.none, hintText: "Type a message", hintStyle: TextStyle(color: Colors.black45)),
                        ),
                      ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: const Color(0xFFf3f3f3), borderRadius: BorderRadius.circular(60)),
                    child: const Center(child: Icon(Icons.send, color: Color(0xFF553370),)))
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