import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_model.dart';

class MovieService {
  // String apiKey = 'e0124842b865a5bfc6857568d6aef483';
  final String apiKey;
  final String baseUrl = 'https://api.themoviedb.org/3';

  MovieService(this.apiKey);

  Future<List<Movie>> fetchMovies() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        return results
            .map((movieData) => Movie(
                  id: movieData['id'],
                  title: movieData['title'],
                  releaseDate: movieData['release_date'],
                  overview: movieData['overview'],
                  posterUrl:
                      'https://image.tmdb.org/t/p/w185${movieData['poster_path']}',
                  isFavorite: false,
                ))
            .toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
