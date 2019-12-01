import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:so_flutter_questions/model/answer.dart';
import 'package:so_flutter_questions/model/question.dart';
import 'package:so_flutter_questions/network/api/stack_overflow_api.dart';

final networkDataSource = NetworkDataSource._();

class NetworkDataSource {
  StackOverflowApi soApi;

  NetworkDataSource._() : soApi = stackOverflowApi;

  Future<List<DomainQuestion>> getQuestions() async {
    final result = await soApi.getQuestions();

    return result.items
        .map(
          (question) => DomainQuestion(
            questionId: question.questionId,
            title: question.title,
            body: question.body,
            ownerDisplayName: question.owner.displayName,
            answerCount: question.answerCount,
          ),
        )
        .toList();
  }

  Future<List<DomainAnswer>> getAnswersForQuestion(
      {@required int questionId}) async {
    final result = await soApi.getAnswersForQuestion(questionId: questionId);

    return result.items
        .map((answer) => DomainAnswer(
              answerId: answer.answerId,
              questionId: answer.questionId,
              isAccepted: answer.isAccepted,
              body: answer.body,
            ))
        .toList();
  }
}
