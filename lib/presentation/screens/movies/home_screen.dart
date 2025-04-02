
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/config/router/app_bottom_tab.dart';
import 'package:movies/config/router/bottom_tabs_config.dart';
import 'package:movies/presentation/utils/custom_docked_fab_location.dart';
import 'package:movies/presentation/widgets/shared/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';
  final String page;

  const HomeScreen({super.key, required this.page});

  double initialOffsetFromCenter({
    required BuildContext context, 
    required int totalItems, 
    int? activeItem = 1 
  }) {

    if( totalItems < 2 ) throw Exception("Total items must be greather or equal 2");

    if( activeItem! > totalItems ) {
      activeItem = totalItems;
    } 

    if( activeItem < 1 ) {
      activeItem = 1;
    }

    final double totalWidth = MediaQuery.of(context).size.width;
    final double startOffsetX = totalWidth / 2;
    final double itemWidth = totalWidth / totalItems;
    final double itemOffsetCenter = itemWidth / 2;

    return -startOffsetX + itemOffsetCenter + ( (activeItem - 1) * itemWidth );
    
  }

  AppBottomTab updateCurrentTab( String page ) {
    // print(page);
    return appTabs.firstWhere(
      (element) => element.route == page,
      orElse: () => appTabs[0],
    );
  }

  @override
  Widget build(BuildContext context) {

    // final ColorScheme colors = Theme.of(context).colorScheme;
    // final location = GoRouterState.of(context).matchedLocation;
    // int currentIndex = 0;
    AppBottomTab activeTab = updateCurrentTab(page);

    return Scaffold(
      extendBody: true,
      // backgroundColor: colors.onPrimaryFixed,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: CustomDockedFabLocation(
        adjustmentX: initialOffsetFromCenter(
          context: context, 
          totalItems: appTabs.length, 
          activeItem: activeTab.index + 1,
        ), 
        adjustmentY: 5
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: false,
        shape: const CircleBorder(),
        onPressed: (){
          // print(MediaQuery.of(context).size.width);
          // Scaffold.geometryOf(context).value;
        },
        tooltip: activeTab.label,
        child: Icon(activeTab.icon, size: 28,),
      ),
      bottomNavigationBar: CustomButtomNavBar(
        currentIndex: activeTab.index,
        onTabChanged: (page) {
          activeTab = updateCurrentTab(page);
          context.go('/home/${activeTab.route}');
        }
      ),
      // body: const HomeView(),
      // body: const SearchView(),
      // body: Placeholder(),
      body: IndexedStack(
        index: activeTab.index,
        children: List.generate(appTabs.length, (index) => appTabs[index].view)
      ),
    );
  }
}
