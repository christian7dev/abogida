import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ClassPostPage extends StatefulWidget {
  final id;
  const ClassPostPage({Key? key , this.id}) : super(key: key);

  @override
  State<ClassPostPage> createState() => _ClassPostPageState();
}



class _ClassPostPageState extends State<ClassPostPage> {





  final _formKey = GlobalKey<FormState>();
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final id = widget.id;
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
                    hintText: "DESCRIPTION .........",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 15,
                ),
              ),
            ),


            const SizedBox(
              height: 5,
            ),

            GestureDetector(
              onTap: () async {
                if(_formKey.currentState!.validate()){
                    await FirebaseFirestore.instance.collection('class').doc(id).collection('post').doc().set({
                      'by' : FirebaseAuth.instance.currentUser!.email.toString(),
                      'message' : _text.text,
                      'time' : Timestamp.now()
                    }).then((value) => Navigator.pop(context));
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
