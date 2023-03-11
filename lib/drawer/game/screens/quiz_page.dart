import 'dart:async';
import 'package:abogida/drawer/game/screens/win_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'loss_page.dart';

class Quizs extends StatefulWidget {
  final String id;
  const Quizs({Key? key, required this.id}) : super(key: key);

  @override
  State<Quizs> createState() => _QuizsState();
}

int page = 0;

class _QuizsState extends State<Quizs> {
  Color bgcolor = Colors.black;
  bool _enable = true;
  late Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            Navigator.pushReplacement(
                context, MaterialPageRoute(
                builder: (context) => LossPage()));
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    final pageController = PageController(
      initialPage: page,
    );
    final id = widget.id;
    final db = FirebaseFirestore.instance
        .collection("quiz")
        .doc(id)
        .collection("question");
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

        final choose = ['c1', 'c2', 'c3', 'c4', 'c5', 'c6', 'c7', 'c8', 'c9' , 'c10'];
        return Scaffold(
            appBar: AppBar(
                title: Text(
                  _start.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body: PageView.builder(
                controller: pageController,
                itemCount: snapshot.data!.size,
                itemBuilder: (context, ind) {
                  final data = snapshot.data!.docs[ind].data();
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
                                  borderRadius: BorderRadius.circular(20)),
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
                                        if (data['z'].toString() ==
                                            choose[index]) {
                                          if (page == 3) {
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
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LossPage()));
                                          });
                                        }
                                      }
                                    },
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(minHeight: 60),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: bgcolor,
                                                offset: const Offset(0, 0),
                                                blurRadius: 5)
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(data[choose[index]]),
                                      ),
                                    ),
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
