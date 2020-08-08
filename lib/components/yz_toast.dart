import 'package:flutter/material.dart';

class YZToast extends StatelessWidget {
  YZToast({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      width: 300,
      // height: 600,
      decoration: new BoxDecoration(
        // color: _hovered ? Colors.white : Colors.white,
        color: const Color(0x66CCCCCC),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
    );
  }
}
