
import 'package:go_router/go_router.dart';
import 'package:movies/presentation/screens/screens.dart';

final appRouter = GoRouter(

  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'movie/:id',
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return HomeScreen(movieId: movieId);
          },
        )
      ]
    )
  ]
);