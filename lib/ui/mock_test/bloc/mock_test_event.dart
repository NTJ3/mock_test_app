import 'package:equatable/equatable.dart';

abstract class MockTestEvent extends Equatable {
  const MockTestEvent();
}

class CreateMockTest extends MockTestEvent {
  final String testName;

  const CreateMockTest({
    required this.testName,
  });

  @override
  List<Object> get props => [testName];

  @override
  String toString() => 'CreateMockTest { testName: $testName }';
}

class FetchTests extends MockTestEvent {
  FetchTests();

  @override
  List<Object?> get props => [];
}

class FetchTopics extends MockTestEvent {
  FetchTopics();

  @override
  List<Object?> get props => [];
}
