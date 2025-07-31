import 'package:flutter/material.dart';
import '../core/models/movie_list_response.dart';
import '../core/utils/constants.dart';
import '../pages/movie_details_page.dart';
import '../stores/bookmark_store.dart';

class MovieCard extends StatelessWidget {
  final Results movie;
  final BookmarkStore bookmarkStore;

  const MovieCard({
    super.key,
    required this.movie,
    required this.bookmarkStore,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => MovieDetailsPage(
                    movie: movie,
                    bookmarkStore: bookmarkStore,
                  ),
            ),
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 200,
          child:
              movie.posterPath != null
                  ? Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    '${Constants.imageBaseUrl}${movie.posterPath}',
                  )
                  : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
