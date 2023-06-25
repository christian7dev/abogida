import 'dart:async';
import 'package:abogida/drawer/game/screens/win_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'loss_page.dart';

class Quizs extends StatefulWidget {
  final String id;
  final String timer;
  final int number_q;
  List<int> randomNumbers ;
   Quizs({Key? key,
     required this.id,
     required this.timer,
     required this.randomNumbers,
     required this.number_q,
   }) : super(key: key);

  @override
  State<Quizs> createState() => _QuizsState();
}



class _QuizsState extends State<Quizs> {
  Color bgcolor = Colors.black;
  bool _enable = true;

  int page = 0;

  final l_db = FirebaseFirestore.instance.collection("quiz").doc("zwinner").collection("loss");
  final w_db = FirebaseFirestore.instance.collection("quiz").doc("zwinner").collection("win");

  @override
  Widget build(BuildContext context) {
    List<int> randomNumbers = widget.randomNumbers;
    
    final pageController = PageController(
      initialPage: page,
    );
    final id = widget.id;
    final q_no = widget.number_q -1 ;
    final u_data = FirebaseAuth.instance.currentUser!;
    final db = FirebaseFirestore.instance
        .collection("quiz")
        .doc(id)
        .collection("question");
    final timer = int.parse(widget.timer);
    return StreamBuilder(
      stream: db.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }


        final choose = [
          'c1',
          'c2',
          'c3',
          'c4',
          'c5',
          'c6',
          'c7',
          'c8',
          'c9',
          'c10'
        ];
        return Scaffold(
            appBar: AppBar(
              actions: [
                SlideCountdown(
                  duration: Duration(seconds: timer),
                  onDone: () {
                    setState(() {
                      _enable = false;
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LossPage()));
                  },
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ],
              backgroundColor: Colors.white,
            ),
            body: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                itemCount: snapshot.data!.size,
                itemBuilder: (context, ind) {
                  final data = snapshot.data!.docs[randomNumbers[ind]].data();
                  return SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 10, bottom: 10),
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: bgcolor,
                                      offset: const Offset(0, 0),
                                      blurRadius: 15,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      data['q'].toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.length - 2,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_enable) {
                                        if (data['z'].toString() == choose[index]) {
                                          if (page == q_no) {
                                            w_db.doc(u_data.email.toString()).set({
                                              "User_name" : u_data.displayName,
                                              "Email" : u_data.email,
                                              "Last_Question" : data['q'].toString(),
                                              "Answer" : data[choose[index]],
                                              "time" : Timestamp.now(),
                                            });
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WinPage()));
                                          }
                                          setState(() {
                                            bgcolor = Colors.green;
                                            _enable = false;
                                          });
                                          Future.delayed(
                                              const Duration(seconds: 3), () {
                                            setState(() {
                                              _enable = true;
                                              bgcolor = Colors.black;
                                              page += 1;
                                            });
                                          });
                                        } else if (data['z'].toString() !=
                                            choose[index]) {
                                          setState(() {
                                            bgcolor = Colors.red;
                                            _enable = false;
                                            l_db.doc(u_data.email.toString()).set({
                                              "User_name" : u_data.displayName,
                                              "Email" : u_data.email,
                                              "Last_Question" : data['q'].toString(),
                                              "Answer" : data[choose[index]],
                                              "number_of_Question_win" : page ,
                                              "time" : Timestamp.now(),
                                            });
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LossPage()));
                                          });
                                        }
                                      }
                                    },
                                    child: data[choose[index]] != null
                                        ? Container(
                                            constraints: const BoxConstraints(
                                                minHeight: 60),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: bgcolor,
                                                      offset:
                                                          const Offset(0, 0),
                                                      blurRadius: 5)
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(data[choose[index]]),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                }));
      },
    );
  }
}
