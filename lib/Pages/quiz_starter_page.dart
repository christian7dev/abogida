import 'package:abogida/Pages/quiz_page.dart';
import 'package:flutter/material.dart';

class QuizStart extends StatefulWidget {
  const QuizStart({Key? key}) : super(key: key);

  @override
  State<QuizStart> createState() => _QuizStartState();
}

class _QuizStartState extends State<QuizStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 300,
                child: Center(
                  child: Text(
                      "Quiz name",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                ),
              ),

             const SizedBox(
                height: 10,
              ),

             const Text(
                "Number of Questions  10",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(
                height: 100,
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => QuizPage()));
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
  }
}
