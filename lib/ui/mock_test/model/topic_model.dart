import 'package:built_value/built_value.dart';

class TopicModel {
  @nullable
  late String topicName;

  @nullable
  late List<String> concepts;

  TopicModel fromJson(Map<String, dynamic> json) {
    TopicModel user = new TopicModel();

    user.topicName = json['topicName'];
    user.concepts = new List<String>.from(json['concepts']);

    return user;
  }

  Map<String, dynamic> toJson() => {
        "topicName": topicName,
        "concepts": concepts,
      };
}
