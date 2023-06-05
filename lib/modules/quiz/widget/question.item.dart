import 'package:flutter/material.dart';
import 'package:quiz_enlab/modules/quiz/provider/question.provider.dart';
import '../../../utils/values/app.colors.dart';
import 'answer.item.dart';

class QuestionItem extends StatefulWidget {
  const QuestionItem({super.key, required this.index, required this.model});
  final int index;
  final QuestionProvider model;

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  late QuestionProvider _provider;
  late int _index;
  List<String> _answers = [];

  @override
  void initState() {
    _provider = widget.model;
    _index = widget.index;
    _answers = _provider.questions[_index].getListAnswer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Text(
              widget.model.questions[widget.index].question,
              style: const TextStyle(
                color: AppColors.whiteColor,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            )),
        _buildAnswers(),
      ],
    );
  }

  Widget _buildAnswers() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _answers.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (BuildContext context, int i) {
          return AnswerItem(
            onTap: () {
              !widget.model.isAnswered
                  ? widget.model.checkAns(
                      _answers[i],
                      widget.model.questions[widget.index].correctAnswer,
                    )
                  : null;
            },
            answer: _answers[i],
            model: widget.model,
          );
        });
  }
}
