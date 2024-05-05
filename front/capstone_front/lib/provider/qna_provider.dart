import 'package:capstone_front/models/qna_post_model.dart';
import 'package:flutter/foundation.dart';

class QnaProvider with ChangeNotifier {
  List<QnaPostModel> _questions = [];

  List<QnaPostModel> get questions => _questions;

  void addQuestion(QnaPostModel question) {
    _questions.insert(0, question);
    notifyListeners();
  }

  // Example function to load questions from a server
  Future<void> fetchQuestions() async {
    // Simulate fetching data from a server
    _questions = []; // Replace with actual data fetch
    notifyListeners();
  }
}
