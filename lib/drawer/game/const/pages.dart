
import 'package:flutter/material.dart';

Widget pageRow(username) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        const Text("Join OUR Telegram Channel"),
        Text(
            username,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        )
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
