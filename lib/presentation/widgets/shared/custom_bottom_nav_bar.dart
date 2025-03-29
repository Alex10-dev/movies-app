import 'package:flutter/material.dart';

class CustomButtomNavBar extends StatelessWidget {
  const CustomButtomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // final ColorScheme colors = Theme.of(context).colorScheme;

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
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: IconButton(
                  iconSize: 30,
                  onPressed: (){}, 
                  icon: const Icon(Icons.home_outlined),
                  style: IconButton.styleFrom(
                    iconSize: 30,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: IconButton(
                  iconSize: 30,
                  onPressed: (){}, 
                  icon: const Icon(Icons.home_outlined),
                  style: IconButton.styleFrom(
                    iconSize: 30,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: IconButton(
                  iconSize: 30,
                  onPressed: (){}, 
                  icon: const Icon(Icons.home_outlined),
                  style: IconButton.styleFrom(
                    iconSize: 30,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: IconButton(
                  iconSize: 30,
                  onPressed: (){}, 
                  icon: const Icon(Icons.home_outlined),
                  style: IconButton.styleFrom(
                    iconSize: 30,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



  