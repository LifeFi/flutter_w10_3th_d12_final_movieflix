import 'package:flutter/material.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/services/movie_api_service.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/views/components/movie_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();
  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();
  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                FutureBuilder(
                  future: popularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        print(snapshot.data?.first.id);
                        return MovieList(
                          type: MovieListType.large,
                          title: 'Popular Movies',
                          movies: snapshot.data!,
                        );
                      } else {
                        return const Center(
                          child: Text('Failed to load data'),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return MovieList(
                          type: MovieListType.medium,
                          title: 'Now in Cinemas',
                          movies: snapshot.data!,
                        );
                      } else {
                        return const Center(
                          child: Text('Failed to load data'),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: comingSoonMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return MovieList(
                          type: MovieListType.medium,
                          title: 'Coming Soon',
                          movies: snapshot.data!,
                        );
                      } else {
                        return const Center(
                          child: Text('Failed to load data'),
                        );
                      }
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
