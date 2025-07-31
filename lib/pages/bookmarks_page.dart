import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/bookmark_store.dart';
import '../widgets/movie_card.dart';

class BookmarksPage extends StatefulWidget {
  final BookmarkStore bookmarkStore;

  const BookmarksPage({super.key, required this.bookmarkStore});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  void initState() {
    super.initState();
    widget.bookmarkStore.loadBookmarks();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Bookmarked Movies'),
      backgroundColor: Colors.transparent,
    ),
    body: Observer(
      builder: (_) {
        final bookMarks = widget.bookmarkStore.bookmarks.value;

        if (bookMarks.isEmpty) {
          return const Center(child: Text('No bookmarks Found!'));
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: bookMarks.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.80,
            ),
            itemBuilder: (context, index) {
              return MovieCard(
                movie: bookMarks[index],
                bookmarkStore: widget.bookmarkStore,
              );
            },
          ),
        );
      },
    ),
  );
}
