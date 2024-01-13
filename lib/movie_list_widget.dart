import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'favorite_movies_screen.dart';
import 'movie_model.dart';
import 'movie_service.dart';

class MovieListWidget extends StatefulWidget {
  @override
  _MovieListWidgetState createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final MovieService movieService =
      MovieService('e0124842b865a5bfc6857568d6aef483');
  final List<Movie> _favoriteMovies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              _showFavoriteMovies(context);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: movieService.fetchMovies(),
        builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No movies available'));
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final movie = snapshot.data![index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: Image.network(
                          movie.posterUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                movie.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                movie.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: movie.isFavorite
                                    ? Colors.red
                                    : Colors.green,
                              ),
                              onPressed: () {
                                setState(() {
                                  movie.isFavorite = !movie.isFavorite;
                                  if (movie.isFavorite) {
                                    if (!_favoriteMovies.contains(movie)) {
                                      _favoriteMovies.add(movie);
                                    }
                                  } else {
                                    _favoriteMovies.remove(movie);
                                  }
                                  _saveFavorites();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showFavoriteMovies(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteMoviesScreen(
          favoriteMovies: _favoriteMovies,
          saveFavorites: _saveFavorites,
        ),
      ),
    );
  }

  void _saveFavorites() async {}
}
