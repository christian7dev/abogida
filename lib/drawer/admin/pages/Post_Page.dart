
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Post_page extends StatefulWidget {
  const Post_page({Key? key}) : super(key: key);

  @override
  State<Post_page> createState() => _Post_pageState();
}



class _Post_pageState extends State<Post_page> {




  Future uploadPost() async {
      await FirebaseFirestore.instance.collection('post').doc().set({
        'message' : _text.text,
        'time' : Timestamp.now(),
        'by' : FirebaseAuth.instance.currentUser!.email.toString(),
      }).then((value) => Navigator.pop(context));
    }


  final _formKey = GlobalKey<FormState>();
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title:const Text(
          "POST",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(
              height: 20,
            ),







            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _text,
                  validator: (val){
                    if(val == null || val.isEmpty){
                      return "REQUIRED";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "ENTER TEXT .........",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 17,
                ),
              ),
            ),


           const SizedBox(
              height: 5,
            ),

            GestureDetector(
              onTap: () {
                if(_formKey.currentState!.validate()){
                  uploadPost();
                }
              },
              child: Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0,0),
                      blurRadius: 5,
                    )
                  ]
                ),
                child:const Center(
                  child: Text(
                    "POST",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                ),
              ),
            ),


            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
