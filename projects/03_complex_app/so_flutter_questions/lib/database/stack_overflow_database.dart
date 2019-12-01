import 'package:moor_flutter/moor_flutter.dart';

part 'stack_overflow_database.g.dart';

@DataClassName("MoorQuestion")
class Questions extends Table {
  IntColumn get questionId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  TextColumn get ownerDisplayName => text()();

  IntColumn get answerCount => integer()();

  @override
  Set<Column> get primaryKey => {questionId};
}

@DataClassName("MoorAnswer")
class Answers extends Table {
  IntColumn get answerId => integer()();

  IntColumn get questionId => integer()();

  TextColumn get body => text()();

  BoolColumn get isAccepted => boolean()();

  @override
  Set<Column> get primaryKey => {answerId};
}

@UseMoor(tables: [Questions, Answers], daos: [StackOverflowDao])
class StackOverflowDatabase extends _$StackOverflowDatabase {
  StackOverflowDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: "soquestions.db"));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Questions, Answers])
class StackOverflowDao extends DatabaseAccessor<StackOverflowDatabase>
    with _$StackOverflowDaoMixin {
  final StackOverflowDatabase db;

  StackOverflowDao(this.db) : super(db);

  Future<List<MoorQuestion>> getAllQuestions() => select(questions).get();

  Future insertQuestions(List<MoorQuestion> newQuestions) =>
      into(questions).insertAll(newQuestions, orReplace: true);

  Future insertAnswers(List<MoorAnswer> newQuestions) =>
      into(answers).insertAll(newQuestions, orReplace: true);

  Future<List<MoorAnswer>> getAnswersForQuestion(int questionId) {
    return (select(answers)
          ..where((a) => answers.questionId.equals(questionId)))
        .get();
  }
}
