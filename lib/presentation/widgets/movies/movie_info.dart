import 'package:flutter/material.dart';
import 'package:movies/presentation/widgets/movies/actors_horizontal_list.dart';


class MovieInfo extends StatelessWidget {
  const MovieInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sinopsis', 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 12),
              Text(
                'Sunt officia ut quis consectetur. Elit voluptate nisi tempor aliqua ipsum. Labore mollit deserunt nostrud excepteur ad. Ullamco elit nostrud voluptate aliquip commodo aliqua est ipsum irure laborum est. Dolor non nostrud fugiat pariatur sunt elit laboris aliqua id proident occaecat ipsum eu. Nisi amet magna nostrud eu eu qui adipisicing reprehenderit.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              )
            ],
          )
        ),
        const ActorsHorizontalList(),
      ],
    );
  }
}