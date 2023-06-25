
import 'package:abogida/drawer/admin/pages/Home_Page.dart';
import 'package:abogida/drawer/admin/pages/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Admin_Login extends StatefulWidget {
  const Admin_Login({Key? key}) : super(key: key);

  @override
  State<Admin_Login> createState() => _Admin_LoginState();
}

class _Admin_LoginState extends State<Admin_Login> {

  var username = "adddsfsdfnasjng";
  var password;
  final _Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('admins').snapshots(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),),);
          }

          return Scaffold(
            body: Container(
                color: Colors.white70,
                child: SingleChildScrollView(
                  child: Form(
                    key: _Formkey,
                    child: Column(
                      children: [
                        //logo
                        Center(
                          child: Container(
                            child: Center(
                              child: Image.asset("assets/logo2.png"),
                            ),
                          ),
                        ),

                        //username text field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0 , vertical: 30),
                          child: TextFormField(
                            validator: (val){
                              if(val == null || val.isEmpty  ){
                                return "REQUIRED";
                              }
                            },
                            onChanged: (val){
                              username = val.toString();
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                                hintText: "User-Name"
                            ),
                          ),
                        ),

                        //password text field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: TextFormField(
                            obscureText: true,
                            validator: (val){
                              if(val == null || val.isEmpty  ){
                                return "REQUIRED";
                              }
                            },
                            onChanged: (val){
                              password = val.toString();
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                              hintText: "Password",
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        //button
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () async {
                              if(_Formkey.currentState!.validate()){
                                DocumentSnapshot data = await FirebaseFirestore.instance.collection('admins').doc(username.toString().toUpperCase()).get();
                                if(data.exists){
                                  await FirebaseFirestore.instance.collection('admins').doc(username.toString().toUpperCase()).get()
                                      .then((value)async{
                                    if(value.data()!['password'].toString() == password.toString()) {
                                      await Auth().signInwithG(password.toString());
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_Page()));
                                    }else{
                                      Fluttertoast.showToast(
                                          msg: "Wrong USERNAME or PASSWORD",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0
                                      );
                                    }
                                  });
                                }else{
                                  Fluttertoast.showToast(
                                      msg: "Wrong USERNAME or PASSWORD",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0
                                  );
                                }
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black54,
                                          offset: Offset(0,0),
                                          blurRadius: 10
                                      )
                                    ]
                                ),
                                height: 60,
                                width: 200,
                                child:const Center(
                                  child: Text(
                                    "Log-In",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white
                                    ),
                                  ),
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
            ),
          );
        });
  }
}
