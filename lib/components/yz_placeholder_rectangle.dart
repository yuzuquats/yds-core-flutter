import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../yz_design_system.dart';

class YZPlaceholderRectangle extends StatelessWidget {
  YZPlaceholderRectangle({
    this.color = YZColors.divider,
    @required this.size,
  });

  // final VoidCallback onPressed;
  final Color color;
  final Size size;

  @override
  Widget build(BuildContext context) {
    // @todo: Provide a more efficient version to clip rect version
    return SizedBox(
      width: this.size.width,
      height: this.size.height,
      child: new Material(
        color: this.color,
        // @variant: rounded
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),

        // @variant: continuous
        // @todo: this is buggy as shit...
        // shape: ContinuousRectangleBorder(
        //   borderRadius: BorderRadius.circular(12.0 * 2),
        // ),
      ),
    );
  }
}
