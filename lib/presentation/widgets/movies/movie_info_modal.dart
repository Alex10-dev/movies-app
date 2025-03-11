import 'package:flutter/material.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/widgets/movies/movie_info.dart';

class MovieInfoModal extends StatelessWidget {
  const MovieInfoModal({
    super.key,
    required this.movie, 
    required this.child,
  });

  final Movie movie;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTap: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          useSafeArea: true,
          context: context, 
          backgroundColor: Colors.white,
          builder: (BuildContext context) {
            return Stack(
              children: <Widget>[
    
                Column(
                  children: <Widget>[

                    Container(
                      color: Colors.amber,
                      height: 320,
                      width: double.infinity,
                      child: Image.network(
                        movie.backdropLink,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const _MovieTabsContainer(),

                  ],
                )
    
              ],
            );
          },
        );
      },
    );
  }
}

class _MovieTabsContainer extends StatelessWidget {
  const _MovieTabsContainer();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: const DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            children: <Widget>[
          
              TabBar(
                indicatorColor: Colors.black,
                tabs: <Tab>[
                  Tab(text: 'Información'),
                  Tab(text: 'Entradas'),
                ],
              ),
          
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: MovieInfo(),
                    ),
                    Center(child: Text('Information 2')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}