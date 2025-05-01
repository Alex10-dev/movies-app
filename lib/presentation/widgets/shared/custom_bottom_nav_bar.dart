import 'package:flutter/material.dart';
import 'package:movies/config/router/bottom_tabs_config.dart';

class CustomButtomNavBar extends StatelessWidget {

  final int currentIndex;
  final void Function(String) onTabChanged;

  const CustomButtomNavBar({
    super.key, 
    required this.currentIndex, 
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        height: 50,
        padding: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(appTabs.length, (index){

            final tab = appTabs[index];
            final isActive = ( index == currentIndex );

            return Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: IconButton(

                  tooltip: tab.label,
                  iconSize: 30,
                  onPressed: !isActive 
                    ? () => onTabChanged(tab.route)
                    : null, 
                  icon: Icon(
                    tab.icon,
                    color: isActive ? colors.onSurface : colors.outline,
                  ),
                  style: IconButton.styleFrom(
                    iconSize: 30,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            );
          })
        ),
      ),
    );
  }
}



  