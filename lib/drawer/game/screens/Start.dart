import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../const/pages.dart';
import 'quiz_page.dart';

class QuizStarter extends StatefulWidget {
  const QuizStarter({Key? key}) : super(key: key);

  @override
  State<QuizStarter> createState() => _QuizStarterState();
}

class _QuizStarterState extends State<QuizStarter> {
  final db = FirebaseFirestore.instance.collection("quiz");
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.snapshots(),
        builder: (context, snapchat) {
          if (snapchat.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final data = snapchat.data!.docs[0].data();

          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 7,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text(
                        data["message"],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.brown),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //LOGO
                  Center(
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "ጨ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "ዋ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "ታ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold)),
                    ])),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  //button
                  data['isactive'] ?
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Quizs(id: snapchat.data!.docs[0].id.toString(),)));
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 0),
                              blurRadius: 10,
                            )
                          ],
                          gradient: const LinearGradient(
                              colors: [Colors.blue, Colors.black, Colors.red]),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child: Text(
                          "START",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ):Container(),

                  Spacer(),
                  data['promo_link'].toString().isNotEmpty
                      ? sBanner(data['promo_link'].toString())
                      : Container(),
                  //footer
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          "HELP ?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Divider(),
                        Text(
                          "ABOUT",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
