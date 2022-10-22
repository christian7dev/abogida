import 'package:abogida/Pages/class_page.dart';
import 'package:flutter/material.dart';


class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

const c_hight = 70.0;
const c_width = 400.0;

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 6,
        onPageChanged: (index){
          print(index);
        },
          itemBuilder: (context , index){
          if(index == 5){
            return SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 300,
                      child: Center(
                        child: Text(
                          "🎊🎊🎊🎊🎊🎊🎊🎊🎊\n"
                              "     CONGRAGULATION\n"
                              "🎊🎊🎊🎊🎊🎊🎊🎊🎊",
                          style: TextStyle(
                              fontSize: 25
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "YOU SCORE   10/10",
                      style: TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    const SizedBox(
                      height: 100,
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).pushNamedAndRemoveUntil("ClassPage", (route) => route.isFirst);
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
                            "DONE",
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
            );
          }


          else{
            return SafeArea(
                child:SingleChildScrollView(
                  child: Column(
                    children: [




                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration:const BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 0),
                                    blurRadius: 10
                                )
                              ]
                          ),
                          constraints:const BoxConstraints(
                              maxHeight: 200
                          ),
                          child:const Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Text(
                                  "question",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),



                      const SizedBox(
                        height: 30,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: c_hight
                          ),
                          width: c_width,
                          decoration:const BoxDecoration(
                              color: Colors.lightBlueAccent
                          ),
                          child:const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "hello",
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: c_hight
                          ),
                          width: c_width,
                          decoration:const BoxDecoration(
                              color: Colors.lightBlueAccent
                          ),
                          child: Text(
                            "hello b",
                            style: TextStyle(
                                fontSize: 15
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: c_hight
                          ),
                          width: c_width,
                          decoration:const BoxDecoration(
                              color: Colors.lightBlueAccent
                          ),
                          child: Text(
                            "hello c",
                            style: TextStyle(
                                fontSize: 15
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Container(
                          constraints: const BoxConstraints(
                              minHeight: c_hight
                          ),
                          width: c_width,
                          decoration:const BoxDecoration(
                              color: Colors.lightBlueAccent
                          ),
                          child: Text(
                            "hello d",
                            style: TextStyle(
                                fontSize: 15
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )
            );
          }

      }),
    );
  }
}
