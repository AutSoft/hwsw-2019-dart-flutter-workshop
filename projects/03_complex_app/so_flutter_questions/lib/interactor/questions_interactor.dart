import 'package:so_flutter_questions/database/disk_data_source.dart';
import 'package:so_flutter_questions/model/answer.dart';
import 'package:so_flutter_questions/model/question.dart';
import 'package:so_flutter_questions/network/network_data_source.dart';

final questionsInteractor = QuestionsInteractor._();

class QuestionsInteractor {
  final NetworkDataSource networkSource;
  final DiskDataSource diskSource;

  QuestionsInteractor._()
      : networkSource = networkDataSource,
        diskSource = diskDataSource;

  Future<List<DomainQuestion>> getQuestions() async {
    try {
      final questions = await networkDataSource.getQuestions();
      await diskDataSource.insertQuestions(questions);

      return questions;
    } catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
      return diskDataSource.getQuestions();
    }
  }

  Future<List<DomainAnswer>> getAnswersForQuestion(int questionId) async {
    try {
      final answers =
          await networkDataSource.getAnswersForQuestion(questionId: questionId);
      await diskDataSource.insertAnswers(answers);

      return answers;
    } catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
      return diskDataSource.getAnswersForQuestion(questionId);
    }
  }
}
