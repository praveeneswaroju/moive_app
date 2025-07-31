import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../stores/bookmark_store.dart';
import '../stores/search_store.dart';
import '../widgets/movie_card.dart';

class SearchPage extends StatefulWidget {
  final BookmarkStore bookmarkStore;

  const SearchPage({super.key, required this.bookmarkStore});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchStore _store = SearchStore();
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = _controller.text.trim();

      if (query.isEmpty) {
        _store.clearResults(); // this clears the results
      } else {
        _store.searchMovies(query); // api call for query
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: Colors.transparent),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: "Search movies..."),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Observer(
              builder: (_) {
                final searchResults = _store.searchResults.value;
                final results = searchResults?.value?.results ?? [];

                if (_store.isSearching) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (results.isEmpty && _controller.text.isNotEmpty) {
                  return const Center(child: Text("No results found."));
                }

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: results.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.80,
                        ),
                    itemBuilder: (context, index) {
                      return MovieCard(
                        movie: results[index],
                        bookmarkStore: widget.bookmarkStore,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
