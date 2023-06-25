import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class QuizPage extends StatefulWidget {
  final classid;
  final quizid;
  const QuizPage({Key? key , this.classid , this.quizid}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

final _formKey = GlobalKey<FormState>();
final _question = TextEditingController();
final _ansdis = TextEditingController();
final _choose1 = TextEditingController();
final _choose2 = TextEditingController();
final _choose3 = TextEditingController();
final _choose4 = TextEditingController();
final Data = FirebaseFirestore.instance.collection('class');


String answer = "";
int qno = 0;
class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    var classID = widget.classid;
    var quizID = widget.quizid;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //question
              Padding(
                padding: const EdgeInsets.only(top: 50.0 , left: 5 , right: 5),
                child: TextFormField(
                  controller: _question,
                  maxLines: 3,
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "REQUIRED";
                    }
                  },
                  decoration:InputDecoration(
                    hintText: "QUESTION",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),

              //choose A
              Padding(
                padding: const EdgeInsets.only(top: 10.0 , left: 5 , right: 5),
                child: TextFormField(
                  controller: _choose1,
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "REQUIRED";
                    }
                    return null;
                  },
                  decoration:InputDecoration(
                    hintText: "CHOOSE (required)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),

              //choose b
              Padding(
                padding: const EdgeInsets.only(top: 10.0 , left: 5 , right: 5),
                child: TextFormField(
                  controller: _choose2,
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "REQUIRED";
                    }
                    return null;
                  },
                  decoration:InputDecoration(
                    hintText: "CHOOSE (required)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),

              //choose c
              Padding(
                padding: const EdgeInsets.only(top: 10.0 , left: 5 , right: 5),
                child: TextFormField(
                  controller: _choose3,
                  decoration:InputDecoration(
                    hintText: "CHOOSE (optional)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),

              //choose d
              Padding(
                padding: const EdgeInsets.only(top: 10.0 , left: 5 , right: 5),
                child: TextFormField(
                  controller: _choose4,
                  decoration:InputDecoration(
                    hintText: "CHOOSE (optional)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              //dropdown
              Container(
                width: 100,
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
                  child: DropdownButton(
                    style:const TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),

                    items: ['A','B' ,'C' , 'D'].map<DropdownMenuItem<String>>((String e){
                      return DropdownMenuItem<String>(
                          value: e,
                          child: Text(e)
                      );
                    }).toList(),
                    hint: Text(
                        answer,
                      style:const TextStyle(
                        fontSize: 20
                      ),
                    ),
                    onChanged: (val){
                      setState(() {
                        answer = val.toString();
                      });
                    },
                  ),
                ),

              ),

              //description
              Padding(
                padding: const EdgeInsets.only(top: 10.0 , left: 5 , right: 5),
                child: TextFormField(
                  controller: _ansdis,
                  maxLines: 3,
                  decoration:InputDecoration(
                    hintText: "ANSWER DESCRIPTION(OPTIONAL)",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //add button
                 qno != 10 ? GestureDetector(
                    onTap: (){
                        if(_formKey.currentState!.validate()){
                          if(answer != ""){
                            if(_choose3.text.isNotEmpty && _choose4.text.isNotEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).update({
                                'created' : true,
                              });
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : _choose3.text,
                                    'choose4' : _choose4.text,
                                    'answer' : answer,
                                    'description' : _ansdis.text,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                _ansdis.text = "";
                                answer = "";
                              }));
                            }
                            else if(_choose3.text.isEmpty && _choose4.text.isNotEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).update({
                                'created' : true,
                              });
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : null,
                                    'choose4' : _choose4.text,
                                    'answer' : answer,
                                    'description' : _ansdis.text,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                answer = "";
                                _ansdis.text = "";
                              }));
                            }
                            else if(_choose3.text.isNotEmpty && _choose4.text.isEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).update({
                                'created' : true,
                              });
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : _choose3.text,
                                    'choose4' : null,
                                    'answer' : answer,
                                    'description' : _ansdis.text,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                answer = "";
                                _ansdis.text = "";
                              }));
                            }
                            else if(_choose3.text.isEmpty && _choose4.text.isEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).update({
                                'created' : true,
                              });
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : null,
                                    'choose4' : null,
                                    'answer' : answer,
                                    'description' : _ansdis.text,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                answer = "";
                                _ansdis.text = "";
                              }));
                            }
                            qno += 1;
                          }
                          else{Fluttertoast.showToast(
                                msg: "ANSWER REQUIRED",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }

                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:const Center(
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ) : Container(),

                  //done button
                  GestureDetector(
                    onTap: (){
                        if(_formKey.currentState!.validate()){
                          if(answer != ""){
                            if(_choose3.text.isNotEmpty && _choose4.text.isNotEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : _choose3.text,
                                    'choose4' : _choose4.text,
                                    'answer' : answer,
                                    'description' : _ansdis.text,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                answer = "";
                                _ansdis.text = "";
                              }));
                            }
                            else if(_choose3.text.isEmpty && _choose4.text.isNotEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : null,
                                    'choose4' : _choose4.text,
                                    'answer' : answer,
                                    'description' : _ansdis.text,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                answer = "";
                                _ansdis.text = "";
                              }));
                            }
                            else if(_choose3.text.isNotEmpty && _choose4.text.isEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : _choose3.text,
                                    'choose4' : null,
                                    'description' : _ansdis.text,
                                    'answer' : answer,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                answer = "";
                                _ansdis.text = "";
                              }));
                            }
                            else if(_choose3.text.isEmpty && _choose4.text.isEmpty){
                              Data.doc(classID).collection('quiz').doc(quizID).collection('quizes').doc().set(
                                  {
                                    'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                                    'question' : _question.text,
                                    'choose1' : _choose1.text,
                                    'choose2' : _choose2.text,
                                    'choose3' : null,
                                    'choose4' : null,
                                    'answer' : answer,
                                    'description' : _ansdis.text,
                                    'time' : Timestamp.now()
                                  }).then((value) => setState(() {
                                _question.text = "";
                                _choose1.text = "";
                                _choose2.text = "";
                                _choose3.text = "";
                                _choose4.text = "";
                                answer = "";
                                _ansdis.text = "";
                              }));
                            }
                            Navigator.pop(context);
                          }
                          else{
                            Fluttertoast.showToast(
                                msg: "ANSWER REQUIRED",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0
                            );
                          }

                        }

                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:const Center(
                        child: Text(
                          "DONE",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
