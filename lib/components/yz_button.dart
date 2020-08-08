import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YZButton extends StatelessWidget {
  YZButton(
    this.label, {
    this.onPressed,
    this.color,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new CupertinoButton(
      child: new Text(
        this.label,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      // pressedOpacity: 0.4,
      onPressed: this.onPressed,
      color: color ?? Colors.lightBlue[500],
    );
  }
}
