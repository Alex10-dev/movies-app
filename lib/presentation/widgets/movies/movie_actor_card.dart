import 'package:flutter/material.dart';

class MovieActorCard extends StatelessWidget {

  final String? imageUrl;
  final EdgeInsetsGeometry margin;
  final double width;
  final String actorName;
  final String? character;

  const MovieActorCard({
    super.key, 
    this.imageUrl, 
    required this.margin, 
    required this.width, 
    required this.actorName, 
    this.character = '',
  });

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Container(
      margin: margin,
      width: width,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                imageUrl == '' ? 'https://picsum.photos/250?image=9' : imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(
            width: double.infinity,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  actorName, 
                  style: TextStyle( 
                    color: colors.onSurface, 
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  character!, 
                  style: TextStyle( 
                    color: colors.outline, 
                    fontSize: 14
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}