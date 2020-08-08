import 'package:flutter/material.dart';

import '../components/yz_text.dart';

bool notNull(Object o) => o != null;
StatelessWidget YZPage({
  @required String label,
  Widget button,
  @required MediaQueryData mediaQueryData,
}) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          YZText(
            label,
            style: const TextStyle(
              fontSize: 34.0,
            ),
          ),
        ])),
        button != null
            ? Padding(
                padding: EdgeInsets.fromLTRB(
                    20.0, 8.0, 20.0, 20.0 + mediaQueryData.padding.bottom),
                child: button)
            : null,
      ].where(notNull).toList(),
    ),
  );
}
