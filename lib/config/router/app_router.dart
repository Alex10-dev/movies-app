
import 'package:go_router/go_router.dart';
import 'package:movies/presentation/screens/movies/movie_info_screen.dart';
import 'package:movies/presentation/screens/screens.dart';

final appRouter = GoRouter(

  initialLocation: '/home/explore',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final page = state.pathParameters['page'] ?? 'explore';
        return HomeScreen( page: page );
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieInfoScreen(movieId: movieId);
          },
        )
      ]
    ),

    GoRoute(
      path: '/',
      redirect: (_, __) => '/home/explore',
    )
  ]

);