import 'package:flutter/material.dart';

class MyLoadingContainer extends StatelessWidget {
  ///
  final bool isCover;
  final bool isLoading;
  final Widget child;

  MyLoadingContainer({
    Key key,
    this.isCover = false,
    @required this.isLoading,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(isCover) {
      List<Widget> children = [child];
      if(isLoading) {
        children.add(_loadingView);
      }
      return Stack(children: children);
    }
    return isLoading ? _loadingView : child;
  }

  Widget get _loadingView {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
