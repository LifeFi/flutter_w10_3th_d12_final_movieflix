class MovieModel {
  final String title, thumb;
  final int id;

  MovieModel({
    required this.title,
    required this.thumb,
    required this.id,
  });

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['poster_path'],
        id = json['id'];

  MovieModel copyWith({
    String? title,
    String? thumb,
    int? id,
  }) {
    return MovieModel(
      title: title ?? this.title,
      thumb: thumb ?? this.thumb,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return "MovieModel(title: $title, thumb: $thumb, id: $id)";
  }
}
