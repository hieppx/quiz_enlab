import 'package:flutter/material.dart';
import 'package:quiz_enlab/modules/quiz/screen/quiz.screen.dart';
import 'package:quiz_enlab/utils/values/app.images.dart';
import 'package:quiz_enlab/utils/widgets/app.button.dart';

import '../../../utils/values/app.colors.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key,
      required this.score,
      required this.lenghtQuestions,
      required this.seconds,
     });
  final int score;
  final int lenghtQuestions;
  final int seconds;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(child: _contentBuild(height, context)),
      ),
    );
  }

  Widget _contentBuild(double height, BuildContext context) {
    bool isCongrat() {
      return lenghtQuestions / 2 <= score;
    }

    return Container(
      width: double.infinity,
      height: height * 0.35,
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(
              isCongrat() ? AppImages.congratImg : AppImages.againImg,
              height: 100,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              isCongrat() ? 'Congratulations!!' : 'Completed!',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              isCongrat() ? 'You are amazing!!' : 'Better luck next time!',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '$score/$lenghtQuestions correct answers in $seconds seconds',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
                onPressed: () {
                  onAgain(context);
                },
                label: 'Play Again',
                width: 150)
          ],
        ),
      ),
    );
  }

  onAgain(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
