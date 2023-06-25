import 'package:abogida/auth_service.dart';
import 'package:abogida/home_page.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white70,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 70,
            ),
            Center(
              child: Center(
                child: Image.asset("assets/logo2.png"),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () async {
                  await Auth().signInwithG();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const App()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                          child: Image.asset("assets/img.png")
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                          "Continue with GOOGLE",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Text(
                "V 1.0",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        )
      ),
    );
  }
}
