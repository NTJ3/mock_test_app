import 'package:built_value/built_value.dart';

class MockTestModel {
  @nullable
  late String id;

  @nullable
  late String name;

  @nullable
  late String createdAt;

  MockTestModel fromJson(Map<String, dynamic> json) {
    MockTestModel user = new MockTestModel();
    user.id = json['id'];
    user.name = json['name'];
    user.createdAt = json['createdAt'];

    return user;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt,
      };
}
