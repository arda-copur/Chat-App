import 'package:chat_app/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  String email = "";
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userMailController = TextEditingController();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Şifre sıfırlama bağlantısı gönderildi.")));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Hesap bulunamadı.")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF7f30fe), Color(0xFF6380fb)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 105)))),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Column(
                children: [
                  const Center(
                      child: Text(
                    "Şifrenizi mi unuttunuz?",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  )),
                  const Center(
                      child: Text(
                    "Lütfen kayıtlı mail adresinizi girin",
                    style: TextStyle(
                        color: Color(0xFFbbb0ff),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                  )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 20.0),
                        height: MediaQuery.of(context).size.height / 2.6,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Email",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0, color: Colors.black38),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextFormField(
                                  controller: userMailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ' Lütfen email giriniz';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.mail_outline,
                                        color: Color(0xFF7f30fe),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 50.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      email = userMailController.text;
                                    });
                                    resetPassword();
                                  }
                                },
                                child: Center(
                                  child: SizedBox(
                                    width: 150,
                                    child: Material(
                                      elevation: 5.0,
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF6380fb),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Center(
                                            child: Text(
                                          "Gönder",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hesabınız yok mu?",
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpView()));
                        },
                        child: const Text(
                          " Şimdi üye ol!",
                          style: TextStyle(
                              color: Color(0xFF7f30fe),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
