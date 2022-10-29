class Strings {
  static ScreenTitle screenTitle = ScreenTitle();
  static HintString hint = HintString();
  static LabelString label = LabelString();
  static ButtonTitleString button = ButtonTitleString();
  static MessageString message = MessageString();
  static ScreensName screensName = ScreensName();
  static APIs apis = APIs();
  static StorageKeys storageKeys = StorageKeys();
}

class APIs {
  final String kFetchTopics =
      "https://utkwwq6r95.execute-api.us-east-1.amazonaws.com/assignment/topics";
}

class StorageKeys {
  final String TOPICS = "TOPICS";
}

class ScreenTitle {
  final String kMockTestApp = "Mock Test App";
  final String kCreateNewTest = "Create New Test";
}

class ScreensName {
  final String kMockTest = "/mock-test";
  final String kCreateMockTest = "/create-mock-test";
}

class HintString {
  final String kEnterTextName = "Test Name";
}

class LabelString {
  final String kCreateNewTest = "Create New Test";
  final String kTopics = "Topics";
  final String kNoTopics = "No Topics";
  final String kNoTests =
      "No Tests available\nCreate by clicking on\n'Create New Test' Button";
}

class ButtonTitleString {
  final String kCreate = "Create";
  final String kCreateNewTest = "Create New Test";
}

class MessageString {
  final String kNoInternet =
      'No Internet.. Please check your internet connectivity';
  final String kEnterTestName = "Please enter test name";
  final String kSomethingWentWrong = "Something went wrong, Please try again";
  final String kCreateTestSuccess = "Test Created Successfully";
}
