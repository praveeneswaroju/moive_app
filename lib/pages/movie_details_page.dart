import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../core/models/movie_list_response.dart';
import '../core/utils/constants.dart';
import '../stores/bookmark_store.dart';

class MovieDetailsPage extends StatelessWidget {
  final Results movie;
  final BookmarkStore bookmarkStore;

  const MovieDetailsPage({
    super.key,
    required this.movie,
    required this.bookmarkStore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Observer(
            builder: (_) {
              final value = bookmarkStore.bookmarks.value;
              final isBookmarked = value.any((m) => m.id == movie.id);

              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Colors.amber : Colors.grey,
                ),
                onPressed: () {
                  bookmarkStore.toggleBookmark(movie);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.posterPath != null)
              Image.network("${Constants.imageBaseUrl}${movie.posterPath}"),
            const SizedBox(height: 16),
            Text(
              movie.title ?? '',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(movie.overview ?? "No description"),
          ],
        ),
      ),
    );
  }
}
