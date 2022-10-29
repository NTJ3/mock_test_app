import 'package:flutter/material.dart';
import 'package:mock_test_app/core/constant/size_config.dart';
import 'package:mock_test_app/core/constant/strings.dart';
import '/core/util/index.dart';
import '/ui/mock_test/bloc/mock_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  loggerConfigure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: Strings.screenTitle.kMockTestApp,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(
          builder: (context) {
            SizeConfig().init(context);
            return MockTestPage();
          },
        ),
        routes: {
          MockTestPage.tag: (context) => MockTestPage(),
          CreateTestPage.tag: (context) => CreateTestPage(),
        },
      );
}
