import 'question.dart';

class QuestionsResponse {
  final List<Question> items;

  QuestionsResponse.fromJsonMap(Map<String, dynamic> map)
      : items =
            List<Question>.from(map["items"].map((it) => Question.fromJsonMap(it)));

}
