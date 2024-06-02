import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/repos/movie_repo.dart';

final moviesProvider =
    AsyncNotifierProvider<MoviesViewModel, MoviesByListCategory>(
  MoviesViewModel.new,
);

enum MovieListCategory {
  popular,
  nowPlaying,
  comingSoon,
}

typedef MoviesByListCategory = Map<MovieListCategory, List<MovieModel>>;

class MoviesViewModel extends AsyncNotifier<MoviesByListCategory> {
  late MoviesRepository _moviesRepository;
  late MoviesByListCategory _moviesByListCategory;

  FutureOr<MoviesByListCategory> fetchMovies() async {
    state = const AsyncValue.loading();
    final popularMovies = await _moviesRepository.getPopularMovies();
    final nowPlayingMovies = await _moviesRepository.getNowPlayingMovies();
    final comingSoonMovies = await _moviesRepository.getComingSoonMovies();

    _moviesByListCategory = {
      MovieListCategory.popular: popularMovies,
      MovieListCategory.nowPlaying: nowPlayingMovies,
      MovieListCategory.comingSoon: comingSoonMovies,
    };

    state = AsyncValue.data(_moviesByListCategory);
    // print('MoviesViewModel.fetchMovies: $_moviesByListCategory');
    return _moviesByListCategory;
  }

  @override
  FutureOr<MoviesByListCategory> build() async {
    _moviesRepository = ref.watch(moviesRepo);
    final result = await fetchMovies();
    return result;
  }
}
