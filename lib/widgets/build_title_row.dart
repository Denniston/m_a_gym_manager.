import 'package:flutter/material.dart';

Widget buildTitleRow(String title, int number) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      RichText(
        text: TextSpan(
            text: title,
            style: const TextStyle(
                fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "($number)",
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal),
              ),
            ]),
      ),
      const Text(
        "See all",
        style: TextStyle(
            fontSize: 12,
            color: Color(0XFF3E3993),
            fontWeight: FontWeight.bold),
      )
    ],
  );
}
