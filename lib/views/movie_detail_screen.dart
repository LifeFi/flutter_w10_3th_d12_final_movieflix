import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_detail_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/services/movie_api_service.dart';
import 'package:go_router/go_router.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({
    super.key,
    required this.movieId,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late final Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = ApiService.getMovieDetail(widget.movieId);
  }

  String _formatRuntime(int runtime) {
    final hours = (runtime / 60).floor();
    final minutes = (runtime % 60);
    String result;
    hours > 0 ? result = "${hours}h ${minutes}min" : result = "${minutes}min";
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final movie = snapshot.data!;
                  return Stack(
                    children: [
                      Container(
                        // height: MediaQuery.of(context).size.height,
                        // width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500/${movie.thumb}"),
                              fit: BoxFit.cover),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 1,
                            sigmaY: 1,
                          ),
                          child: Container(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.height * 0.4,
                                ),
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    for (var star in [1, 2, 3, 4, 5])
                                      movie.rating / 2 >= star
                                          ? Icon(
                                              Icons.star,
                                              color: Colors.amber.shade300,
                                            )
                                          : movie.rating / 2 >= star - 0.5
                                              ? Icon(Icons.star_half,
                                                  color: Colors.amber.shade300)
                                              : Icon(
                                                  Icons.star,
                                                  color: Colors.amber
                                                      .withOpacity(0.3),
                                                )
                                  ],
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${_formatRuntime(movie.runtime)} | ",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          for (var i = 0;
                                              i < movie.genres.length;
                                              i++)
                                            Text(
                                              "${movie.genres[i]["name"]}${i + 1 == movie.genres.length ? "" : ", "}",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  "StoryLine",
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  movie.overview,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 100,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.7),
                          child: Container(
                            height: 60,
                            width: size.width * 0.7,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "Buy Ticket",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
          if (context.canPop())
            Positioned(
              top: 75,
              left: 15,
              child: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Back to list",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
