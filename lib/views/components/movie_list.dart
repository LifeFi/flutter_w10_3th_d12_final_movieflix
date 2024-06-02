import 'package:flutter/material.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/models/movie_model.dart';
import 'package:flutter_w10_3th_d12_final_movieflix/views/components/interactive_container.dart';
import 'package:go_router/go_router.dart';

enum MovieListType { large, medium }

class MovieList extends StatelessWidget {
  final MovieListType type;
  final String title;
  final List<MovieModel> movies;

  const MovieList({
    super.key,
    required this.type,
    required this.title,
    required this.movies,
  });

  void _goToMovie(String movieId, BuildContext context) {
    context.go("/movies/$movieId");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return InteractiveContainer(
                bottomValue: 0.95,
                topValue: 1.05,
                child: GestureDetector(
                  onTap: () => _goToMovie(movie.id.toString(), context),
                  child: SizedBox(
                    width: type == MovieListType.large ? 340 : 165,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(
                            movie.thumb,
                            width: double.maxFinite,
                            height: type == MovieListType.large ? 250 : 180,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (type != MovieListType.large) ...[
                          const SizedBox(height: 10),
                          Text(
                            movie.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
          ),
        ),
      ],
    );
  }
}
