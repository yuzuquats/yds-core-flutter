import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yds_core_flutter/yz_design_system.dart';

import 'templates/yz_widget_gallery_page.dart';

/*
 * @known-issues:
 *
 * Resizing windows is janky:
 *     https://github.com/flutter/flutter/issues/44136
 */
void main() {
  // @todo: add custom build step to parse code
  // /Users/jameskao/Library/Containers/com.example.YZDesignSystemGallery/Data
  // Directory current = Directory.current;
  // print(current);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YZ Design System Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

typedef StringWidgetBuilder = Widget Function(BuildContext context, String s);

class HomePage extends StatefulWidget {
  HomePage() {
    // @todo: use the right constructor
    this.sections = {
      "Button": (context) => YZWidgetGalleryPage(
            content: YZButton(
              "Click Me!",
            ),
          ),
      "Card": (context) => YZWidgetGalleryPage(
            content: YZCard(
              title: "Card Title",
              content: Text("My Content"),
            ),
          ),
      "Floating Sidebar": (context) => YZWidgetGalleryPage(
            content: YZFloatingSidebar(
              sections: [
                "Section 1",
                "Section 2",
                "Section 3",
                "Section 4",
              ],
            ),
          ),
      "Icon": (context) => YZWidgetGalleryPage(
            content: YZIcon(),
          ),
      "List Cell": (context) => YZWidgetGalleryPage(
            content: getListCellExampleComponent(),
          ),
      "Placeholder": (context) => YZWidgetGalleryPage(
            content: YZPlaceholderRectangle(
              size: Size(100, 100),
            ),
          ),
      "Slider": (context) => YZWidgetGalleryPage(
            content: YZSlider(
              initialValue: 10,
              min: 0,
              max: 100,
            ),
          ),
      "Text": (context) => YZWidgetGalleryPage(
            content: YZText("Paragraph"),
          ),
      "Toast": (context) => YZWidgetGalleryPage(
            content: YZToast(
              text: "My Toast",
            ),
          ),
    };
    this.initialSection = "Card";
  }

  Map<String, WidgetBuilder> sections;
  String initialSection;

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String _selectedSection;

  @override
  Widget build(BuildContext context) {
    Widget pagelet;
    if (_selectedSection != null) {
      pagelet = widget.sections[_selectedSection](context);
    } else {
      pagelet = widget.sections[widget.initialSection](context);
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: YZDetailLayoutPage(
        sidebar: YZFloatingSidebar(
          sections: widget.sections.keys.toList(),
          onSelect: (String section) {
            setState(() {
              _selectedSection = section;
            });
          },
        ),
        // @todo: scrollbar doesn't work?
        content: pagelet,
      ),
    );
  }
}

Widget getListCellExampleComponent() {
  return YZListCellLayout(
    icon: Padding(
      padding: EdgeInsets.all(8.0),
      child: YZIcon(
        color: CupertinoColors.systemPink.darkColor,
        size: 40,
      ),
    ),
    content: Padding(
      // @todo: necessary in order to center by baseline capeheight :(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
      child: Text(
        "Primary Content Text",
        style: TextStyle(
          color: Colors.white,
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
    height: 56,
    iconSpacer: 4,
    // @variant: Solid BG + Hover State
    // backgroundColor: const Color(0xFFF4f4f4),
    //hoverBackgroundColor: const Color(0xFFCCCCCC),

    // @variant: Clear BG + Hover State
    // hoverBackgroundColor: const Color(0xFFEEEEEE),

    // @variant: Control Center
    backgroundColor: const Color(0xFF5e6263),

    // @variant: Debug
    // hoverBackgroundColor: Colors.red,
  );
}

// Widget getGalleryList() {
//   return ListView(
//     padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
//     children: [
//       WidgetGalleryContainer(
//         child: YZText("YZ Text"),
//       ),
//       WidgetGalleryContainer(
//         child: YZButton("Lorem Ipsum"),
//       ),
//       WidgetGalleryContainer(
//         child: YZCard(
//           title: "Lorem Ipsum",
//           content: YZText("Hello"),
//         ),
//       ),
//       WidgetGalleryContainer(
//         child: YZSliderStateless(
//           value: 40,
//           min: 20,
//           max: 100,
//           onChanged: (double changed) {
//             // no-op
//           },
//         ),
//       ),
//       WidgetGalleryContainer(
//         child: YZSlider(
//           initialValue: 10,
//           min: 0,
//           max: 100,
//         ),
//       ),
//       WidgetGalleryContainer(
//         child: YZListCellLayout(
//           icon: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: YZIcon(
//               color: CupertinoColors.systemPink.darkColor,
//               size: const Size(40, 40),
//             ),
//           ),
//           content: Padding(
//             // @todo: necessary in order to center by baseline capeheight :(
//             padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
//             child: Text(
//               "Primary Content Text",
//               style: TextStyle(
//                 color: Colors.white,
//                 // @todo: baseline capheight
//                 // backgroundColor: Colors.blue,
//               ),
//               // @todo: baseline capheight
//               // textHeightBehavior: TextHeightBehavior(
//               //   applyHeightToFirstAscent: true,
//               //   applyHeightToLastDescent: false,
//               // ),
//             ),
//           ),
//           height: 56,
//           iconSpacer: 4,
//           // @variant: Solid BG + Hover State
//           // backgroundColor: const Color(0xFFF4f4f4),
//           //hoverBackgroundColor: const Color(0xFFCCCCCC),

//           // @variant: Clear BG + Hover State
//           // hoverBackgroundColor: const Color(0xFFEEEEEE),

//           // @variant: Control Center
//           backgroundColor: const Color(0xFF5e6263),

//           // @variant: Debug
//           // hoverBackgroundColor: Colors.red,
//         ),
//       ),
//     ],
//   );
// }
