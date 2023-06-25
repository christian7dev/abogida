import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dep_Page extends StatefulWidget {
  const Dep_Page({Key? key}) : super(key: key);

  @override
  State<Dep_Page> createState() => _Dep_PageState();
}

class _Dep_PageState extends State<Dep_Page> {

  Future uploadFile() async {
      await FirebaseFirestore.instance.collection('class').doc().set({
        'class_name' : _CNC.text,
        'class_description' : _CDC.text,
        'time' : Timestamp.now(),
        'by' : FirebaseAuth.instance.currentUser!.email.toString(),
      });
    }


  final _formKey = GlobalKey<FormState>();
  final _CNC = TextEditingController();
  final _CDC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //===================================================================================

      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.black),
        title:const Text(
          "Create Class",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
        //===================================================================================


      body: Form(
        key:  _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [

              const SizedBox(
                height: 20,
              ),

              // class name input field
              Padding(
                padding: const EdgeInsets.only(top: 50 , right: 10 , left: 10),
                child: TextFormField(
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "REQUIRED";
                    }
                  },
                  controller: _CNC,
                  decoration: InputDecoration(
                    hintText: "CLASS NAME",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),

              //===================================================================================

              //class description input field
              Padding(
                padding: const EdgeInsets.only(top: 20 , right: 10 , left: 10),
                child: TextFormField(
                  controller: _CDC,
                  validator: (val){
                    if( val == null || val.isEmpty){
                      return "REQUIRED";
                    }
                  },
                  maxLines: 3,
                  decoration:  InputDecoration(
                    hintText: "CLASS DESCRIPTION",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
              ),
              //===================================================================================


              const SizedBox(
                height: 40,
              ),

              //===================================================================================

              //class create button
              GestureDetector(
                onTap: (){
                  if(_formKey.currentState!.validate()){
                    uploadFile();
                    return Navigator.of(context).pop();
                  }
                },
                child: Container(
                  height: 60,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0,1),
                          blurRadius: 10,
                        )
                      ]
                  ),
                  child:const Center(
                    child: Text(
                      "CREATE CLASS",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                    ),
                  ),
                ),
              ),

              //===================================================================================

              const SizedBox(
                height: 20,
              ),

            ],
          ),
        ),
      )
    );
  }
}
