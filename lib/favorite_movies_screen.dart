import 'package:flutter/material.dart';
import 'movie_model.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  final List<Movie> favoriteMovies;
  final Function saveFavorites;

  FavoriteMoviesScreen({
    required this.favoriteMovies,
    required this.saveFavorites,
  });

  @override
  _FavoriteMoviesScreenState createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: ListView.builder(
        itemCount: widget.favoriteMovies.length,
        itemBuilder: (context, index) {
          final movie = widget.favoriteMovies[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.releaseDate),
            leading: Image.network(movie.posterUrl),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Remove the movie from favorites
                setState(() {
                  widget.favoriteMovies.remove(movie);
                  movie.isFavorite = false;
                  widget.saveFavorites();
                });
              },
            ),
          );
        },
      ),
    );
  }
}
