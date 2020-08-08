import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yds_core_flutter/yz_design_system.dart';

class YZWidgetGalleryPage extends StatelessWidget {
  // final ScrollController _scrollController = ScrollController();

  const YZWidgetGalleryPage({
    this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    String description =
        "The v-card component is a versatile component that can be used for anything from a panel to a static image. The card component has numerous helper components to make markup as easy as possible. Components that have no listed options use Vue's functional component option for faster rendering and serve as markup sugar to make building easier.";

    List<PropEntry> props = [
      PropEntry(
        "className",
        "A space-delimited list of class names to pass along to a child element.",
      ),
      PropEntry(
        "elevation",
        "Controls the intensity of the drop shadow beneath the card: the higher the elevation, the higher the drop shadow. At elevation 0, no drop shadow is applied.",
      ),
      PropEntry(
        "interactive",
        "Whether the card should respond to user interactions. If set to true, hovering over the card will increase the card's elevation and change the mouse cursor to a pointer.\n\nRecommended when onClick is also defined.",
      ),
      PropEntry(
        "onclick",
        "Callback invoked when the card is clicked. Recommended when interactive is true.",
      ),
    ];

    // @todo: fork the scrollbar so we can have a proper thickness
    // Widget scrollbar = Scrollbar(
    //   // controller: _scrollController,
    //   child: getListComponent(child),
    // );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 200,
      ),
      child: getListComponent(content, description, props),
    );
  }

  Widget getListComponent(
      Widget child, String description, List<PropEntry> props) {
    return ListView(
      physics: AlwaysScrollableScrollPhysics(),
      // controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      children: [
        Text(
          child.runtimeType.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20),
        Text(
          description,
          style: YZTextStyles.paragraph,
        ),
        SizedBox(height: 24),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 200.0,
            maxHeight: 300.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: getPreviewComponent(child),
              ),
              SizedBox(width: 12),
              getTweakComponent(),
            ],
          ),
        ),
        SizedBox(height: 36),
        Text(
          "Props",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 16),
        getTableComponent(props),
      ],
    );
  }

  Widget getTableComponent(List<PropEntry> entries) {
    List<TableRow> rows = List.generate(entries.length + 1, (index) {
      if (index == 0) {
        return TableRow(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Name",
                style: YZTextStyles.paragraph.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Description",
                style: YZTextStyles.paragraph.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                width: 1.0,
                color: YZColors.divider,
              ),
              bottom: BorderSide(
                width: 1.0,
                color: YZColors.divider,
              ),
            ),
          ),
        );
      }

      PropEntry entry = entries[index - 1];
      return TableRow(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              entry.name,
              style: YZTextStyles.paragraph,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              entry.description,
              style: YZTextStyles.paragraph,
            ),
          ),
        ],
      );
    });

    return Table(
      columnWidths: {
        0: FixedColumnWidth(200),
      },
      children: rows,
    );
  }

  Widget getPreviewComponent(Widget child) {
    return Container(
      width: 500.0,
      child: Center(
        child: child,
      ),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
        // border: Border.all(
        //   width: 1.0,
        //   color: YZColors.divider,
        // ),
        boxShadow: [
          YZDefaultBoxShadow(),
        ],
      ),
    );
  }

  Widget getTweakComponent() {
    return SizedBox(
      width: 200,
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          // @variant: outline
          // color: Colors.white,
          // border: Border.all(
          //   width: 1.0,
          //   color: YZColors.divider,
          // ),
          // @variant: flat
          color: Color(0xFFeeeded),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // @todo: we need a lighter/smaller switch variant
            // CupertinoSwitch(
            //   value: true,
            //   onChanged: (bool) {},
            // ),
            Text("Width"),
            // @todo: slider seems to have a bug here and doesn't respecting
            // padding.
            //
            // Container(
            //   child: YZSlider(
            //     initialValue: 50,
            //     min: 0,
            //     max: 100,
            //   ),
            //   decoration: new BoxDecoration(
            //     color: Colors.red,
            //   ),
            // ),
            YZSlider(
              initialValue: 50,
              min: 0,
              max: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class PropEntry {
  final String name;
  final String description;
  const PropEntry(this.name, this.description);
}
