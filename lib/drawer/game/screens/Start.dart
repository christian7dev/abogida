import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../const/pages.dart';
import 'quiz_page.dart';

class QuizStarter extends StatefulWidget {
  const QuizStarter({Key? key}) : super(key: key);

  @override
  State<QuizStarter> createState() => _QuizStarterState();
}

class _QuizStarterState extends State<QuizStarter> {
  final db = FirebaseFirestore.instance.collection("quiz");
  final c_user = FirebaseAuth.instance.currentUser!.email;

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

          List<int> randomNumbers = [];
          Random random = Random();
          while (randomNumbers.length < data['quiz_no']) {
            int randomNumber = random.nextInt(data['total_no']);
            if (!randomNumbers.contains(randomNumber)) {
              randomNumbers.add(randomNumber);
            }
          }
          final db2 = FirebaseFirestore.instance
              .collection("quiz")
              .doc("zgamer")
              .collection("player_list")
              .doc(c_user);
          return StreamBuilder(
              stream: db2.snapshots(),
              builder: (context, sec_snapshot) {
                if (sec_snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final g_data = sec_snapshot.data!.data();
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
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown),
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
                        if (data['isactive'] && g_data == null)
                          GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("quiz")
                                  .doc("zgamer")
                                  .collection("player_list")
                                  .doc(c_user)
                                  .set({
                                c_user.toString(): "play",
                              }).then((value) => Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: (context) => Quizs(
                                                id: snapchat.data!.docs[0].id
                                                    .toString(),
                                                timer: snapchat.data!.docs[0]
                                                    .data()['timer'],
                                                randomNumbers: randomNumbers,
                                                number_q: data['quiz_no'],
                                              ))));
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
                                  gradient: const LinearGradient(colors: [
                                    Colors.blue,
                                    Colors.black,
                                    Colors.red
                                  ]),
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
                          )
                        else
                          Container(),

                        const Spacer(),
                        data['promo_link'].toString().isNotEmpty
                            ? sBanner(data['promo_link'].toString())
                            : Container(),
                        //footer
                        const SizedBox(
                          height: 100,
                        ),
                        pageRow(data['username'].toString()),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
