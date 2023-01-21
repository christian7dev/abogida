import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class QuizPage extends StatefulWidget {
  var classid , quizid;
  QuizPage({Key? key , this.classid , this.quizid }) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

const c_hight = 70.0;
const c_width = 400.0;
int page = 0;

class _QuizPageState extends State<QuizPage> {
  List<Color> colorA = [Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white];
  List<Color> colorB = [Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white];
  List<Color> colorC = [Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white];
  List<Color> colorD = [Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white , Colors.white];

  @override
  Widget build(BuildContext context) {
    var quizId = widget.quizid;
    var classId = widget.classid;
    final pageController = PageController(initialPage: page);

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('class').doc(classId)
          .collection('quiz').doc(quizId).collection('quizes').snapshots(),
        builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),),
          );
        }
          return Scaffold(
            body: PageView.builder(
              controller: pageController,
                itemCount: snapshot.data!.size + 1,
                itemBuilder: (context , index){
                  if(index == (snapshot.data!.size)){
                    return SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 300,
                              child: Center(
                                child: Text(
                                  "DONE!",
                                  style: TextStyle(
                                      fontSize: 28,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 70,
                            ),


                            GestureDetector(
                              onTap: (){
                                page = 0 ;
                                Navigator.pop(context);
                                Navigator.pop(context);
                                //Navigator.of(context).pushNamedAndRemoveUntil("ClassPage", (route) => route.isFirst);
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
                                    "BACK TO HOME",
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
                    var data = snapshot.data!.docs[index];
                    return SafeArea(
                        child:SingleChildScrollView(
                          child: Column(
                            children: [

                              //QUESTION
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration:BoxDecoration(
                                      color: Colors.white,
                                      boxShadow:const [
                                        BoxShadow(
                                            color: Colors.black,
                                            offset: Offset(0, 0),
                                            blurRadius: 10
                                        ),
                                      ],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  constraints:const BoxConstraints(
                                      maxHeight: 200
                                  ),
                                  child:Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          data['question'],
                                          style:const TextStyle(
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

                              //CHOOSE A
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    if(data['answer'] == "A"){
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorA[index] = Colors.blue;
                                      });
                                    }else{
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorA[index] = Colors.red;
                                      });
                                    }
                                  },
                                  child: Container(
                                    constraints:const BoxConstraints(
                                        minHeight: c_hight
                                    ),
                                    width: c_width,
                                    decoration:BoxDecoration(
                                      boxShadow:const [
                                        BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0,0),
                                          blurRadius: 10
                                        )
                                      ],
                                        color: colorA[index],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child:Padding(
                                      padding:const EdgeInsets.all(15.0),
                                      child: Center(
                                        child: Text(
                                          data['choose1'],
                                          style:const TextStyle(
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              //CHOOSE B
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    if(data['answer'] == "B"){
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorB[index] = Colors.blue;
                                      });
                                    }else{
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorB[index] = Colors.red;
                                      });
                                    }
                                  },
                                  child: Container(
                                    constraints:const BoxConstraints(
                                        minHeight: c_hight
                                    ),
                                    width: c_width,
                                    decoration:BoxDecoration(
                                        boxShadow:const [
                                          BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(0,0),
                                              blurRadius: 10
                                          )
                                        ],
                                        color: colorB[index],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                        child: Text(
                                          data['choose2'],
                                          style:const TextStyle(
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              //CHOOSE C
                              data['choose3'].toString() != "null" ?
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    if(data['answer'] == "C"){
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorC[index] = Colors.blue;
                                      });
                                    }else{
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorC[index] = Colors.red;
                                      });
                                    }
                                  },
                                  child: Container(
                                    constraints:const BoxConstraints(
                                        minHeight: c_hight
                                    ),
                                    width: c_width,
                                    decoration:BoxDecoration(
                                        boxShadow:const [
                                          BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(0,0),
                                              blurRadius: 10
                                          )
                                        ],
                                        color: colorC[index],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                        child: Text(
                                          data['choose3'].toString(),
                                          style:const TextStyle(
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ) : Container(),

                              const SizedBox(
                                height: 20,
                              ),

                              //CHOOSE D
                              data['choose4'].toString() != "null" ?
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    if(data['answer'] == "D"){
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorD[index] = Colors.blue;
                                      });
                                    }else{
                                      setState(() {
                                        page = index;
                                        colorB[index] = Colors.white;
                                        colorC[index] = Colors.white;
                                        colorD[index] = Colors.white;
                                        colorA[index] = Colors.white;
                                        colorD[index] = Colors.red;
                                      });
                                    }
                                  },
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        minHeight: c_hight
                                    ),
                                    width: c_width,
                                    decoration:BoxDecoration(
                                        boxShadow:const [
                                          BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(0,0),
                                              blurRadius: 10
                                          )
                                        ],
                                        color: colorD[index],
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                        child: Text(
                                          data['choose4'].toString(),
                                          style:const TextStyle(
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ) :Container(),

                              const SizedBox(
                                height: 50,
                              ),

                              GestureDetector(
                                onTap: (){
                                  showDialog(context: context, builder: (context) =>AlertDialog(
                                    title:const Text("EXPLANATION"),
                                    content:  Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                                      child: Text(data['description']),
                                    ),
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

                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        )
                    );
                  }

                }),
          );
    });
  }
}
