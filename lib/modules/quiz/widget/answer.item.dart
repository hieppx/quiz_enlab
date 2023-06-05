import 'package:flutter/material.dart';
import 'package:quiz_enlab/modules/quiz/provider/question.provider.dart';
import 'package:quiz_enlab/utils/values/app.colors.dart';

class AnswerItem extends StatelessWidget {
  const AnswerItem(
      {super.key,
      required this.onTap,
      required this.answer,
      required this.model});

  final VoidCallback onTap;
  final String answer;
  final QuestionProvider model;

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      if (model.isAnswered) {
        if (answer == model.answerCorrect) {
          return AppColors.greenColor;
        } else if (answer == model.answerSelected &&
            model.answerSelected != model.answerCorrect) {
          return AppColors.secondaryColor;
        }
      }
      return AppColors.whiteColor;
    }

    IconData getIcon() {
      return getColor() == AppColors.secondaryColor ? Icons.close : Icons.done;
    }

    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(color: getColor(), width: 2),
              borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    answer,
                    style: TextStyle(color: getColor()),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: getColor(), width: 2),
                      borderRadius: BorderRadius.circular(50)),
                  child: getColor() == AppColors.whiteColor
                      ? null
                      : Icon(getIcon(), size: 16, color: getColor()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
