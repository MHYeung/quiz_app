import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/model/failure.dart';
import 'package:quiz_app/model/question.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final quizRepositoryProvider =
    Provider<QuizRepository>((ref) => QuizRepository(ref));

class QuizRepository {
  final Ref _ref;

  QuizRepository(this._ref);

  Future<List<Question>> getQuestions(
      {required int numQuestions,
      required int categoryId,
      required Difficulty difficulty}) async {
    try {
      final queryParameters = {
        'type': 'multiple',
        'amount': numQuestions,
        'category': categoryId,
      };

      if (difficulty != Difficulty.any) {
        queryParameters
            .addAll({'difficulty': EnumToString.convertToString(difficulty)});
      }

      final response = await _ref.read(dioProvider).get(
            'https://opentdb.com/api.php',
            queryParameters: queryParameters,
          );
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results'] ?? []);
        if (results.isNotEmpty) {
          //print(results);
          return results.map((e) => Question.fromMap(e)).toList();
        }
      }
      return [];
    } on DioError catch (err) {
      debugPrint(err.toString());
      throw Failure(
        message: err.response?.statusMessage ?? 'Something went wrong!',
      );
    } on SocketException catch (err) {
      debugPrint(err.toString());
      throw const Failure(message: 'Please check your connection.');
    }
  }
}
