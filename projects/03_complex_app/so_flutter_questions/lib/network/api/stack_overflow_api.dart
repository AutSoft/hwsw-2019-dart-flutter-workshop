import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:so_flutter_questions/network/model/answers_response.dart';
import 'package:so_flutter_questions/network/model/questions_response.dart';

final stackOverflowApi = StackOverflowApi._();

class StackOverflowApi {
  static const _BASE_URL = "https://api.stackexchange.com/2.2";

  http.Client client;

  StackOverflowApi._() {
    client = http.Client();
  }

  String paramListFromMap(Map<String, String> params) {
    var paramsString = "";
    params.forEach((key, value) {
      paramsString += "$key=$value&";
    });

    return paramsString.substring(0, paramsString.length - 1);
  }

  Future<QuestionsResponse> getQuestions(
      {int pageSize = 20, List<String> tags = const ["flutter"]}) async {
    final params = {
      "page": "1",
      "pageSize": "$pageSize",
      "order": "desc",
      "sort": "creation",
      "tagged": "${tags.join(";")}",
      "filter": "withbody",
      "site": "stackoverflow"
    };

    var url = "$_BASE_URL/questions?${paramListFromMap(params)}";

    final response = await client.get(url);

    final jsonBody = jsonDecode(response.body);

    // This statement gives a discount mocked result
   /* final jsonBody =
        jsonDecode(await rootBundle.loadString('assets/mock_questions.json'));*/

    return QuestionsResponse.fromJsonMap(jsonBody);
  }

  Future<AnswersResponse> getAnswersForQuestion(
      {@required int questionId}) async {
    final params = {
      "order": "desc",
      "sort": "activity",
      "site": "stackoverflow",
      "filter": "withbody"
    };

    var url =
        "$_BASE_URL/questions/$questionId/answers?${paramListFromMap(params)}";

    final response = await client.get(url);

    final jsonBody = jsonDecode(response.body);

    // This statement gives a discount mocked result
    /*final jsonBody =
        jsonDecode(await rootBundle.loadString('assets/mock_answers.json'));*/

    return AnswersResponse.fromJsonMap(jsonBody);
  }
}
