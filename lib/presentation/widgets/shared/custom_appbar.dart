import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: <Widget>[
    
              Icon(
                Icons.movie_creation_outlined,
                color: colors.primary
              ),
              
              const SizedBox( width: 10,),
              
              Text('Movies app', style: titleStyle,),
    
              const Spacer(),
    
              IconButton(
                onPressed: (){}, 
                icon: const Icon(Icons.search)
              ),
    
            ],
          ),
        ),
      );
  }
}