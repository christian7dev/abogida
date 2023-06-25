
import 'package:abogida/drawer/admin/class_pages/class_post.dart';
import 'package:abogida/drawer/admin/class_pages/quiz_creater_pages.dart';
import 'package:abogida/drawer/admin/class_pages/quiz_editor_page.dart';
import 'package:abogida/drawer/admin/class_pages/quiz_room_create_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class ClassSetting extends StatefulWidget {
  final classname;
  final classid;
  const ClassSetting({Key? key , this.classname , this.classid}) : super(key: key);

  @override
  State<ClassSetting> createState() => _ClassSettingState();
}





class _ClassSettingState extends State<ClassSetting> {
  @override
  Widget build(BuildContext context) {
    final class_name = widget.classname;
    final id = widget.classid;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          class_name.toString().toUpperCase(),
          style:const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme:const IconThemeData(
          color: Colors.black
        ),
      ),
      //==============================================================================


      body: SingleChildScrollView(
        child: DefaultTabController( 
          length: 2,
          child: Column(
            children: [
              const SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(20)
                      ),
                        tabs:const [
                      Tab(text: "POST",),
                      Tab(text: "QUIZ",)
                    ]),
                  ),
                ),
              ),


              Container(
                height: MediaQuery.of(context).size.height/1.5,
                child: TabBarView(
                    children: [

                      StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('class').doc(id).collection('post').snapshots(),
                          builder: (context , snapshot){
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const Center(child: CircularProgressIndicator(),);
                            }
                          return ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context , index){
                                final data = snapshot.data!.docs[index];
                                final qid = snapshot.data!.docs[index].id;
                                Timestamp time = data["time"];
                                DateTime date = time.toDate();
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 100
                                    ),
                                    decoration: BoxDecoration(
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
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SizedBox(
                                            width: 300,
                                            child: Text(
                                              data['message'],
                                              style:const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                "${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}",
                                                style:const TextStyle(
                                                    color: Colors.white70
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  showDialog(
                                                      context: context, builder: (context) => AlertDialog(
                                                    title:const Text("NOTICE"),
                                                    content:const Text("\nARE YOU SURE YOU WANT TO DELETE THIS POST "),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: (){
                                                            FirebaseFirestore.instance.collection('class').doc(id).collection('post').doc(qid).delete()
                                                                .then((value) => Navigator.pop(context));
                                                          },
                                                          child:const Text("YES")
                                                      ),
                                                      TextButton(
                                                          onPressed: ()=> Navigator.pop(context),
                                                          child:const Text("NO")
                                                      ),
                                                    ],
                                                  ));
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                          });
                      }),


                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('class').doc(id).collection('quiz').snapshots(),
                        builder: (context , snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(child: CircularProgressIndicator(),);
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context , index){
                                final data = snapshot.data!.docs[index];
                                final quizid = snapshot.data!.docs[index].id;
                                Timestamp time = data["time"];
                                DateTime date = time.toDate();
                                return Padding(
                                  padding: const EdgeInsets.only(top: 20.0 , right: 10 , left: 10),
                                  child: GestureDetector(
                                    onTap: (){
                                      if(data['created'] == true){
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => QuizCheck(classid: id, quizid: quizid,)));
                                      }
                                      else{
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) => QuizPage(classid: id, quizid: quizid,)));
                                      }
                                    },
                                    child: Container(
                                      constraints:const BoxConstraints(
                                        minHeight: 100
                                      ),
                                      decoration: BoxDecoration(
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
                                      child: Column(
                                        children: [

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
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  "${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}",
                                                  style:const TextStyle(
                                                      color: Colors.white70
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    showDialog(
                                                        context: context, builder: (context) => AlertDialog(
                                                      title:const Text("NOTICE"),
                                                      content:const Text("\nARE YOU SURE YOU WANT TO POST THIS QUIZ"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: (){
                                                              FirebaseFirestore.instance.collection('class').doc(id).collection('quiz').doc(quizid).update({
                                                                'status' : true,
                                                              })
                                                                  .then((value) => Navigator.pop(context));
                                                            },
                                                            child:const Text("YES")
                                                        ),
                                                        TextButton(
                                                            onPressed: ()=> Navigator.pop(context),
                                                            child:const Text("NO")
                                                        ),
                                                      ],
                                                    ));
                                                  },
                                                  child:const Icon(
                                                    Icons.upload,
                                                    size: 30,
                                                  ),
                                                ),



                                                GestureDetector(
                                                  onTap: (){
                                                    showDialog(
                                                        context: context, builder: (context) => AlertDialog(
                                                      title:const Text("NOTICE"),
                                                      content:const Text("This Quiz will be deleted and you can't recover it\nARE YOU SURE YOU WANT TO DELETE "),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: (){
                                                              FirebaseFirestore.instance.collection('class').doc(id).collection('quiz').doc(quizid).delete()
                                                                  .then((value) => Navigator.pop(context));
                                                            },
                                                            child:const Text("YES")
                                                        ),
                                                        TextButton(
                                                            onPressed: ()=> Navigator.pop(context),
                                                            child:const Text("NO")
                                                        ),
                                                      ],
                                                    ));
                                                  },
                                                  child:const Icon(
                                                    Icons.delete,
                                                    size: 30,
                                                  ),
                                                ),

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                      ),

                    ]),
              ),

            ],
          ),
        ),
      ),


      //==============================================================================
      floatingActionButton: SpeedDial(
        spaceBetweenChildren: 15,
        overlayColor: Colors.black,
        spacing: 5,
        animationCurve: Curves.decelerate,
        elevation: 20,
        animatedIcon: AnimatedIcons.menu_close,

        children: [
          SpeedDialChild(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => QuizCreator(id: id,)));
              },
              backgroundColor: Colors.red,
              child:const Icon(
                Icons.text_snippet,
                color: Colors.white,
                size: 25,
              ),
              label: "CREATE QUIZ",
              labelBackgroundColor: Colors.red,
              labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              )
          ),
          //===================================================================================
          SpeedDialChild(
              onTap: (){
                Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => ClassPostPage(id: id,)));
              },
              backgroundColor: Colors.amber,
              child: const Icon(
                Icons.book,
                color: Colors.black,
                size: 25,
              ),
              label: "POST",
              labelBackgroundColor: Colors.amber,
              labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )
          )
        ],
      ),
    );

  }
}
