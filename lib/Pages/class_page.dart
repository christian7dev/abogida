import 'package:flutter/material.dart';

import 'quiz_starter_page.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title:const Text(
              "CLASS NAME",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            bottom:  TabBar(
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
              ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context , index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        color: Colors.brown,
                      ),
                    );
                  }),

              //==================================================================

              ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context , index){
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuizStart())
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration:const BoxDecoration(
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    );
                  })
            ],
          )
      ),
    );
  }
}
