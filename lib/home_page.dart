import 'package:abogida/Pages/class_page.dart';
import 'package:abogida/Pages/quiz_starter_page.dart';
import 'package:flutter/material.dart';



class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: title(),
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
                    "CLASS",
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
                        color: Colors.teal,
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
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => ClassPage()
                              ),
                          );
                        },
                        child: Container(
                          height: 100,
                          decoration:const BoxDecoration(
                            color: Colors.deepPurple,
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



  Widget title(){
    return RichText(
        text:const  TextSpan(
            children: [
              TextSpan(
                  text: "አ ቦ ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )
              ),
              TextSpan(
                  text: "ጊ ዳ",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  )
              )
            ])
    );
  }
}

