import 'answer.dart';

class AnswersResponse {
  List<Answer> items;

  AnswersResponse.fromJsonMap(Map<String, dynamic> map)
      : items =
            List<Answer>.from(map["items"].map((it) => Answer.fromJsonMap(it)));
}
