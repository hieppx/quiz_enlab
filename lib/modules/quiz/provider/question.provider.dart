import 'dart:async';


import 'package:flutter/material.dart';
import 'package:quiz_enlab/models/question.dart';
import 'package:quiz_enlab/service/question.service.dart';

class QuestionProvider extends ChangeNotifier {
  final QuestionService _questionService = QuestionService();

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  final PageController _pageController = PageController(initialPage: 0);
  PageController get pageController => _pageController;

  int _pageChanged = 0;
  int get pageChanged => _pageChanged;

  int _questionNumber = 1;
  int get questionNumber => _questionNumber;

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;

  String _answerSelected = '';
  String get answerSelected => _answerSelected;

  String? _answerCorrect;
  String? get answerCorrect => _answerCorrect;

  int _score = 0;
  int get score => _score;

  bool _isDone = false;
  bool get isDone => _isDone;

  Timer? _timer;

  Duration _myDuration = const Duration();

  int _seconds = 0;
  int get seconds => _seconds;

  getQuestions() async {
    _questions = await _questionService.getQuestions();
    startTimer();
    notifyListeners();
  }

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _myDuration = Duration(seconds: _myDuration.inSeconds + 1);
    });
    notifyListeners();
  }

  stopTimer() {
    _timer!.cancel();
    notifyListeners();
  }

  getPage(int value) {
    _pageChanged = value;
    _questionNumber = value + 1;
    notifyListeners();
  }

  checkAns(String answerSelected, String correctAnswer) {
    _isAnswered = true;
    _answerSelected = answerSelected;
    _answerCorrect = correctAnswer;
    if (_answerSelected == correctAnswer) {
      _score++;
    }
    notifyListeners();
  }

  nextPage() {
    if (_isAnswered) {
      if (_questionNumber != _questions.length) {
        _isAnswered = false;
        _pageController.animateToPage(_pageChanged + 1,
            duration: const Duration(milliseconds: 250), curve: Curves.ease);
      } else {
        _isDone = true;
        _seconds = _timer!.tick;
        stopTimer();
      }
    }
    notifyListeners();
  }
}
