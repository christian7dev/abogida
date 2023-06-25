import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizCreator extends StatefulWidget {
  final id ;
  const QuizCreator({Key? key , this.id}) : super(key: key);

  @override
  State<QuizCreator> createState() => _QuizCreatorState();
}

final _formKey = GlobalKey<FormState>();
final _QuizName = TextEditingController();


class _QuizCreatorState extends State<QuizCreator> {
  @override
  Widget build(BuildContext context) {
    var id = widget.id;
    final data = FirebaseFirestore.instance.collection('class').doc(id).collection('quiz');
    return Scaffold(
      appBar: AppBar(
        title:const  Text(
          "CREATE QUIZ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme:const  IconThemeData(
          color: Colors.black
        ),
      ),
      //========================================================================
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 50.0 , left: 10 , right: 10),
                child: TextFormField(
                  controller: _QuizName,
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "REQUIRED";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "QUIZ NAME",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  )
                ),
              ),





              const SizedBox(
                height: 30,
              ),

              GestureDetector(
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    data.doc().set({
                      'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                      'QName' : _QuizName.text,
                      'created' : false,
                      'type' : 'quiz',
                      'status' : false,
                      'time' : Timestamp.now()
                    }).then((value) => Navigator.pop(context));
                    _QuizName.text = "";
                    return;
                  }
                },
                child: Container(
                  height: 60,
                  width: 130,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0,0),
                          blurRadius: 10,
                        )
                      ]
                  ),
                  child: const Center(
                    child: Text(
                      "CREATE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
