import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_enlab/modules/landing/landing.screen.dart';
import 'package:quiz_enlab/modules/quiz/provider/question.provider.dart';
import 'package:quiz_enlab/modules/quiz/widget/question.item.dart';
import 'package:quiz_enlab/modules/result/screen/result.screen.dart';

import '../../../utils/values/app.colors.dart';
import '../../../utils/widgets/app.button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuestionProvider _provider = QuestionProvider();

  @override
  void initState() {
    _provider.getQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (_) => _provider,
      builder: (context, child) {
        return Consumer<QuestionProvider>(builder: (context, model, child) {
          Future.delayed(Duration.zero, () {
            if (_provider.isDone == true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ResultScreen(
                            score: model.score,
                            lenghtQuestions: model.questions.length,
                            seconds: model.seconds,
                          )));
            }
          });
          return Scaffold(
              backgroundColor: AppColors.primaryColor,
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: onBack,
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.whiteColor,
                        size: 30,
                      ))
                ],
              ),
              body: model.questions.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            _buildHeader(model),
                            const SizedBox(
                              height: 20,
                            ),
                            _buildQuestion(model, height),
                            AppButton(
                              onPressed: model.nextPage,
                              label: 'Next',
                              width: width * 0.7,
                              isActive: model.isAnswered,
                            )
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ));
        });
      },
    );
  }

  Widget _buildHeader(QuestionProvider model) {
    return RichText(
      text: TextSpan(
        text: 'Question ${model.questionNumber}',
        style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 28,
            fontWeight: FontWeight.bold),
        children: <TextSpan>[
          TextSpan(
              text: '/${model.questions.length}',
              style:
                  const TextStyle(fontWeight: FontWeight.normal, fontSize: 22)),
        ],
      ),
    );
  }

  Widget _buildQuestion(QuestionProvider model, double height) {
    return SizedBox(
      height: height * 0.7,
      child: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          controller: model.pageController,
          onPageChanged: model.getPage,
          itemCount: model.questions.length,
          itemBuilder: (context, index) => QuestionItem(
                index: index,
                model: model,
              )),
    );
  }

  onBack() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
