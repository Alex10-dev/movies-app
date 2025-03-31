import 'package:flutter/material.dart';

class PreviousMoviesSearched extends StatelessWidget {
  const PreviousMoviesSearched({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final ColorScheme colors = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: <Widget>[
        Icon(Icons.info_outline_rounded, size: 62, color: colors.onSurface),
        Text('No se encontraron búsquedas previas', style: TextStyle(fontSize: 18, color: colors.onSurface),),
        const SizedBox(height: 60,)
      ],
    );
  }
}