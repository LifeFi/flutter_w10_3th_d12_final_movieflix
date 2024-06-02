import 'dart:convert';

import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_detail_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/popular");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowPlayingMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/now-playing");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoonMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/coming-soon");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)["results"];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieDetail(int id) async {
    MovieDetailModel movieInstance;
    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic movieJson = jsonDecode(response.body);
      movieInstance = MovieDetailModel.fromJson(movieJson);
      return movieInstance;
    }
    throw Error();
  }
}
