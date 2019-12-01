import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:so_flutter_questions/model/question.dart';
import 'package:so_flutter_questions/ui/details/question_details_screen.dart';
import 'package:so_flutter_questions/ui/widgets.dart';

import 'list_bloc.dart';

class StackOverflowQuestionsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QuestionListState();
}

class _QuestionListState extends State<StackOverflowQuestionsList> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuestionListBloc>(context).add(FetchQuestions());

    return Scaffold(
        appBar: AppBar(
          title: Text("Stack Overflow Flutter Questions"),
        ),
        body: RefreshIndicator(
          child: BlocListener<QuestionListBloc, QuestionsScreenState>(
            listener: (context, state) {
              if (state is Content) {
                _refreshCompleter?.complete();
                _refreshCompleter = Completer();
              }
            },
            child: BlocBuilder<QuestionListBloc, QuestionsScreenState>(
                builder: (context, state) {
              switch (state.runtimeType) {
                case Loading:
                  return _buildLoading();
                case Content:
                  return _buildContent(context, (state as Content).questions);
                case Empty:
                  return EmptyView(
                    retryAction: () =>
                        BlocProvider.of<QuestionListBloc>(context)
                            .add(FetchQuestions()),
                  );
                default:
                  return ErrorView(
                      retryAction: () =>
                          BlocProvider.of<QuestionListBloc>(context)
                              .add(FetchQuestions()));
                  break;
              }
            }),
          ),
          onRefresh: () {
            BlocProvider.of<QuestionListBloc>(context).add(RefreshQuestions());
            return _refreshCompleter.future;
          },
        ));
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(BuildContext context, List<DomainQuestion> questions) {
    final htmlUnescape = HtmlUnescape();

    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, position) {
        final question = questions[position];

        return Card(
          child: ListTile(
            leading: Visibility(
              visible: question.answerCount > 0,
              child: Text(
                question.answerCount.toString(),
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ),
            title: Text(htmlUnescape.convert(question.title)),
            subtitle: Text(htmlUnescape.convert(question.ownerDisplayName)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      QuestionDetailsScreen(question: question),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
