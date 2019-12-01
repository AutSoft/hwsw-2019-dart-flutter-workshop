import 'owner.dart';

class Answer {
  Owner owner;
  bool isAccepted;
  int score;
  int lastActivityDate;
  int creationDate;
  int answerId;
  int questionId;
  String body;

  Answer.fromJsonMap(Map<String, dynamic> map)
      : owner = Owner.fromJsonMap(map["owner"]),
        isAccepted = map["is_accepted"],
        score = map["score"],
        lastActivityDate = map["last_activity_date"],
        creationDate = map["creation_date"],
        answerId = map["answer_id"],
        questionId = map["question_id"],
        body = map["body"];
}
