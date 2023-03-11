import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../const/pages.dart';

class LossPage extends StatefulWidget {
  const LossPage({Key? key}) : super(key: key);

  @override
  State<LossPage> createState() => _LossPageState();
}

class _LossPageState extends State<LossPage> {
  final db = FirebaseFirestore.instance.collection("quiz");
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: db.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final data = snapshot.data!.docs[0].data();
          return Scaffold(
              body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                ),
                const Center(
                  child: Text(
                    "SORRY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.red),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    "Try Again Another Time ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Spacer(),
                data['promo_link'].toString().isNotEmpty
                    ? sBanner(data['promo_link'].toString())
                    : Container(),
                pageRow(),
              ],
            ),
          ));
        });
  }
}
