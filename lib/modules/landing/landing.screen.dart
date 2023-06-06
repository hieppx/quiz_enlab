import 'package:flutter/material.dart';
import 'package:quiz_enlab/modules/quiz/screen/quiz.screen.dart';
import 'package:quiz_enlab/utils/values/app.colors.dart';
import 'package:quiz_enlab/utils/values/app.images.dart';
import 'package:quiz_enlab/utils/widgets/app.button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.robotImg, height: 200, width: 200),
            AppButton(
              onPressed: () {
                onPress(context);
              },
              label: 'Start Quiz!',
              width: width * 0.35,
            )
          ],
        ),
      ),
    );
  }

  onPress(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
