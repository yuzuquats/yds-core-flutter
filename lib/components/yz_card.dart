import 'package:flutter/material.dart';

class YZCard extends StatefulWidget {
  YZCard({Key key, this.title, this.content}) : super(key: key);

  final String title;
  final Widget content;

  @override
  _YZCardState createState() => _YZCardState();
}

class _YZCardState extends State<StatefulWidget> {
  bool _hovered = false;

  void _onHoverEnter(PointerEvent details) {
    setState(() {
      _hovered = true;
    });
  }

  void _onHoverExit(PointerEvent details) {
    setState(() {
      _hovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      // onEnter: _onHoverEnter,
      // onExit: _onHoverExit,
      child: listItem(context),
    );
  }

  Widget listItem(BuildContext context) {
    // @TODO: not necessary?
    YZCard card = this.widget as YZCard;
    return Container(
      child: Column(
        children: [
          Text(
            card.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20),
          card.content,
        ],
      ),
      // @TODO(jameskao): Use of margin is a hack - when multiple cards wrap in
      // a Wrap object, the shadow will clip
      // margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 16),
      width: 300,
      // height: 600,
      decoration: new BoxDecoration(
        color: _hovered ? Colors.white : Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        boxShadow: [
          new BoxShadow(
            color: Colors.black26,
            offset: new Offset(0.0 /* dx */, 2.0 /* dy */),
            blurRadius: 16,
          )
        ],
      ),
    );
  }
}
