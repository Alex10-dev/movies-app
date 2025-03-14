import 'package:flutter/material.dart';

class MovieActorCard extends StatelessWidget {

  final String? imageUrl;

  const MovieActorCard({
    super.key, 
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Image.network(
        imageUrl == '' ? 'https://picsum.photos/250?image=9' : imageUrl!,
        fit: BoxFit.cover,
      ),
    );
  }
}