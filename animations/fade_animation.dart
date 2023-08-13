import 'package:flutter/material.dart';

import 'controlled_animation.dart';
import 'multi_track_tween.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(
        Duration(milliseconds: 500),
        Tween(begin: 0.0, end: 1.0),
        curve: Curves.slowMiddle,
      ),
      Track("translateY").add(
          Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
          curve: Curves.easeOut)
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        // opacity: animation!["opacity"],
        opacity: .6,
        child: Transform.translate(offset: Offset(0, 100), child: child),
      ),
    );
  }
}
