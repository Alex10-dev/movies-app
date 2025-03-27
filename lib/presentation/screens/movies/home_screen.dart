
import 'package:flutter/material.dart';
import 'package:movies/presentation/Views/movies/home_view.dart';
import 'package:movies/presentation/utils/custom_docked_fab_location.dart';
import 'package:movies/presentation/widgets/shared/custom_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  final String? movieId;

  const HomeScreen({super.key, this.movieId});

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

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
      extendBody: true,
      backgroundColor: colors.primary,
      body: HomeView(movieId: movieId),
      floatingActionButtonLocation: CustomDockedFabLocation(
        adjustmentX: initialOffsetFromCenter(context: context, totalItems: 4, activeItem: 4), 
        adjustmentY: 5
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: false,
        shape: const CircleBorder(),
        onPressed: (){
          // print(MediaQuery.of(context).size.width);
          // Scaffold.geometryOf(context).value;
        },
        tooltip: 'Search movie',
        child: const Icon(Icons.search_outlined, size: 28,),
      ),
      bottomNavigationBar: const CustomButtomNavBar(),
    );
  }
}
