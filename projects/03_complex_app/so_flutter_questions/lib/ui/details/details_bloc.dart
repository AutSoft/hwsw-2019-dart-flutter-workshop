import 'package:bloc/bloc.dart';
import 'package:so_flutter_questions/interactor/questions_interactor.dart';
import 'package:so_flutter_questions/model/answer.dart';

class DetailsScreenEvent {}

class FetchQuestionDetails extends DetailsScreenEvent {
  final int questionId;

  FetchQuestionDetails(this.questionId);
}

class DetailsScreenState {}

class Loading extends DetailsScreenState {}

class Error extends DetailsScreenState {}

class Empty extends DetailsScreenState {}

class Content extends DetailsScreenState {
  final List<DomainAnswer> answers;

  Content(this.answers);
}

class QuestionDetailsBloc extends Bloc<DetailsScreenEvent, DetailsScreenState> {
  QuestionsInteractor interactor;

  QuestionDetailsBloc(this.interactor);

  @override
  DetailsScreenState get initialState => Loading();

  @override
  Stream<DetailsScreenState> mapEventToState(DetailsScreenEvent event) async* {
    switch (event.runtimeType) {
      case FetchQuestionDetails:
        yield Loading();
        try {
          final id = (event as FetchQuestionDetails).questionId;
          final answers = await interactor.getAnswersForQuestion(id);
          if (answers.isEmpty) {
            yield Empty();
          } else {
            yield Content(answers);
          }
        } catch (exception, stacktrace) {
          print(exception);
          print(stacktrace);
          yield Error();
        }
        break;
    }
  }
}
