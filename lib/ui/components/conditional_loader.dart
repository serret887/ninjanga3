import 'package:flutter/material.dart';

class ConditionalLoader extends StatelessWidget {
  final Type goodState;
  final Type loadingState;
  final Type state;
  final Widget widget;

  const ConditionalLoader(
      {Key key, this.goodState, this.loadingState, this.state, this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.runtimeType == goodState.runtimeType)
      return widget;
    else if (state.runtimeType == loadingState.runtimeType)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return Container();
  }
}
