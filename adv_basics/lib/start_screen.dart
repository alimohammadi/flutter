import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});

  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: 0.60,
          //   child: Image.asset(
          //     "assets/images/quiz-logo.png",
          //     width: 300,
          //   ),
          // ),
          Image.asset(
            "assets/images/quiz-logo.png",
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          SizedBox(
            height: 80,
          ),
          const Text(
            "Learn Flutter the fun way",
            style: TextStyle(
              fontSize: 24,
              color: Color.fromARGB(255, 223, 174, 235),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            label: Text("Start Quiz"),
            icon: Icon(
              Icons.arrow_right_alt,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
