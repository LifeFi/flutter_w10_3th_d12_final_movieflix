import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_detail_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/repos/movie_repo.dart';

final movieDetailProvider = AsyncNotifierProvider.family
    .autoDispose<MovieDetailViewModel, MovieDetailModel, int>(
  MovieDetailViewModel.new,
);

class MovieDetailViewModel
    extends AutoDisposeFamilyAsyncNotifier<MovieDetailModel, int> {
  late MoviesRepository _moviesRepository;

  Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
    state = const AsyncValue.loading();
    final movieDetail = await _moviesRepository.getMovieDetail(movieId);
    state = AsyncValue.data(movieDetail);
    return movieDetail;
  }

  @override
  FutureOr<MovieDetailModel> build(int arg) async {
    ref.cacheFor(const Duration(seconds: 60));
    ref.onDispose(() {
      print('MovieDetailViewModel[$arg] disposed');
    });
    _moviesRepository = ref.watch(moviesRepo);
    final result = await fetchMovieDetail(arg);
    return result;
  }
}

extension CacheForExtension on AutoDisposeRef<Object?> {
  /// [duration] 동안 provider를 살아있게 유지합니다.
  void cacheFor(Duration duration) {
    // 상태가 즉시 파괴되는 것을 방지
    final link = keepAlive();
    // 기간이 경과하면 자동 폐기를 다시 활성화
    final timer = Timer(duration, link.close);

    // 선택 사항: provider가 다시 계산될 때(예: ref.watch 사용),
    // 보류 중인 타이머를 취소
    onDispose(() {
      timer.cancel();
      print("Canceled Timer");
    });
  }
}
