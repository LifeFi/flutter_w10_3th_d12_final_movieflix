import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/view_models/movies_view_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/views/components/movie_list.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/views/components/theme_switcher.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ThemeSwitcher(),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                movies.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => const Center(
                    child: Text('Failed to load data'),
                  ),
                  data: (moviesByListCategory) {
                    return Column(
                      children: [
                        MovieList(
                          type: MovieListType.large,
                          title: 'Popular Movies',
                          movies:
                              moviesByListCategory[MovieListCategory.popular]!,
                        ),
                        const SizedBox(height: 20),
                        MovieList(
                          type: MovieListType.medium,
                          title: 'Now in Cinemas',
                          movies: moviesByListCategory[
                              MovieListCategory.nowPlaying]!,
                        ),
                        const SizedBox(height: 20),
                        MovieList(
                          type: MovieListType.medium,
                          title: 'Coming Soon',
                          movies: moviesByListCategory[
                              MovieListCategory.comingSoon]!,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
