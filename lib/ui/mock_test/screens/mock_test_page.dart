import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/index.dart';
import '/ui/mock_test/bloc/mock_test.dart';

class MockTestPage extends StatelessWidget {
  static String tag = ScreensName().kMockTest;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => MockTestBloc(),
        child: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          child: MockTestScreen(),
        ),
      );
}
