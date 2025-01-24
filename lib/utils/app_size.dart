import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppSize {
  // tabsize
  static double tabHeight(BuildContext context) =>
      MediaQuery.of(context).padding.top + kToolbarHeight;

  // screen
  static double heightScreen(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double widthScreen(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // space width
  static double spaceWidthS(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.01;
  static double spaceWidthM(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.05;
  static double spaceWidthL(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.1;
  static double spaceWidthL2(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.2;
  static double spaceWidthL3(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.3;
  static double spaceWidthL4(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.4;
  static double spaceWidthL5(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.5;
  static double spaceWidthL6(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.6;
  static double spaceWidthL7(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.7;
  static double spaceWidthL8(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.8;
  static double spaceWidthL9(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.9;

  // space height
  static double spaceHeightS(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.01;
  static double spaceHeightM(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.05;
  static double spaceHeightL(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.1;
  static double spaceHeightL2(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.2;
  static double spaceHeightL3(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.3;
  static double spaceHeightL4(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.4;
  static double spaceHeightL5(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.5;
  static double spaceHeightL6(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.6;
  static double spaceHeightL7(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.7;
  static double spaceHeightL8(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.8;
  static double spaceHeightL9(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.9;

  // font size
  static double fontScreenSmall(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.01;
  static double fontScreenMedium(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.015;
  static double fontScreenLarge(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.02;
  static double fontScreenLargeX2(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.025;
  static double fontScreenLargeX3(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.03;
  static double fontScreenLargeX4(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.035;
  static double fontScreenLargeX5(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.04;

  // static space
  static double space = 5.0;
  static double spaceX1 = 10.0;
  static double spaceX2 = 20.0;
  static double spaceX3 = 30.0;
  static double spaceX4 = 40.0;
  static double spaceX5 = 50.0;
  static double spaceX6 = 60.0;
  static double spaceX7 = 70.0;
  static double spaceX8 = 80.0;
  static double spaceX9 = 90.0;
  static double spaceX10 = 100.0;
  static double spaceX11 = 110.0;
  static double spaceX12 = 120.0;

  // static font size
  static double fontSmall = 12.0;
  static double fontMedium = 14.0;
  static double fontLarge = 16.0;
  static double fontLargeX2 = 18.0;
  static double fontLargeX3 = 20.0;
  static double fontLargeX4 = 22.0;
  static double fontLargeX5 = 24.0;
  static double fontLargeX6 = 26.0;
  static double fontLargeX8 = 28.0;
  static double fontLargeX9 = 30.0;
  static double fontLargeX10 = 32.0;
  static double fontLargeX11 = 34.0;
  static double fontLargeX12 = 36.0;
}

typedef void OnWidgetSizeChange(Size size);

class MeasureSize extends StatefulWidget {
  final Widget child;
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    required Key key,
    required this.onChange,
    required this.child,
  }) : super(key: key);

  @override
  _MeasureSizeState createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize!);
  }
}
