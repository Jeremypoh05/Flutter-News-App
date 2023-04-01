import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  const VerticalSpacing(this.height);
  final double height; //initialize the height
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
