import 'package:abogida/entry.dart';
import 'package:abogida/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  check(){
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return const App();
        }else{
          return const Login();
        }
      },
    );
  }


  signInwithG() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    final userInfo = FirebaseAuth.instance.currentUser;
    final create = FirebaseFirestore.instance.collection("users");


    await create.doc(userInfo!.uid).set({
      'name' : userInfo.displayName.toString(),
      'email' : userInfo.email,
      'phone' : userInfo.phoneNumber.toString(),
      'photo' : userInfo.photoURL,

    });
  }



  Future<void> signOut() async {
    if(GoogleSignIn().currentUser != null){
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
    }
    else{
      FirebaseAuth.instance.signOut();
    }
  }
}
