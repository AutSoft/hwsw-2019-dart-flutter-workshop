import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so_flutter_questions/interactor/questions_interactor.dart';
import 'package:so_flutter_questions/ui/details/details_bloc.dart';

import 'ui/list/list_bloc.dart';
import 'ui/list/list_screen.dart';

void main() {
  final qInteractor = questionsInteractor;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<QuestionListBloc>(
          create: (context) => QuestionListBloc(qInteractor),
        ),
        BlocProvider<QuestionDetailsBloc>(
          create: (context) => QuestionDetailsBloc(qInteractor),
        )
      ],
      child: StackOverflowQuestionsApp(),
    ),
  );
}

class StackOverflowQuestionsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Overflow Flutter Questions',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Color(int.parse('FFe0e0e0', radix:16)),
      ),
      home: StackOverflowQuestionsList(),
    );
  }
}
