import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'yz_list_cell_layout.dart';
import 'yz_icon.dart';

typedef YZSectionSelectCallback = void Function(String);

class YZFloatingSidebar extends StatelessWidget {
  YZFloatingSidebar({
    @required this.sections,
    this.onSelect,
  });

  final List<String> sections;
  final YZSectionSelectCallback onSelect;

  @override
  Widget build(BuildContext context) {
    Widget list = ListView.builder(
      itemCount: this.sections.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            child: getSearchBar(),
          );
        } else {
          String entry = this.sections[index - 1];
          return Padding(
              // @todo: not needed?
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: getSidebarListView(entry, entry == "Discover"));
        }
      },
    );

    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        // @variant darker version
        color: const Color(0xFFeeeded),
        // @variant lighter version
        // color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: list,
    );
  }

  Widget getSearchBar() {
    return YZListCellLayout(
      icon: Padding(
        padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
        child: YZIcon(
          icon: CupertinoIcons.search,
          color: Colors.black54,
          size: 20,
        ),
      ),
      content: Padding(
        // @todo: necessary in order to center by baseline capeheight :(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
        child: Text(
          "Search",
          style: TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
          // @todo: baseline capheight
        ),
      ),
      height: 28,
      iconSpacer: 4,
      // @variant: darker version
      // backgroundColor: const Color(0xFFe8e9e8),
      // @variant: lighter version
      // backgroundColor: const Color(0xFFF6F6F6),
      // @variant: white
      backgroundColor: Colors.white,

      // @todo: hover background?
    );
  }

  Widget getSidebarListView(String text, bool selected) {
    return YZListCellLayout(
      icon: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: YZIcon(),
      ),
      onTap: () {
        print("Selected $text from sidebar");
        this.onSelect(text);
      },
      content: Padding(
        // @todo: necessary in order to center by baseline capeheight :(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            // color: Colors.white,
            // @todo: baseline capheight
            // backgroundColor: Colors.blue,
          ),
          // @todo: baseline capheight
          // textHeightBehavior: TextHeightBehavior(
          //   applyHeightToFirstAscent: true,
          //   applyHeightToLastDescent: false,
          // ),
        ),
      ),
      height: 36,
      iconSpacer: 4,
      hoverBackgroundColor: const Color(0xFFcccbca),
      // hoverBackgroundColor: Colors.red,
      // backgroundColor: selected ? const Color(0xFFcccbca) : null,
    );
  }
}
