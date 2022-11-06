import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'quiz_starter_page.dart';

class ClassPage extends StatefulWidget {
  final classid;
  final classname;
  const ClassPage({Key? key , this.classid , this.classname}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    var classId = widget.classid;
    var className =widget.classname;
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            iconTheme:const IconThemeData(
              color: Colors.black
            ),
            backgroundColor: Colors.white,
            title:Text(
              className.toString().toUpperCase(),
              style:const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            bottom:  TabBar(
              padding: EdgeInsets.all(10),
              labelColor: Colors.black,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.blue
              ),
              tabs:const [
                Tab(
                  child: Text(
                    "POST",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "QUIZ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ),

          body: TabBarView(
            children: [

              // class post
              //=========================================
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('class').doc(classId).collection('post').snapshots(),
                  builder: (context , snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context, index) {
                          var data = snapshot.data!.docs[index].data();
                          Timestamp time = data["time"];
                          DateTime date = time.toDate();
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              constraints:const BoxConstraints(
                                minHeight: 100,

                              ),
                              decoration:BoxDecoration(
                                  color: Colors.blue[500],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow:const [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 0),
                                      blurRadius: 10,
                                    ),
                                  ]
                              ),
                              child: Column(
                                children:[
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Text(
                                        data["message"],
                                        style:const TextStyle(
                                            fontSize: 17,
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}",
                                    style:const TextStyle(
                                        color: Colors.white70
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          );
                        });
                  }),

              //==================================================================

              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('class').doc(classId).collection('quiz').snapshots(),
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),);
                    }
                    return  ListView.builder(
                        itemCount: snapshot.data!.size,
                        itemBuilder: (context , index){
                          final data = snapshot.data!.docs[index];
                          final quizid = snapshot.data!.docs[index].id;
                          final q_name = data['QName'];
                          Timestamp time = data["time"];
                          DateTime date = time.toDate();
                          return data['status'] == true ?Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 20),
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizStart(classid: classId, quizid: quizid, quizname: q_name,))
                                );
                              },
                              child: Container(
                                constraints:const BoxConstraints(
                                  minHeight: 100
                                ),
                                decoration:BoxDecoration(
                                    color: Colors.blue[800],
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow:const [
                                      BoxShadow(
                                          color: Colors.black,
                                          offset: Offset(0,0),
                                          blurRadius: 10
                                      )
                                    ]
                                ),
                                child:  Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      data['type'].toString().toUpperCase(),
                                      style:const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),


                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                        data['QName'],
                                        softWrap: true,
                                        style:const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}",
                                        style:const TextStyle(
                                            color: Colors.white70
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ) : Container();
                        });
              }),

            ],
          )
      ),
    );
  }
}
