import 'dart:async';

import 'package:so_flutter_questions/database/stack_overflow_database.dart';
import 'package:so_flutter_questions/model/answer.dart';
import 'package:so_flutter_questions/model/question.dart';

final diskDataSource = DiskDataSource._();

class DiskDataSource {
  StackOverflowDao soDao;

  DiskDataSource._() : soDao = StackOverflowDao(StackOverflowDatabase());

  Future insertQuestions(List<DomainQuestion> questions) async {
    await soDao.insertQuestions(questions
        .map(
          (question) => MoorQuestion(
              questionId: question.questionId,
              title: question.title,
              body: question.body,
              ownerDisplayName: question.ownerDisplayName,
              answerCount: question.answerCount),
        )
        .toList());
  }

  Future insertAnswers(List<DomainAnswer> answers) async {
    await soDao.insertAnswers(answers
        .map(
          (answer) => MoorAnswer(
            answerId: answer.answerId,
            questionId: answer.questionId,
            isAccepted: answer.isAccepted,
            body: answer.body,
          ),
        )
        .toList());
  }

  Future<List<DomainQuestion>> getQuestions() async {
    final questions = await soDao.getAllQuestions();
    return questions
        .map(
          (question) => DomainQuestion(
            questionId: question.questionId,
            title: question.title,
            body: question.body,
            ownerDisplayName: question.ownerDisplayName,
            answerCount: question.answerCount,
          ),
        )
        .toList();
  }

  Future<List<DomainAnswer>> getAnswersForQuestion(int questionId) async {
    final answers = await soDao.getAnswersForQuestion(questionId);
    return answers
        .map(
          (answer) => DomainAnswer(
              answerId: answer.answerId,
              questionId: answer.questionId,
              isAccepted: answer.isAccepted,
              body: answer.body),
        )
        .toList();
  }
}
