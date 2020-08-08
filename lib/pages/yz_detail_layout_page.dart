import 'package:flutter/material.dart';

class YZDetailLayoutPage extends StatelessWidget {
  const YZDetailLayoutPage({
    this.sidebar,
    this.content,
  });

  final Widget sidebar;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    Widget pagelet = Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          width: 300,
          child: this.sidebar,
        ),
        Expanded(
          child: this.content,
        ),
      ],
    );

    return Center(
      child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 1100,
            maxWidth: 1100,
          ),
          child: pagelet),
    );
  }
}
