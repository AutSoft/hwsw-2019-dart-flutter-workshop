import 'owner.dart';

class Question {

  final List<String> tags;
  final Owner owner;
  final bool isAnswered;
  final int viewCount;
  final int answerCount;
  final int score;
  final int lastActivityDate;
  final int creationDate;
  final int questionId;
  final String link;
  final String title;
  final String body;

	Question.fromJsonMap(Map<String, dynamic> map):
		tags = List<String>.from(map["tags"]),
		owner = Owner.fromJsonMap(map["owner"]),
		isAnswered = map["is_answered"],
		viewCount = map["view_count"],
		answerCount = map["answer_count"],
		score = map["score"],
		lastActivityDate = map["last_activity_date"],
		creationDate = map["creation_date"],
		questionId = map["question_id"],
		link = map["link"],
		title = map["title"],
		body = map["body"];

  Map<String, dynamic> toDbMap() {
    return {
      "questionId" : questionId,
      "title" : title,
      "body" : body
    };
  }

}
