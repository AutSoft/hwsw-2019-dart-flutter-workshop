// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stack_overflow_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MoorQuestion extends DataClass implements Insertable<MoorQuestion> {
  final int questionId;
  final String title;
  final String body;
  final String ownerDisplayName;
  final int answerCount;
  MoorQuestion(
      {@required this.questionId,
      @required this.title,
      @required this.body,
      @required this.ownerDisplayName,
      @required this.answerCount});
  factory MoorQuestion.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return MoorQuestion(
      questionId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}question_id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
      ownerDisplayName: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}owner_display_name']),
      answerCount: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}answer_count']),
    );
  }
  factory MoorQuestion.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return MoorQuestion(
      questionId: serializer.fromJson<int>(json['questionId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      ownerDisplayName: serializer.fromJson<String>(json['ownerDisplayName']),
      answerCount: serializer.fromJson<int>(json['answerCount']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'questionId': serializer.toJson<int>(questionId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'ownerDisplayName': serializer.toJson<String>(ownerDisplayName),
      'answerCount': serializer.toJson<int>(answerCount),
    };
  }

  @override
  QuestionsCompanion createCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      questionId: questionId == null && nullToAbsent
          ? const Value.absent()
          : Value(questionId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      ownerDisplayName: ownerDisplayName == null && nullToAbsent
          ? const Value.absent()
          : Value(ownerDisplayName),
      answerCount: answerCount == null && nullToAbsent
          ? const Value.absent()
          : Value(answerCount),
    );
  }

  MoorQuestion copyWith(
          {int questionId,
          String title,
          String body,
          String ownerDisplayName,
          int answerCount}) =>
      MoorQuestion(
        questionId: questionId ?? this.questionId,
        title: title ?? this.title,
        body: body ?? this.body,
        ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
        answerCount: answerCount ?? this.answerCount,
      );
  @override
  String toString() {
    return (StringBuffer('MoorQuestion(')
          ..write('questionId: $questionId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('ownerDisplayName: $ownerDisplayName, ')
          ..write('answerCount: $answerCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      questionId.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(body.hashCode,
              $mrjc(ownerDisplayName.hashCode, answerCount.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is MoorQuestion &&
          other.questionId == this.questionId &&
          other.title == this.title &&
          other.body == this.body &&
          other.ownerDisplayName == this.ownerDisplayName &&
          other.answerCount == this.answerCount);
}

class QuestionsCompanion extends UpdateCompanion<MoorQuestion> {
  final Value<int> questionId;
  final Value<String> title;
  final Value<String> body;
  final Value<String> ownerDisplayName;
  final Value<int> answerCount;
  const QuestionsCompanion({
    this.questionId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.ownerDisplayName = const Value.absent(),
    this.answerCount = const Value.absent(),
  });
  QuestionsCompanion.insert({
    @required int questionId,
    @required String title,
    @required String body,
    @required String ownerDisplayName,
    @required int answerCount,
  })  : questionId = Value(questionId),
        title = Value(title),
        body = Value(body),
        ownerDisplayName = Value(ownerDisplayName),
        answerCount = Value(answerCount);
  QuestionsCompanion copyWith(
      {Value<int> questionId,
      Value<String> title,
      Value<String> body,
      Value<String> ownerDisplayName,
      Value<int> answerCount}) {
    return QuestionsCompanion(
      questionId: questionId ?? this.questionId,
      title: title ?? this.title,
      body: body ?? this.body,
      ownerDisplayName: ownerDisplayName ?? this.ownerDisplayName,
      answerCount: answerCount ?? this.answerCount,
    );
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, MoorQuestion> {
  final GeneratedDatabase _db;
  final String _alias;
  $QuestionsTable(this._db, [this._alias]);
  final VerificationMeta _questionIdMeta = const VerificationMeta('questionId');
  GeneratedIntColumn _questionId;
  @override
  GeneratedIntColumn get questionId => _questionId ??= _constructQuestionId();
  GeneratedIntColumn _constructQuestionId() {
    return GeneratedIntColumn(
      'question_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ownerDisplayNameMeta =
      const VerificationMeta('ownerDisplayName');
  GeneratedTextColumn _ownerDisplayName;
  @override
  GeneratedTextColumn get ownerDisplayName =>
      _ownerDisplayName ??= _constructOwnerDisplayName();
  GeneratedTextColumn _constructOwnerDisplayName() {
    return GeneratedTextColumn(
      'owner_display_name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _answerCountMeta =
      const VerificationMeta('answerCount');
  GeneratedIntColumn _answerCount;
  @override
  GeneratedIntColumn get answerCount =>
      _answerCount ??= _constructAnswerCount();
  GeneratedIntColumn _constructAnswerCount() {
    return GeneratedIntColumn(
      'answer_count',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [questionId, title, body, ownerDisplayName, answerCount];
  @override
  $QuestionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'questions';
  @override
  final String actualTableName = 'questions';
  @override
  VerificationContext validateIntegrity(QuestionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.questionId.present) {
      context.handle(_questionIdMeta,
          questionId.isAcceptableValue(d.questionId.value, _questionIdMeta));
    } else if (questionId.isRequired && isInserting) {
      context.missing(_questionIdMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.body.present) {
      context.handle(
          _bodyMeta, body.isAcceptableValue(d.body.value, _bodyMeta));
    } else if (body.isRequired && isInserting) {
      context.missing(_bodyMeta);
    }
    if (d.ownerDisplayName.present) {
      context.handle(
          _ownerDisplayNameMeta,
          ownerDisplayName.isAcceptableValue(
              d.ownerDisplayName.value, _ownerDisplayNameMeta));
    } else if (ownerDisplayName.isRequired && isInserting) {
      context.missing(_ownerDisplayNameMeta);
    }
    if (d.answerCount.present) {
      context.handle(_answerCountMeta,
          answerCount.isAcceptableValue(d.answerCount.value, _answerCountMeta));
    } else if (answerCount.isRequired && isInserting) {
      context.missing(_answerCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionId};
  @override
  MoorQuestion map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorQuestion.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(QuestionsCompanion d) {
    final map = <String, Variable>{};
    if (d.questionId.present) {
      map['question_id'] = Variable<int, IntType>(d.questionId.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.body.present) {
      map['body'] = Variable<String, StringType>(d.body.value);
    }
    if (d.ownerDisplayName.present) {
      map['owner_display_name'] =
          Variable<String, StringType>(d.ownerDisplayName.value);
    }
    if (d.answerCount.present) {
      map['answer_count'] = Variable<int, IntType>(d.answerCount.value);
    }
    return map;
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(_db, alias);
  }
}

class MoorAnswer extends DataClass implements Insertable<MoorAnswer> {
  final int answerId;
  final int questionId;
  final String body;
  final bool isAccepted;
  MoorAnswer(
      {@required this.answerId,
      @required this.questionId,
      @required this.body,
      @required this.isAccepted});
  factory MoorAnswer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return MoorAnswer(
      answerId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}answer_id']),
      questionId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}question_id']),
      body: stringType.mapFromDatabaseResponse(data['${effectivePrefix}body']),
      isAccepted: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_accepted']),
    );
  }
  factory MoorAnswer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return MoorAnswer(
      answerId: serializer.fromJson<int>(json['answerId']),
      questionId: serializer.fromJson<int>(json['questionId']),
      body: serializer.fromJson<String>(json['body']),
      isAccepted: serializer.fromJson<bool>(json['isAccepted']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'answerId': serializer.toJson<int>(answerId),
      'questionId': serializer.toJson<int>(questionId),
      'body': serializer.toJson<String>(body),
      'isAccepted': serializer.toJson<bool>(isAccepted),
    };
  }

  @override
  AnswersCompanion createCompanion(bool nullToAbsent) {
    return AnswersCompanion(
      answerId: answerId == null && nullToAbsent
          ? const Value.absent()
          : Value(answerId),
      questionId: questionId == null && nullToAbsent
          ? const Value.absent()
          : Value(questionId),
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      isAccepted: isAccepted == null && nullToAbsent
          ? const Value.absent()
          : Value(isAccepted),
    );
  }

  MoorAnswer copyWith(
          {int answerId, int questionId, String body, bool isAccepted}) =>
      MoorAnswer(
        answerId: answerId ?? this.answerId,
        questionId: questionId ?? this.questionId,
        body: body ?? this.body,
        isAccepted: isAccepted ?? this.isAccepted,
      );
  @override
  String toString() {
    return (StringBuffer('MoorAnswer(')
          ..write('answerId: $answerId, ')
          ..write('questionId: $questionId, ')
          ..write('body: $body, ')
          ..write('isAccepted: $isAccepted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(answerId.hashCode,
      $mrjc(questionId.hashCode, $mrjc(body.hashCode, isAccepted.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is MoorAnswer &&
          other.answerId == this.answerId &&
          other.questionId == this.questionId &&
          other.body == this.body &&
          other.isAccepted == this.isAccepted);
}

class AnswersCompanion extends UpdateCompanion<MoorAnswer> {
  final Value<int> answerId;
  final Value<int> questionId;
  final Value<String> body;
  final Value<bool> isAccepted;
  const AnswersCompanion({
    this.answerId = const Value.absent(),
    this.questionId = const Value.absent(),
    this.body = const Value.absent(),
    this.isAccepted = const Value.absent(),
  });
  AnswersCompanion.insert({
    @required int answerId,
    @required int questionId,
    @required String body,
    @required bool isAccepted,
  })  : answerId = Value(answerId),
        questionId = Value(questionId),
        body = Value(body),
        isAccepted = Value(isAccepted);
  AnswersCompanion copyWith(
      {Value<int> answerId,
      Value<int> questionId,
      Value<String> body,
      Value<bool> isAccepted}) {
    return AnswersCompanion(
      answerId: answerId ?? this.answerId,
      questionId: questionId ?? this.questionId,
      body: body ?? this.body,
      isAccepted: isAccepted ?? this.isAccepted,
    );
  }
}

class $AnswersTable extends Answers with TableInfo<$AnswersTable, MoorAnswer> {
  final GeneratedDatabase _db;
  final String _alias;
  $AnswersTable(this._db, [this._alias]);
  final VerificationMeta _answerIdMeta = const VerificationMeta('answerId');
  GeneratedIntColumn _answerId;
  @override
  GeneratedIntColumn get answerId => _answerId ??= _constructAnswerId();
  GeneratedIntColumn _constructAnswerId() {
    return GeneratedIntColumn(
      'answer_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _questionIdMeta = const VerificationMeta('questionId');
  GeneratedIntColumn _questionId;
  @override
  GeneratedIntColumn get questionId => _questionId ??= _constructQuestionId();
  GeneratedIntColumn _constructQuestionId() {
    return GeneratedIntColumn(
      'question_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _bodyMeta = const VerificationMeta('body');
  GeneratedTextColumn _body;
  @override
  GeneratedTextColumn get body => _body ??= _constructBody();
  GeneratedTextColumn _constructBody() {
    return GeneratedTextColumn(
      'body',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isAcceptedMeta = const VerificationMeta('isAccepted');
  GeneratedBoolColumn _isAccepted;
  @override
  GeneratedBoolColumn get isAccepted => _isAccepted ??= _constructIsAccepted();
  GeneratedBoolColumn _constructIsAccepted() {
    return GeneratedBoolColumn(
      'is_accepted',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [answerId, questionId, body, isAccepted];
  @override
  $AnswersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'answers';
  @override
  final String actualTableName = 'answers';
  @override
  VerificationContext validateIntegrity(AnswersCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.answerId.present) {
      context.handle(_answerIdMeta,
          answerId.isAcceptableValue(d.answerId.value, _answerIdMeta));
    } else if (answerId.isRequired && isInserting) {
      context.missing(_answerIdMeta);
    }
    if (d.questionId.present) {
      context.handle(_questionIdMeta,
          questionId.isAcceptableValue(d.questionId.value, _questionIdMeta));
    } else if (questionId.isRequired && isInserting) {
      context.missing(_questionIdMeta);
    }
    if (d.body.present) {
      context.handle(
          _bodyMeta, body.isAcceptableValue(d.body.value, _bodyMeta));
    } else if (body.isRequired && isInserting) {
      context.missing(_bodyMeta);
    }
    if (d.isAccepted.present) {
      context.handle(_isAcceptedMeta,
          isAccepted.isAcceptableValue(d.isAccepted.value, _isAcceptedMeta));
    } else if (isAccepted.isRequired && isInserting) {
      context.missing(_isAcceptedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {answerId};
  @override
  MoorAnswer map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MoorAnswer.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AnswersCompanion d) {
    final map = <String, Variable>{};
    if (d.answerId.present) {
      map['answer_id'] = Variable<int, IntType>(d.answerId.value);
    }
    if (d.questionId.present) {
      map['question_id'] = Variable<int, IntType>(d.questionId.value);
    }
    if (d.body.present) {
      map['body'] = Variable<String, StringType>(d.body.value);
    }
    if (d.isAccepted.present) {
      map['is_accepted'] = Variable<bool, BoolType>(d.isAccepted.value);
    }
    return map;
  }

  @override
  $AnswersTable createAlias(String alias) {
    return $AnswersTable(_db, alias);
  }
}

abstract class _$StackOverflowDatabase extends GeneratedDatabase {
  _$StackOverflowDatabase(QueryExecutor e)
      : super(SqlTypeSystem.defaultInstance, e);
  $QuestionsTable _questions;
  $QuestionsTable get questions => _questions ??= $QuestionsTable(this);
  $AnswersTable _answers;
  $AnswersTable get answers => _answers ??= $AnswersTable(this);
  StackOverflowDao _stackOverflowDao;
  StackOverflowDao get stackOverflowDao =>
      _stackOverflowDao ??= StackOverflowDao(this as StackOverflowDatabase);
  @override
  List<TableInfo> get allTables => [questions, answers];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$StackOverflowDaoMixin on DatabaseAccessor<StackOverflowDatabase> {
  $QuestionsTable get questions => db.questions;
  $AnswersTable get answers => db.answers;
}
