import 'package:equatable/equatable.dart';
import 'package:mock_test_app/ui/mock_test/model/mock_test.dart';
import 'package:mock_test_app/ui/mock_test/model/topic_model.dart';

abstract class MockTestState extends Equatable {
  const MockTestState();

  @override
  List<Object> get props => [];
}

class MockTestInitial extends MockTestState {}

class CreateMockTestLoading extends MockTestState {}

class CreateMockTestSuccess extends MockTestState {}

class CreateMockTestFailure extends MockTestState {
  final String error;

  const CreateMockTestFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreateMockTestFailure { error: $error }';
}

class FetchTestsLoading extends MockTestState {}

class FetchTestsSuccess extends MockTestState {
  final List<MockTestModel> tests;

  const FetchTestsSuccess({required this.tests});

  @override
  List<Object> get props => [tests];

  @override
  String toString() => 'FetchTestsFailure { tests: $tests }';
}

class FetchTestsFailure extends MockTestState {
  final String error;

  const FetchTestsFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FetchTestsFailure { error: $error }';
}

class FetchTopicsLoading extends MockTestState {}

class FetchTopicsSuccess extends MockTestState {
  final List<TopicModel> topics;

  const FetchTopicsSuccess({required this.topics});

  @override
  List<Object> get props => [topics];

  @override
  String toString() => 'FetchTopicsFailure { topics: $topics }';
}

class FetchTopicsFailure extends MockTestState {
  final String error;

  const FetchTopicsFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FetchTopicsFailure { error: $error }';
}
