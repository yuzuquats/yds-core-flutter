import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YZIcon extends StatelessWidget {
  YZIcon({
    // this.onPressed,
    this.color = CupertinoColors.activeBlue,
    this.size = 20,
    this.icon = CupertinoIcons.add,
  });

  // final VoidCallback onPressed;
  final Color color;
  final double size;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // @todo: Provide a more efficient version to clip rect version
    return Icon(
      this.icon,
      color: this.color,
      size: this.size,
    );
  }
}
