import 'package:flutter/foundation.dart';

@immutable
class DomainAnswer {
  final int answerId;
  final int questionId;
  final bool isAccepted;
  final String body;

  DomainAnswer({this.answerId, this.questionId, this.isAccepted, this.body});
}
