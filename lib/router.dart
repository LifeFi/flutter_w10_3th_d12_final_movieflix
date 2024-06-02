import 'package:flutter_w10_3th_d12_final_movieflix/views/home_screen.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/views/movie_detail_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: "movies/:movieId",
          builder: (context, state) {
            final movieId = int.parse(state.pathParameters["movieId"]!);
            return MovieDetailScreen(movieId: movieId);
          },
        ),
      ],
    ),
  ],
);
