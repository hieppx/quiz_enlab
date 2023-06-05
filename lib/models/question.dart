class Question {
  String question;
  String correctAnswer;
  List<dynamic> incorrectAnswers;

  Question(
      {required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  List<String> getListAnswer() {
    List<String> randomList = incorrectAnswers.map((e) => e as String).toList();
    randomList.add(correctAnswer);
    randomList.shuffle();
    return randomList;
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        question: json['question'],
        correctAnswer: json['correct_answer'],
        incorrectAnswers: json['incorrect_answers']);
  }
}
