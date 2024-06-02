class MovieDetailModel {
  final String title, thumb, overview;
  final int id, runtime;
  final double rating;
  final List<dynamic> genres;

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
}
