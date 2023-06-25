import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class QuizCheck extends StatefulWidget {
  final classid;
  final quizid;
  const QuizCheck({Key? key , this.classid , this.quizid}) : super(key: key);

  @override
  State<QuizCheck> createState() => _QuizCheckState();
}



class _QuizCheckState extends State<QuizCheck> {


  @override
  Widget build(BuildContext context) {
    var classid = widget.classid;
    var quizid = widget.quizid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme:const IconThemeData(
          color: Colors.black
        ),
        title:const Text(
            "Quiz Edit",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('class')
            .doc(classid).collection('quiz')
            .doc(quizid).collection('quizes').snapshots(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else{

          }
          return PageView.builder(
            itemCount: snapshot.data!.size,
              itemBuilder: (context , index){
                var data = snapshot.data!.docs[index].data();
                var qid = snapshot.data!.docs[index].id;

              var question = data['question'];
              var choose1 = data['choose1'];
              var choose2 = data['choose2'];
              var choose3 = data['choose3'];
              var choose4 = data['choose4'];
              var description = data['description'];
              var answer = data['answer'];


                return SingleChildScrollView(
                  child: Form(
                    child: Column(
                      children: [

                        //question
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 10),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                readOnly: true,
                                maxLines: 4,
                                onChanged: (val){
                                  if(val.isNotEmpty){
                                    question = val;
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  hintText: question,
                                  hintStyle:const TextStyle(
                                    color: Colors.black,
                                  )
                                ),
                              )
                            ),
                          ),
                        ),

                        //choose1
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              onChanged: (val){
                                if(val.isNotEmpty){
                                  choose1 = val;
                                }
                              },
                              maxLines: 2,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  hintText: choose1,
                                hintStyle:const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            )
                        ),

                        //choose2
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              onChanged: (val){
                                if(val.isNotEmpty){
                                  choose2 = val;
                                }
                              },
                              maxLines: 2,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  hintText: choose2,
                                  hintStyle:const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            )
                        ),

                        //choose3
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              onChanged: (val){
                                  choose3 = val;
                              },
                              maxLines: 2,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  hintText: choose3,
                                  hintStyle:const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            )
                        ),

                        //choose4
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              onChanged: (val){
                                  choose4 = val;
                              },
                              maxLines: 2,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                  hintText:choose4,
                                  hintStyle:const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            )
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [


                            GestureDetector(
                              onTap: (){
                                showDialog(context: context, builder: (context) => AlertDialog(
                                  title:const Text("EXPLANATION"),
                                  content:  Text("\n${description}"),
                                ));
                              },
                              child: Container(
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow:const [
                                      BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 5
                                      )
                                    ]
                                ),
                                child: const Center(
                                  child: Text(
                                    "EXPLAIN",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),


                            Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow:const [
                                    BoxShadow(
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                        blurRadius: 5
                                    )
                                  ]
                              ),
                              child: Center(
                                child:  Text(
                                  "Answer $answer",
                                  style:const TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        GestureDetector(
                          onTap: (){
                            showDialog(context: context,
                                builder: (context) =>AlertDialog(
                                  content:const  Text("ARE YOU SURE YOU WANT TO DELETE THIS QUESTION !!"),
                                  actions: [
                                    TextButton(
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection('class')
                                              .doc(classid).collection('quiz')
                                              .doc(quizid).collection('quizes').doc(qid).delete().then((value) => Navigator.pop(context));
                                        },
                                        child:const Text("YES")
                                    ),
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child:const Text("NO")
                                    )
                                  ],
                                ));
                          },
                          child: const Icon(
                            Icons.delete,
                            size: 30,
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),




                      ],
                    ),
                  ),
                );
              });
        },
      )
    );

  }
}
