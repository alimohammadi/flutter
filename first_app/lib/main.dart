import 'package:first_app/gradient_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan,
        // body: GradientContainer(
        //   const Color.fromARGB(255, 7, 98, 255),
        //   const Color.fromARGB(255, 132, 163, 216),
        // ),
        body: GradientContainer.purple(),
      ),
    ),
  );
}
