
import 'package:flutter/widgets.dart';

class AppBottomTab {

  final int index;
  final String route;
  final IconData icon;
  final String label;
  final Widget view;

  const AppBottomTab({
    required this.index,
    required this.route, 
    required this.icon, 
    required this.label,
    required this.view,
  });

}