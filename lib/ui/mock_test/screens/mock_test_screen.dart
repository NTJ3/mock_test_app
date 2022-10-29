import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test_app/core/util/snackbar.dart';
import 'package:mock_test_app/ui/mock_test/bloc/mock_test.dart';
import 'package:mock_test_app/ui/mock_test/model/mock_test.dart';
import '/core/index.dart';
import '/ui_components/index.dart';

class MockTestScreen extends StatefulWidget {
  MockTestScreen({Key? key}) : super(key: key);

  @override
  State<MockTestScreen> createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen> {
  late MockTestBloc _mockTestBloc;

  @override
  void initState() {
    _mockTestBloc = BlocProvider.of<MockTestBloc>(context);
    _mockTestBloc.add(FetchTests());
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.screenTitle.kMockTestApp),
        ),
        body: Padding(
          padding: EdgeInsets.all(AppFontSize.value20),
          child: Column(
            children: [
              CustomAppButton(
                text: Strings.button.kCreateNewTest,
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateTestPage()));

                  _mockTestBloc.add(FetchTests());
                },
                textColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              Expanded(
                child: BlocConsumer<MockTestBloc, MockTestState>(
                  listener: (context, state) {
                    if (state is FetchTestsFailure) {
                      showToast(state.error, context, isError: true);
                    }
                  },
                  builder: (context, state) {
                    if (state is FetchTestsLoading) {
                      return Center(
                        child: LoadingIndicator(),
                      );
                    } else if (state is FetchTestsSuccess) {
                      return buildTests(state);
                    } else {
                      return Container();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );

  Widget buildTests(FetchTestsSuccess state) {
    if (state.tests.isEmpty) {
      return Center(
        child: Text(
          Strings.label.kNoTests,
          textAlign: TextAlign.center,
          style:
              TextStyles.getH2(Colors.black, FontWeight.w500, FontStyle.normal),
        ),
      );
    }

    return ListView.builder(
      itemCount: state.tests.length,
      itemBuilder: (context, index) {
        MockTestModel singleTest = state.tests[index];
        return Container(
          padding: EdgeInsets.all(AppFontSize.value12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(AppFontSize.value18),
          ),
          margin: EdgeInsets.symmetric(
            vertical: AppFontSize.value20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                singleTest.name,
                textAlign: TextAlign.left,
                style: TextStyles.getH3(
                  Colors.black,
                  FontWeight.bold,
                  FontStyle.normal,
                ).copyWith(),
              ),
              SizedBox(height: AppFontSize.value20),
              Text(
                singleTest.createdAt,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        );
      },
    );
  }
}
