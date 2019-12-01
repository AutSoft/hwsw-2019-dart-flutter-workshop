import 'package:bloc/bloc.dart';
import 'package:so_flutter_questions/interactor/questions_interactor.dart';
import 'package:so_flutter_questions/model/question.dart';

class QuestionsScreenEvent {}

class FetchQuestions extends QuestionsScreenEvent {}

class RefreshQuestions extends QuestionsScreenEvent {}

class QuestionsScreenState {}

class Loading extends QuestionsScreenState {}

class Error extends QuestionsScreenState {}

class Empty extends QuestionsScreenState {}

class Content extends QuestionsScreenState {
  final List<DomainQuestion> questions;

  Content(this.questions);
}

class QuestionListBloc
    extends Bloc<QuestionsScreenEvent, QuestionsScreenState> {
  QuestionsInteractor interactor;

  QuestionListBloc(this.interactor);

  @override
  QuestionsScreenState get initialState => Loading();

  @override
  Stream<QuestionsScreenState> mapEventToState(
      QuestionsScreenEvent event) async* {
    switch (event.runtimeType) {
      case FetchQuestions:
        yield Loading();
        try {
          final questions = await interactor.getQuestions();
          if(questions.isEmpty){
            yield Empty();
          }else{
            yield Content(questions);
          }
        } catch (exception, stacktrace) {
          print(exception);
          print(stacktrace);
          yield Error();
        }
        break;
      case RefreshQuestions:
        try {
          final questions = await interactor.getQuestions();
          yield Content(questions);
        } catch (exception, stacktrace) {
          print(exception);
          print(stacktrace);
          yield state;
        }
        break;
    }
  }
}
