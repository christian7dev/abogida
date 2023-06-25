
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  //

  signInwithG(pass) async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

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
