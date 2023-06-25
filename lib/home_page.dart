import 'package:abogida/Pages/class_page.dart';
import 'package:abogida/auth_service.dart';
import 'package:abogida/drawer/admin/pages/login_page.dart';
import 'package:abogida/drawer/game/screens/Start.dart';
import 'package:abogida/entry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    bool is_admin = false;
    final info = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("app_admin").snapshots(),
        builder: (context, ad_snapshot) {
          if(ad_snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          for (int i = 0 ; i < ad_snapshot.data!.size ; i++){
            final data = ad_snapshot.data!.docs[i];
            if(data.id == info!.email && data.data()['app_admin'] == true){
                is_admin = true;
            }}
          return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: title(),
                  centerTitle: true,
                  iconTheme: const IconThemeData(color: Colors.black),
                  bottom: TabBar(
                    padding: const EdgeInsets.all(10),
                    labelColor: Colors.black,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue),
                    tabs: const [
                      Tab(
                        child: Text(
                          "POST",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "DEPARTMENT",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: Text(info!.displayName.toString()),
                        accountEmail: Text(info.email.toString()),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage:
                              NetworkImage(info.photoURL.toString()),
                        ),
                      ),
                      ListTile(
                        title: const Text("Game"),
                        leading: const Icon(Icons.gamepad),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const QuizStarter()));
                        },
                      ),
                      is_admin ? ListTile(
                        title: const Text("App Admin"),
                        leading: const Icon(Icons.construction_rounded),
                        onTap: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Admin_Login()));
                        },
                      ): Container(),
                      //log out
                      ListTile(
                        title: const Text("Logout"),
                        leading: const Icon(Icons.exit_to_app),
                        onTap: () async {
                          await Auth().signOut();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    //                   post page
                    // ==================================================================
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('post')
                            .orderBy('time', descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.docs[index].data();
                                Timestamp time = data["time"];
                                DateTime date = time.toDate();
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                      minHeight: 100,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade700,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Text(
                                              data["message"],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}",
                                          style: const TextStyle(
                                              color: Colors.white70),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }),

                    //                   class page
                    // ==================================================================
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('class')
                            .orderBy("time", descending: true)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.size,
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.docs[index].data();
                                String classid = snapshot.data!.docs[index].id;
                                Timestamp time = data["time"];
                                DateTime date = time.toDate();
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ClassPage(
                                                  classid: classid,
                                                  classname: data['class_name'],
                                                )),
                                      );
                                    },
                                    child: Container(
                                      constraints:
                                          const BoxConstraints(minHeight: 100),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(0, 0),
                                              blurRadius: 10,
                                            ),
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                data['class_name']
                                                    .toString()
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 300,
                                              child: Text(
                                                data['class_description'],
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "${date.hour}:${date.minute}\t\t${date.day}/${date.month}/${date.year}",
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        })
                  ],
                )),
          );
        });
  }

  Widget title() {
    return RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: "አ ቦ ",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
      TextSpan(
          text: "ጊ ዳ",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20))
    ]));
  }
}
