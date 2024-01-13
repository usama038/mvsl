class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String overview;
  final String posterUrl;
  bool isFavorite;

  Movie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.overview,
    required this.posterUrl,
    this.isFavorite = false,
  });
}
