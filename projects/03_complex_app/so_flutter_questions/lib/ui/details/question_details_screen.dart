import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:so_flutter_questions/model/answer.dart';
import 'package:so_flutter_questions/model/question.dart';
import 'package:so_flutter_questions/ui/widgets.dart';

import 'details_bloc.dart';

class QuestionDetailsScreen extends StatelessWidget {
  final DomainQuestion question;

  QuestionDetailsScreen({@required this.question});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuestionDetailsBloc>(context)
        .add(FetchQuestionDetails(question.questionId));

    return Scaffold(
        appBar: AppBar(
          title: Text(question.title),
        ),
        body: Column(
          children: <Widget>[
            Material(
              elevation: 2,
              child: SizedBox(
                height: 200,
                child: SingleChildScrollView(
                  child: Html(data: question.body),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            BlocBuilder<QuestionDetailsBloc, DetailsScreenState>(
                builder: (context, state) {
              switch (state.runtimeType) {
                case Loading:
                  return LoadingView();
                case Content:
                  return _buildContent(context, (state as Content).answers);
                case Empty:
                  return EmptyView(
                    retryAction: () =>
                        BlocProvider.of<QuestionDetailsBloc>(context)
                            .add(FetchQuestionDetails(question.questionId)),
                  );
                default:
                  return Container(
                    child: Expanded(
                      child: ErrorView(
                        retryAction: () =>
                            BlocProvider.of<QuestionDetailsBloc>(context)
                                .add(FetchQuestionDetails(question.questionId)),
                      ),
                    ),
                  );
                  break;
              }
            })
          ],
        ));
  }

  Widget _buildContent(BuildContext context, List<DomainAnswer> answers) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: answers.length,
          itemBuilder: (context, position) {
            final answer = answers[position];

            return Card(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 380,
                  child: ListTile(
                    title: Html(
                      data: answer.body,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
