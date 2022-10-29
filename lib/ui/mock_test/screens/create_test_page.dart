import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test_app/ui/mock_test/bloc/mock_test.dart';
import '/core/index.dart';

class CreateTestPage extends StatelessWidget {
  static String tag = Strings.screensName.kCreateMockTest;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => new MockTestBloc(),
        child: SafeArea(
          child: CreateTestScreen(),
        ),
      );
}
