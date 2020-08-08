import 'package:flutter/material.dart';

class YZListCellLayout extends StatefulWidget {
  YZListCellLayout({
    Key key,
    this.icon,
    this.content,
    this.accessory,
    this.padding,
    this.height,
    this.iconSpacer,
    this.accessorySpacer,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.shadow,
    this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Widget content;
  final Widget accessory;
  final EdgeInsetsGeometry padding;

  final double height;
  final double iconSpacer;
  final double accessorySpacer;

  final Color backgroundColor;
  final Color hoverBackgroundColor;
  final BoxShadow shadow;

  final GestureTapCallback onTap;

  @override
  _YZListCellLayoutState createState() => _YZListCellLayoutState();
}

class _YZListCellLayoutState extends State<YZListCellLayout> {
  bool _hovered = false;

  void _onHoverEnter(PointerEvent details) {
    setState(() {
      _hovered = true;
      // @todo: modularize this somehow
      // HoverExtensions.appContainer.style.cursor = 'pointer';
    });
  }

  void _onHoverExit(PointerEvent details) {
    setState(() {
      _hovered = false;
      // HoverExtensions.appContainer.style.cursor = 'default';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onHoverEnter,
      onExit: _onHoverExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: statelessListItem(context),
      ),
    );
  }

  Widget statelessListItem(BuildContext context) {
    List<Widget> children = [];
    if (widget.icon != null) {
      children.add(widget.icon);
      children.add(SizedBox(width: widget.iconSpacer));
    }
    children.add(widget.content);
    if (widget.accessory != null) {
      children.add(SizedBox(width: widget.accessorySpacer));
      children.add(widget.accessory);
    }
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: children,
      ),
      padding: widget.padding,
      height: widget.height,
      decoration: new BoxDecoration(
        color: (_hovered && widget.hoverBackgroundColor != null)
            ? widget.hoverBackgroundColor
            : widget.backgroundColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: widget.shadow != null
            ? [
                widget.shadow,
              ]
            : null,
      ),
    );
  }
}
