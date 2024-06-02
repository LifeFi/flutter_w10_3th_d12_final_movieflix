import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/views/home_screen.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/views/movie_detail_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: "movies/:movieId",
          builder: (context, state) {
            final movieId = int.parse(state.pathParameters["movieId"]!);
            final category = state.uri.queryParameters["category"];
            final movie = state.extra as MovieModel?;

            return MovieDetailScreen(
              movieId: movieId,
              category: category,
              movie: movie,
            );
          },
        ),
      ],
    ),
  ],
);
