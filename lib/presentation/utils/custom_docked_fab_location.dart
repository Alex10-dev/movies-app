import 'package:flutter/material.dart';

class CustomDockedFabLocation extends StandardFabLocation with FabCenterOffsetX, FabDockedOffsetY {
  
  final double? adjustmentX;
  final double? adjustmentY;

  CustomDockedFabLocation({
    this.adjustmentX = 0, 
    this.adjustmentY = 0,
  });
  
  @override
  double getOffsetX(ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {

    //final double directionalAdjustment = scaffoldGeometry.textDirection == TextDirection.ltr ? adjustmentX!*(-1) : adjustmentX!;
    final double directionalAdjustment = adjustmentX!;
    return super.getOffsetX(scaffoldGeometry, adjustment) + directionalAdjustment;
  }

  @override
  double getOffsetY(ScaffoldPrelayoutGeometry scaffoldGeometry, double adjustment) {
    // print(scaffoldGeometry.minInsets);
    final double directionalAdjustment =  adjustmentY!;
    return super.getOffsetY(scaffoldGeometry, adjustment) + directionalAdjustment;
  }

}