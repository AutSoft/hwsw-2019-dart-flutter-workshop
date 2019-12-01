import 'package:flutter/foundation.dart';

@immutable
class DomainQuestion {
  final int questionId;
  final String title;
  final String body;
  final String ownerDisplayName;
  final int answerCount;

  DomainQuestion(
      {this.questionId,
      this.title,
      this.body,
      this.ownerDisplayName,
      this.answerCount});
}
