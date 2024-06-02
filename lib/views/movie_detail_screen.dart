import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_detail_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/utils.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/view_models/movie_detail_view_model.dart';
import 'package:go_router/go_router.dart';

class MovieDetailScreen extends ConsumerStatefulWidget {
  final int movieId;
  final String? category;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
    this.category,
  });

  @override
  ConsumerState<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends ConsumerState<MovieDetailScreen> {
  late final Future<MovieDetailModel> movieDetail;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          ref.watch(movieDetailProvider(widget.movieId)).when(
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => const Center(
                  child: Text('Failed to load data'),
                ),
                data: (movie) {
                  // print("${movie.id}_${widget.category}");
                  return Stack(
                    children: [
                      Hero(
                        tag: "${movie.id}_${widget.category}",
                        child: Image.network(
                          movie.thumb,
                          height: size.height,
                          width: size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 1,
                          sigmaY: 1,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
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
                                  height: size.height * 0.35,
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
                                        "${formatRuntime(movie.runtime)} | ",
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
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: AlignmentDirectional.bottomCenter,
                              end: AlignmentDirectional.topCenter,
                              colors: [
                                Colors.black.withOpacity(1),
                                Colors.black.withOpacity(0.9),
                                Colors.black.withOpacity(0.8),
                                Colors.black.withOpacity(0.3),
                              ],
                            ),
                          ),
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
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
