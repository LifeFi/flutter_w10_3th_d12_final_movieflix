import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_detail_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesRepository {
  final String _baseUrl = "https://movies-api.nomadcoders.workers.dev";
  final String _imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$_baseUrl/popular");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie).copyWith(
          thumb: "$_imageBaseUrl/${movie["poster_path"]}",
        );
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  Future<List<MovieModel>> getNowPlayingMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$_baseUrl/now-playing");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie).copyWith(
          thumb: "$_imageBaseUrl/${movie["poster_path"]}",
        );
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  Future<List<MovieModel>> getComingSoonMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$_baseUrl/coming-soon");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie).copyWith(
          thumb: "$_imageBaseUrl/${movie["poster_path"]}",
        );
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  Future<MovieDetailModel> getMovieDetail(int id) async {
    final url = Uri.parse("$_baseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic movieJson = jsonDecode(response.body);
      final movieInstance = MovieDetailModel.fromJson(movieJson).copyWith(
        thumb: "$_imageBaseUrl/${movieJson["poster_path"]}",
      );
      return movieInstance;
    }
    throw Error();
  }
}

final moviesRepo = Provider(
  (ref) => MoviesRepository(),
);
