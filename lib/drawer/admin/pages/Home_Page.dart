import 'package:abogida/drawer/admin/class_pages/Class_Setting_Page.dart';
import 'package:abogida/drawer/admin/pages/Post_Page.dart';
import 'package:abogida/drawer/admin/pages/class_creator.dart';
import 'package:abogida/drawer/admin/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

final data = FirebaseFirestore.instance.collection('class').orderBy("time", descending: true);
final Pdata = FirebaseFirestore.instance.collection('post').orderBy("time", descending: true);


class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        //===================================================================================
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
          title:const Text(
              "ADMIN PANEL",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
        bottom: TabBar(
          padding: EdgeInsets.all(10),
          labelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.blue
          ),
          tabs: const [
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
                "DEPARTMENT ",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Admin_Login()));
              },
                child: const Icon(Icons.exit_to_app)
            ),
          )
        ],
      ),

          //===================================================================================
          body: TabBarView(
            children: [
              // post page
              //======================================
              StreamBuilder(
                stream: Pdata.snapshots(),
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context , int index){
                        final C_data = snapshot.data!.docs[index].data();
                        final id = snapshot.data!.docs[index].id;
                        Timestamp time = C_data["time"];
                        DateTime date = time.toDate();
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0 , right: 10 , left: 10),
                          child: Container(
                            constraints:const BoxConstraints(
                                minHeight: 100
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),

                            //==========================================================================
                            child: Column(
                              children: [

                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    C_data['message'].toString().toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),

                                //    delete button
                                //=========================================================================================
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}"),
                                      GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context, builder: (context) => AlertDialog(
                                            title:const Text("NOTICE"),
                                            content:const Text("This post will be deleted and you can't recover it\nARE YOU SURE YOU WANT TO DELETE "),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    FirebaseFirestore.instance.collection('post').doc(id).delete()
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
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),

              // class page
              //======================================
              StreamBuilder(
                stream: data.snapshots(),
                builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context , int index){
                        final C_data = snapshot.data!.docs[index].data();
                        final id = snapshot.data!.docs[index].id;
                        Timestamp time = C_data["time"];
                        DateTime date = time.toDate();
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0 , right: 10 , left: 10),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ClassSetting(classname: C_data['class_name'],classid: id,)));
                            },
                            child: Container(
                              constraints:const BoxConstraints(
                                  minHeight: 100
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),

                              //==========================================================================
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      C_data['class_name'].toString().toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  //DESCRIPTION
                                  //========================================
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      C_data['class_description'],
                                      style:const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),

                                  //    delete button
                                  //=========================================================================================
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}"),
                                        GestureDetector(
                                          onTap: (){
                                            showDialog(
                                                context: context, builder: (context) => AlertDialog(
                                              title:const Text("NOTICE"),
                                              content:const Text("This class will be deleted and you can't recover it\nARE YOU SURE YOU WANT TO DELETE "),
                                              actions: [
                                                TextButton(
                                                    onPressed: (){
                                                      FirebaseFirestore.instance.collection('class').doc(id).delete()
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
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ],
          ),


          //===================================================================================
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
                Navigator.of(context)
                    .push(MaterialPageRoute(
                    builder: (context) => const Dep_Page()));
              },
              backgroundColor: Colors.red,
              child:const Icon(
                  Icons.class_rounded,
                color: Colors.white,
                size: 25,
              ),
              label: "CREATE DEPARTMENT",
              labelBackgroundColor: Colors.red,
              labelStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
              )
            ),
            //===================================================================================
            SpeedDialChild(
                onTap: (){
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                      builder: (context) =>const Post_page()));
                },
                backgroundColor: Colors.amber,
                child: const Icon(
                  Icons.post_add,
                  color: Colors.black,
                  size: 25,
                ),
                label: "ADD POST",
                labelBackgroundColor: Colors.amber,
                labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )
            )
          ],
        )
      ),
    );
  }
}
