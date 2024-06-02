class MovieDetailModel {
  final String title, thumb, overview;
  final int id, runtime;
  final double rating;
  final List<dynamic> genres;

  MovieDetailModel({
    required this.title,
    required this.thumb,
    required this.overview,
    required this.id,
    required this.runtime,
    required this.rating,
    required this.genres,
  });

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        id = json['id'],
        runtime = json['runtime'],
        genres = json['genres'],
        // rating = json['vote_average'] is int
        //     ? json['vote_average'].toDouble()
        //     : json['vote_average'],
        rating = json['vote_average'] + 0.0,
        overview = json['overview'];

  MovieDetailModel copyWith({
    String? title,
    String? thumb,
    String? overview,
    int? id,
    int? runtime,
    double? rating,
    List<dynamic>? genres,
  }) {
    return MovieDetailModel(
      title: title ?? this.title,
      thumb: thumb ?? this.thumb,
      overview: overview ?? this.overview,
      id: id ?? this.id,
      runtime: runtime ?? this.runtime,
      rating: rating ?? this.rating,
      genres: genres ?? this.genres,
    );
  }

  @override
  String toString() {
    return "MovieDetailModel(title: $title, thumb: $thumb, overview: $overview, id: $id, runtime: $runtime, rating: $rating, genres: $genres)";
  }
}
