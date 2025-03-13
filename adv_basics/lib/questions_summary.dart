import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary({super.key, required this.summaryData});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map(
            (data) {
              final bool isAnswerCorrect = (data['correct_answer'] as String) ==
                  (data['user_answer'] as String);

              return Container(
                padding: EdgeInsets.only(bottom: 22),
                child: Row(
                  spacing: 12,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isAnswerCorrect ? Colors.green : Colors.red,
                        shape: BoxShape.circle, // Makes it fully rounded
                      ),
                      child: Text(
                        style: TextStyle(fontWeight: FontWeight.bold),
                        ((data['question_index'] as int) + 1).toString(),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            style: TextStyle(
                              color: const Color.fromARGB(255, 218, 211, 211),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.left,
                            data['question'] as String,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            style: TextStyle(
                              color: const Color.fromARGB(255, 144, 103, 60),
                            ),
                            textAlign: TextAlign.left,
                            data['user_answer'] as String,
                          ),
                          Text(
                            style: TextStyle(
                              color: const Color.fromARGB(255, 43, 119, 72),
                            ),
                            textAlign: TextAlign.left,
                            data['correct_answer'] as String,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
