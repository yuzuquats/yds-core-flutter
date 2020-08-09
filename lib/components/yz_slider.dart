import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RoundSliderTrackShape extends SliderTrackShape {
  /// Create a slider track that draws 2 rectangles.
  const RoundSliderTrackShape({this.disabledThumbGapWidth = 2.0});

  /// Horizontal spacing, or gap, between the disabled thumb and the track.
  ///
  /// This is only used when the slider is disabled. There is no gap around
  /// the thumb and any part of the track when the slider is enabled. The
  /// Material spec defaults this gap width 2, which is half of the disabled
  /// thumb radius.
  final double disabledThumbGapWidth;

  @override
  Rect getPreferredRect({
    RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData sliderTheme,
    bool isEnabled,
    bool isDiscrete,
  }) {
    // final double trackHeight = sliderTheme.trackHeight;
    // final double trackLeft = offset.dx;
    // final double trackTop =
    //     offset.dy + (parentBox.size.height - trackHeight) / 2;
    // final double trackWidth = parentBox.size.width;
    // return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);

    final double overlayWidth =
        sliderTheme.overlayShape.getPreferredSize(isEnabled, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= overlayWidth);
    assert(parentBox.size.height >= trackHeight);

    // @todo: padding is not reflected here through parent size...
    final double trackLeft = offset.dx + 12;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 24;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    Animation<double> enableAnimation,
    TextDirection textDirection,
    Offset thumbCenter,
    bool isDiscrete,
    bool isEnabled,
  }) {
    // If the slider track height is 0, then it makes no difference whether the
    // track is painted or not, therefore the painting can be a no-op.
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    // Assign the track segment paints, which are left: active, right: inactive,
    // but reversed for right to left text.
    final ColorTween activeTrackColorTween = ColorTween(
        begin: sliderTheme.disabledActiveTrackColor,
        end: sliderTheme.activeTrackColor);
    final ColorTween inactiveTrackColorTween = ColorTween(
        begin: sliderTheme.disabledInactiveTrackColor,
        end: sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..color = activeTrackColorTween.evaluate(enableAnimation);
    final Paint inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation);
    final Paint outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFb1b3b5)
      ..strokeWidth = 1;

    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    // Used to create a gap around the thumb iff the slider is disabled.
    // If the slider is enabled, the track can be drawn beneath the thumb
    // without a gap. But when the slider is disabled, the track is shortened
    // and this gap helps determine how much shorter it should be.
    // TODO(clocksmith): The new Material spec has a gray circle in place of this gap.
    double horizontalAdjustment = 0.0;
    if (!isEnabled) {
      final double disabledThumbRadius =
          sliderTheme.thumbShape.getPreferredSize(false, isDiscrete).width /
              2.0;
      final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
      horizontalAdjustment = disabledThumbRadius + gap;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Rect leftTrackSegment = Rect.fromLTRB(trackRect.left, trackRect.top,
        thumbCenter.dx - horizontalAdjustment, trackRect.bottom);
    double trackRadius = sliderTheme.trackHeight / 2.0;

    // Left Arc
    context.canvas.drawArc(
        Rect.fromCircle(
            center: Offset(trackRect.left, trackRect.top + trackRadius),
            radius: trackRadius),
        -pi * 3 / 2, // -270 degrees
        pi, // 180 degrees
        false,
        trackRect.left - thumbCenter.dx == 0.0
            ? rightTrackPaint
            : leftTrackPaint);
    context.canvas.drawArc(
        Rect.fromCircle(
            center: Offset(trackRect.left, trackRect.top + trackRadius),
            radius: trackRadius),
        -pi * 3 / 2, // -270 degrees
        pi, // 180 degrees
        false,
        outlinePaint);

    // Right Arc
    context.canvas.drawArc(
        Rect.fromCircle(
            center: Offset(trackRect.right, trackRect.top + trackRadius),
            radius: trackRadius),
        -pi / 2, // -90 degrees
        pi, // 180 degrees
        false,
        trackRect.right - thumbCenter.dx == 0.0
            ? leftTrackPaint
            : rightTrackPaint);
    context.canvas.drawArc(
        Rect.fromCircle(
            center: Offset(trackRect.right, trackRect.top + trackRadius),
            radius: trackRadius),
        -pi / 2, // -90 degrees
        pi, // 180 degrees
        false,
        outlinePaint);

    context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
    final Rect rightTrackSegment = Rect.fromLTRB(
        thumbCenter.dx + horizontalAdjustment,
        trackRect.top,
        trackRect.right,
        trackRect.bottom);
    context.canvas.drawRect(rightTrackSegment, rightTrackPaint);

    context.canvas.drawLine(Offset(trackRect.left, trackRect.top),
        Offset(trackRect.right, trackRect.top), outlinePaint);
    context.canvas.drawLine(Offset(trackRect.left, trackRect.bottom),
        Offset(trackRect.right, trackRect.bottom), outlinePaint);
  }
}

class YZCircularThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    // @todo: shouldn't be hardcoded
    return Size.fromRadius(11.0);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
    double textScaleFactor,
    Size sizeWithOverflow,
  }) {
    final Paint fillPaint = Paint()..color = sliderTheme.activeTrackColor;
    final Paint outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFb1b3b5)
      ..strokeWidth = 1;
    context.canvas.drawCircle(center, 11, fillPaint);
    context.canvas.drawCircle(center, 11, outlinePaint);
  }
}

class YZSlider extends StatefulWidget {
  YZSlider({
    // @todo: add callbacks
    @required this.initialValue,
    @required this.min,
    @required this.max,
  });

  final double initialValue;
  final double min;
  final double max;

  @override
  _YZSliderState createState() => _YZSliderState();
}

class _YZSliderState extends State<YZSlider> {
  // @todo: optional type?
  double _value;
  bool _hasValue = false;

  @override
  Widget build(BuildContext context) {
    // return Slider(
    //   value: _hasValue ? _value : widget.initialValue,
    //   min: widget.min,
    //   max: widget.max,
    //   onChanged: (double newValue) {
    //     setState(() {
    //       _hasValue = true;
    //       _value = newValue;
    //       // @todo: add callback
    //     });
    //   },
    // );

    return YZSliderStateless(
      value: _hasValue ? _value : widget.initialValue,
      min: widget.min,
      max: widget.max,
      onChanged: (double newValue) {
        setState(() {
          _hasValue = true;
          _value = newValue;
          // @todo: add callback
        });
      },
    );
  }
}

class YZSliderStateless extends StatelessWidget {
  YZSliderStateless({
    this.value,
    this.min,
    this.max,
    // @todo: assert this isn't null otherwise the rendering is janky
    @required this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 22.0,
        trackShape: RoundSliderTrackShape(),
        activeTrackColor: const Color(0xFFfefffe),
        inactiveTrackColor: const Color(0xFFc8c9c8),
        thumbColor: const Color(0xFFfefffe),
        thumbShape: YZCircularThumbShape(),
        overlayShape: null,
        overlayColor: Colors.transparent,
      ),
      child: Slider(
        value: this.value,
        min: this.min,
        max: this.max,
        onChanged: onChanged,
      ),
    );
  }
}
