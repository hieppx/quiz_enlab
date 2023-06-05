import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz_enlab/models/question.dart';

class QuestionService {
  Future<List<Question>> getQuestions() async {
    var url = Uri.parse('https://opentdb.com/api.php?amount=5');
    var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['results'];
      return body.map((e) => Question.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }
}
