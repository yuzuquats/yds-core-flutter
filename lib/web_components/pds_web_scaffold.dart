import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/web_components/pds_web_scroll_controller.dart';
import 'package:oktoast/oktoast.dart';

class PDSWebScaffold extends StatefulWidget {
  PDSWebScaffold({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _PDSWebScaffoldState createState() => _PDSWebScaffoldState();
}

class _PDSWebScaffoldState extends State<PDSWebScaffold> {
  final ScrollController _primaryScrollController = WebScrollController();

  @override
  Widget build(BuildContext context) {
    return PrimaryScrollController(
      controller: _primaryScrollController,
      child: OKToast(child: widget.child),
    );
  }
}
