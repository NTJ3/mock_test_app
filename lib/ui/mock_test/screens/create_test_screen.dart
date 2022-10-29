import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mock_test_app/core/util/snackbar.dart';
import 'package:mock_test_app/ui_components/index.dart';
import 'package:parent_child_checkbox/parent_child_checkbox.dart';

import '../bloc/mock_test.dart';
import '/core/index.dart';

class CreateTestScreen extends StatefulWidget {
  CreateTestScreen({Key? key}) : super(key: key);

  @override
  State<CreateTestScreen> createState() => _CreateTestScreenState();
}

class _CreateTestScreenState extends State<CreateTestScreen> {
  late MockTestBloc _mockTestBloc;

  TextEditingController _textEditingController =
      new TextEditingController(text: '');

  @override
  void initState() {
    _mockTestBloc = BlocProvider.of<MockTestBloc>(context);
    _mockTestBloc.add(FetchTopics());

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(Strings.screenTitle.kCreateNewTest),
        ),
        bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(AppFontSize.value18)),
          child: Text(Strings.button.kCreateNewTest),
          onPressed: _onCreateTest,
        ),
        body: Container(
          padding: EdgeInsets.all(AppFontSize.value20),
          child: Column(
            children: [
              TextField(
                controller: _textEditingController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                decoration: TextStyles.getInputDecoration().copyWith(
                  hintText: Strings.hint.kEnterTextName,
                ),
              ),
              BlocConsumer<MockTestBloc, MockTestState>(
                builder: (context, state) {
                  if (state is FetchTopicsLoading) {
                    return Expanded(child: Center(child: LoadingIndicator()));
                  } else if (state is FetchTopicsSuccess) {
                    return _buildTopics(state);
                  } else {
                    return Container();
                  }
                },
                listener: (BuildContext context, MockTestState state) {
                  if (state is FetchTopicsFailure) {
                    showToast(state.error, context, isError: true);
                  } else if (state is CreateMockTestFailure) {
                    showToast(state.error, context, isError: true);
                  } else if (state is CreateMockTestSuccess) {
                    showToast(Strings.message.kCreateTestSuccess, context);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildTopics(FetchTopicsSuccess state) {
    if (state.topics.isEmpty) {
      return Text(Strings.label.kNoTopics);
    } else {
      return Expanded(
          child: ListView.builder(
        itemBuilder: (context, index) => ParentChildCheckbox(
          parent: Text('${state.topics[index].topicName}'),
          children: state.topics[index].concepts
              .asMap()
              .map((i, element) => MapEntry(
                  i,
                  Text(
                    element,
                    maxLines: 3,
                  )))
              .values
              .toList(),
        ),
        itemCount: state.topics.length,
      ));
    }
  }

  void _onCreateTest() {
    if (_textEditingController.text.isEmpty) {
      showToast(Strings.message.kEnterTestName, context, isError: true);
      return;
    }
    _mockTestBloc.add(CreateMockTest(testName: _textEditingController.text));
    log.info(ParentChildCheckbox.isParentSelected.toString());
    log.info(ParentChildCheckbox.selectedChildrens.toString());
  }
}
