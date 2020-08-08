import 'package:flutter/material.dart';

class YZText extends StatelessWidget {
  YZText(
    this.label, {
    this.style,
    this.textAlign,
  });

  final String label;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      this.label,
      style: this.style,
      textAlign: this.textAlign,
    );
  }
}
