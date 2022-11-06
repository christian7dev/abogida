import 'package:abogida/Pages/quiz_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuizStart extends StatefulWidget {
  var classid;
  var quizid;
  var quizname;
  QuizStart({Key? key , this.classid , this.quizid , this.quizname}) : super(key: key);

  @override
  State<QuizStart> createState() => _QuizStartState();
}

class _QuizStartState extends State<QuizStart> {
  @override
  Widget build(BuildContext context) {
    var c_id = widget.classid;
    var q_id = widget.quizid;
    var q_name = widget.quizname;
    return StreamBuilder(
      stream:  FirebaseFirestore.instance.collection('class').doc(c_id).collection('quiz').doc(q_id).collection('quizes').snapshots(),
        builder: (context , snapshot){

        if (snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Center(
                        child: Text(
                          q_name,
                          style:const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Text(
                      "Number of questions : ${snapshot.data!.size}",
                      style:const TextStyle(
                          fontSize: 17
                      ),
                    ),

                    const SizedBox(
                      height: 100,
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => QuizPage(quizid: q_id, classid: c_id)));
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(0,0),
                                  blurRadius: 10
                              )
                            ]
                        ),
                        child:const  Center(
                          child: Text(
                            "START",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
    });
  }
}
