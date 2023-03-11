import 'package:flutter/material.dart';

Widget pageRow() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: const Image(
            image: AssetImage("assets/telegram.png"),
            height: 30,
            width: 30,
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Text("Join Telegram Channel"),
        ),
      ],
    ),
  );
}

Widget sBanner(link) {
  return SizedBox(
    height: 200,
    width: 300,
    child: Image.network(link),
  );
}
