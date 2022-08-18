import 'package:flutter/material.dart';
class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [Color(0xff80E07E), Color(0xff00F0FF)],
        tileMode: TileMode.repeated,
      ).createShader(bounds),
      child: child,
    );
  }
}