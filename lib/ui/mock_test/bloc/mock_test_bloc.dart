import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '/ui/mock_test/model/mock_test.dart';
import '/ui/mock_test/model/topic_model.dart';
import '/core/index.dart';
import 'mock_test.dart';

class MockTestBloc extends Bloc<MockTestEvent, MockTestState> {
  MockTestBloc() : super(MockTestInitial());

  MockTestState get initialState => MockTestInitial();

  List<TopicModel> kTopics = [];

  Stream<MockTestState> mapEventToState(MockTestEvent event) async* {
    if (event is CreateMockTest) {
      yield* createMockTest(event);
    } else if (event is FetchTopics) {
      yield* fetchTopics(event);
    } else if (event is FetchTests) {
      yield* fetchTests(event);
    }
  }

  Stream<MockTestState> createMockTest(CreateMockTest event) async* {
    try {
      yield CreateMockTestLoading();

      final MockTestModel mockTest = new MockTestModel();

      mockTest.id = DateTime.now().microsecondsSinceEpoch.toString();
      mockTest.name = event.testName;
      mockTest.createdAt =
          DateFormat('MMM dd, yy hh:mm aaa').format(DateTime.now());

      List<MockTestModel> mockTests = [];

      String? res =
          await SharedPreferenceHelper.getString(Strings.storageKeys.TOPICS);

      log.info("all topics $res");

      if (res == null || res == []) {
        mockTests = [];
      } else {
        mockTests = List<MockTestModel>.from(
            (jsonDecode(res).map((e) => MockTestModel().fromJson(e))));
      }

      mockTests.add(mockTest);

      String mockTestsStr =
          jsonEncode(mockTests.map((e) => e.toJson()).toList());

      await SharedPreferenceHelper.setString(
          Strings.storageKeys.TOPICS, mockTestsStr);

      yield CreateMockTestSuccess();
    } catch (error) {
      log.severe(error.toString(), error);
      yield CreateMockTestFailure(error: Strings.message.kSomethingWentWrong);
      yield FetchTopicsSuccess(topics: kTopics);
    }
  }

  Stream<MockTestState> fetchTests(FetchTests event) async* {
    try {
      yield FetchTestsLoading();

      List<MockTestModel> mockTests = [];

      String? res =
          await SharedPreferenceHelper.getString(Strings.storageKeys.TOPICS);

      log.info("all topics $res");

      if (res == null) {
        final MockTestModel mockTest1 = new MockTestModel();

        mockTest1.id = DateTime.now().microsecondsSinceEpoch.toString();
        mockTest1.name = 'Mock Test #1';
        mockTest1.createdAt =
            DateFormat('MMM dd, yy hh:mm aaa').format(DateTime.now());

        final MockTestModel mockTest2 = new MockTestModel();

        mockTest2.id = DateTime.now().microsecondsSinceEpoch.toString();
        mockTest2.name = 'Mock Test #2';
        mockTest2.createdAt =
            DateFormat('MMM dd, yy hh:mm aaa').format(DateTime.now());

        mockTests.addAll([mockTest1, mockTest2]);

        String mockTestsStr =
            jsonEncode(mockTests.map((e) => e.toJson()).toList());

        await SharedPreferenceHelper.setString(
            Strings.storageKeys.TOPICS, mockTestsStr);
      } else {
        mockTests = List<MockTestModel>.from(
            (jsonDecode(res).map((e) => MockTestModel().fromJson(e))));
      }

      yield FetchTestsSuccess(tests: mockTests);
    } catch (error) {
      log.severe(error.toString(), error);
      yield FetchTestsFailure(error: Strings.message.kSomethingWentWrong);
      yield MockTestInitial();
    }
  }

  Stream<MockTestState> fetchTopics(FetchTopics event) async* {
    try {
      yield FetchTopicsLoading();

      var response = await Dio().get(Strings.apis.kFetchTopics,
          options: Options(
            headers: {
              "userid": "25794905-2dd4-40bd-97b9-9d5d69294b86",
              "token": "d61036c6-5ffd-4964-b7ff-8d5ba8ca0262",
            },
          ));

      if (response.statusCode == 200) {
        List<TopicModel> topics = (response.data as List)
            .map((e) => TopicModel().fromJson(e))
            .toList();

        kTopics.clear();

        kTopics.addAll(topics);

        yield FetchTopicsSuccess(topics: topics);
      }
    } catch (error) {
      log.severe(error.toString(), error);
      print("error $error");
      yield FetchTopicsFailure(error: Strings.message.kSomethingWentWrong);
      yield MockTestInitial();
    }
  }
}
