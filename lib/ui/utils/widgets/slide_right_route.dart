import 'package:flutter/material.dart';

class SlideRightPageRoute extends MaterialPageRoute {
  SlideRightPageRoute(
      {required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    Animation<Offset> custom = Tween<Offset>(
            begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(animation);
    return SlideTransition(
      position: custom,
      child: child,
    );
  }
}
